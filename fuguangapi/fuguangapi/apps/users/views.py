import random
from django.shortcuts import render
from rest_framework_jwt.views import ObtainJSONWebToken
from fuguangapi.utils.tencentcloudapi import TencentCloudAPI, TencentCloudSDKException
from rest_framework.response import Response
from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from django.conf import settings
from rest_framework.views import APIView
from .models import User, UserCourse, StudyProgress
from rest_framework.generics import CreateAPIView, ListAPIView,  GenericAPIView
from .serializers import UserRegisterModelSerializer, UserCourseModelSerializer
from fuguangapi.utils.ronglianyunapi import send_sms
from django_redis import get_redis_connection
# from mycelery.sms.tasks import send_sms
from .tasks import send_sms
from courses.paginations import CourseListPageNumberPagination
from courses.models import Course, CourseLesson
import constants
from django.db import transaction
# Create your views here.


class LoginAPIView(ObtainJSONWebToken):
    """用户登录视图"""
    def post(self, request, *args, **kwargs):
        if settings.IS_TEST:
            return super().post(request, *args, **kwargs)

        # 校验用户操作验证码成功以后的ticket临时票据
        try:
            api = TencentCloudAPI()
            result = api.captcha(
                request.data.get("ticket"),
                request._request.META.get("REMOTE_ADDR"),
                request.data.get("randstr")
            )
            if result:
            # if result or settings.IS_TEST:
                # 登录实现代码，调用父类实现的登录视图方法
                return super().post(request, *args, **kwargs)
            # 如果返回值不是True，则表示验证失败
            raise TencentCloudSDKException
        except TencentCloudSDKException as err:
            return Response({"errmsg": "验证码校验失败！"}, status=status.HTTP_400_BAD_REQUEST)


class MobileAPIView(APIView):
    def get(self, request, mobile):
        """
        校验手机号是否已注册
        :parm request:
        :param mobile: 手机号
        :return:
        """
        try:
            User.objects.get(mobile=mobile)
            return Response({"errmsg": "当前手机号已注册"}, status=status.HTTP_400_BAD_REQUEST)
        except User.DoesNotExist:
            # 如果查不到该手机号的注册记录，则证明手机号已经注册使用
            return Response({"errmsg": "OK"}, status=status.HTTP_200_OK)


class UserAPIView(CreateAPIView):
    """用户注册"""
    queryset = User.objects.all()
    serializer_class = UserRegisterModelSerializer


# /users/sms/(?P<mobile>1[3-9]\d{9}
class SMSAPIView(APIView):
    def get(self, request, mobile):
        """发送短信验证码"""
        redis = get_redis_connection("sms_code")
        # 判断手机短信是否处于发送冷却中【60秒只能发送一条】
        # Redis TTL 命令以秒为单位返回 key 的剩余过期时间
        # 当 key 不存在时，返回 -2 。 当 key 存在但没有设置剩余生存时间时，返回 -1 。 否则，以秒为单位，返回 key 的剩余生存时间。
        interval = redis.ttl(f"interval_{mobile}")
        # 如果不等于-2 没有过期  参数问题
        if interval != -2:
            return Response({"errmsg": f"短信发送过于频繁，请{interval}秒后再次点击获取！", "time": interval},
                            status=status.HTTP_400_BAD_REQUEST)
        # %06d :  整数输出,整数的宽度是6位,若不足6位,左边补数字"0"
        # %是格式化输入接受参数的标记
        # 0格式化命令：结果将用零来填充
        # 6：填充位数
        # d：代表十进制 数据
        # 生成一个6位随机数
        code = "%06d" % random.randint(0, 999999)
        # 时间 短信有效期
        time = settings.RONGLIANYUN.get("sms_expire")
        # 发送短信
        # 同步任务
        # send_sms(settings.RONGLIANYUN.get("reg_tid"), mobile, datas=(code, time // 60))
        # 异步任务
        send_sms.delay(settings.RONGLIANYUN.get("reg_tid"), mobile, datas=(code, time // 60))
        # 记录code到redis中
        # 使用redis提供的管道对象pipeline来优化redis的写入操作【添加、修改、删除】
        pipe = redis.pipeline()
        # MULTI 标记一个事务块的开始
        pipe.multi()  # 开启事务
        pipe.setex(f"sms_{mobile}", time, code)
        pipe.setex(f"interval_{mobile}", settings.RONGLIANYUN.get("sms_interval"), "_")
        # import sys
        # sys.setrecursionlimit(1000000)
        pipe.execute()  # 提交事务，同时把暂存在pipeline的数据一次性提交给redis

        return Response({"errmsg": "OK"}, status=status.HTTP_200_OK)


class CourseListAPIView(ListAPIView):
    """当前用户的课程列表信息"""
    permission_classes = [IsAuthenticated]
    serializer_class = UserCourseModelSerializer
    pagination_class = CourseListPageNumberPagination

    def get_queryset(self):
        user = self.request.user
        query = UserCourse.objects.filter(user=user)
        course_type = int(self.request.query_params.get("type", -1))
        course_type_list = [item[0] for item in Course.COURSE_TYPE]
        if course_type in course_type_list:
            query = query.filter(course__course_type=course_type)
        return query.order_by("-id").all()


class UserCourseAPIView(GenericAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = UserCourseModelSerializer

    def get(self, request, course_id):
        """获取用户在当前课程的学习进度"""
        user = request.user

        try:
            user_course = UserCourse.objects.get(user=user, course=course_id)
        except UserCourse.DoesNotExist:
            return Response({"error": "当前课程您尚未购买！"}, status=status.HTTP_400_BAD_REQUEST)

        # 用户对于当前课程的最后学习章节ID
        chapter_id = user_course.chapter_id
        if chapter_id:
            """曾经学习过本课程，提取最后的学习课程ID"""
            lesson = user_course.lesson
        else:
            """从未学习当前课程"""
            # 获取当前课程第1个章节
            chapter = user_course.course.chapter_list.order_by("orders").first()
            # 获取当前章节第1个课时
            lesson = chapter.lesson_list.order_by("orders").first()
            # 保存本次学习起始进度
            user_course.chapter = chapter
            user_course.lesson = lesson
            user_course.save()

        serializer = self.get_serializer(user_course)
        data = serializer.data
        # 获取当前课时的课时类型和课时链接[加密视频返回的是vid]
        data["lesson_type"] = lesson.lesson_type
        data["lesson_link"] = lesson.lesson_link

        return Response(data)


class StudyLessonAPIView(APIView):
    """用户在当前课时的学习时间进度"""
    permission_classes = [IsAuthenticated]

    def get(self, request):
        lesson_id = int(request.query_params.get("lesson"))
        user = request.user

        # 查找课时
        lesson = CourseLesson.objects.get(pk=lesson_id)

        progress = StudyProgress.objects.filter(user=user, lesson=lesson).first()

        # 如果查询没有进度，则默认进度进度为0
        if progress is None:
            progress = StudyProgress.objects.create(
                user=request.user,
                lesson=lesson,
                study_time=0
            )

        return Response(progress.study_time)


class StudyProgressAPIView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        """添加课时学习进度"""
        try:
            # 1. 接受客户端提交的视频进度和课时ID
            study_time = int(request.data.get("time"))
            lesson_id = int(request.data.get("lesson"))
            user = request.user

            # 判断本次更新学习时间是否超出阈值
            if study_time > constants.MAV_SEEK_TIME:
                raise Exception

            # 查找课时
            lesson = CourseLesson.objects.get(pk=lesson_id)

        except:
            return Response({"error": "无效的参数或当前课程信息不存在！"})

        with transaction.atomic():
            save_id = transaction.savepoint()
            try:
                # 2. 记录课时学习进度
                progress = StudyProgress.objects.filter(user=user, lesson=lesson).first()

                if progress is None:
                    """新增一条用户与课时的学习记录"""
                    StudyProgress.objects.create(
                        user=user,
                        lesson=lesson,
                        study_time=study_time
                    )
                else:
                    """直接更新现有的学习时间"""
                    progress.study_time = int(progress.study_time) + int(study_time)
                    progress.save()

                # 3. 记录课程学习的总进度
                user_course = UserCourse.objects.get(user=user, course=lesson.course)
                user_course.study_time = int(user_course.study_time) + int(study_time)
                # 用户如果往后观看章节，则记录下
                if lesson.chapter.orders > user_course.chapter.orders:
                    user_course.chapter = lesson.chapter
                # 用户如果往后观看课时，则记录下
                if lesson.orders > user_course.lesson.orders:
                    user_course.lesson = lesson

                user_course.save()

                return Response({"message": "课时学习进度更新完成！"})

            except Exception as e:
                print(f"error={e}")
                transaction.savepoint_rollback(save_id)
                return Response({"error": "当前课时学习进度丢失！"})