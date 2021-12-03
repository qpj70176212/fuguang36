import constants, json
from drf_haystack.viewsets import HaystackViewSet
from drf_haystack.filters import HaystackFilter
from rest_framework.generics import ListAPIView, RetrieveAPIView
from .models import CourseDirection, CourseCategory, Course
from .serializers import CourseDirectionModelSerializer, CourseCategoryModelSerializer, CourseModelSerializer, \
    CourseIndexHaystackSerializer, CourseRetrieveModelSerializer
from rest_framework.filters import OrderingFilter
from .paginations import CourseListPageNumberPagination
from django_redis import get_redis_connection
from rest_framework.views import APIView
from rest_framework.response import Response
from datetime import datetime, timedelta
from rest_framework.viewsets import ViewSet
from rest_framework.permissions import IsAuthenticated
from django.conf import settings
from fuguangapi.libs.polyv import PolyvPlayer
# Create your views here.


class CourseDirectionListAPIView(ListAPIView):
    """学习方向的视图"""
    queryset = CourseDirection.objects.filter(is_show=True, is_delete=False).order_by("orders", "id")
    serializer_class = CourseDirectionModelSerializer
    pagination_class = None


class CourseCategoryListAPIView(ListAPIView):
    """学习课程分类列表"""
    # queryset = CourseCategory.objects.filter(is_show=True, is_delete=False).order_by("orders", "-id")
    serializer_class = CourseCategoryModelSerializer
    pagination_class = None

    def get_queryset(self):
        """重写获取课程分类的查询集方法"""
        print(self.kwargs)  # 获取路由中声明的路径参数
        direction = int(self.kwargs.get("direction", 0))
        queryset = CourseCategory.objects.filter(is_show=True, is_delete=False).order_by("orders", "id")

        # 只有在学习方向大于0的情况下才进行过滤
        if direction > 0:
            queryset = queryset.filter(direction=direction)

        return queryset.all()


class CourseListAPIView(ListAPIView):
    """课程列表接口"""
    serializer_class = CourseModelSerializer
    filter_backends = [OrderingFilter, ]
    ordering_fields = ['id', 'students', 'orders']
    pagination_class = CourseListPageNumberPagination

    def get_queryset(self):
        """列表页数据"""
        direction = int(self.kwargs.get("direction", 0))
        category = int(self.kwargs.get("category", 0))

        queryset = Course.objects.filter(is_delete=False, is_show=True).order_by("orders", "id")
        # 只有在学习方向大于0的情况下才进行学习方向的过滤
        if direction > 0:
            queryset = queryset.filter(direction=direction)
        # 只有在课程分类大于0的情况下才进行课程分类的过滤
        if category > 0:
            queryset = queryset.filter(category=category)

        return queryset.all()


class CourseSearchViewSet(HaystackViewSet):
    # 指定本次搜索的最终真实数据的保存模型
    index_models = [Course]
    serializer_class = CourseIndexHaystackSerializer
    # 过滤
    filter_backends = [OrderingFilter, HaystackFilter]
    # 排序
    ordering_fields = ("id", "students", "orders")
    # 分页
    pagination_class = CourseListPageNumberPagination

    # ListModelMixin类源码中有list方法 重写该方法
    def list(self, request, *args, **kwargs):
        # 获取redis
        redis = get_redis_connection("hot_word")
        # 提取text
        text = request.query_params.get("text")
        if text:
            key = f"{constants.DEFAULT_HOT_WORD}:{datetime.now().strftime('%Y:%m:%d')}"
            is_exists = redis.exists(key)
            # Redis Zincrby 命令对有序集合中指定成员的分数加上增量 increment
            redis.zincrby(key, 1, text)
            if not is_exists:
                # 设置有效期7天
                redis.expire(key, constants.HOT_WORD_EXPIRE * 24 * 3600)

        return super().list(request, *args, **kwargs)


class HotWordAPIView(APIView):
    """搜索热词"""
    def get(self, request):
        redis = get_redis_connection("hot_word")
        # 获取最近指定天数的热词的key
        date_list = []
        # """返回前7天日期列表"""
        for i in range(0, constants.HOT_WORD_EXPIRE):
            day = datetime.now() - timedelta(days=i)
            key = f"{constants.DEFAULT_HOT_WORD}:{day.year}:{day.month}:{day.day}"
            date_list.append(key)

        # 先删除原有的统计最近几天的热搜词的有序统计集合
        redis.delete(constants.DEFAULT_HOT_WORD)
        # ZUNIONSTORE hot_word 7 "hot_word:2021:11:22" "hot_word:2021:11:21"  "hot_word:2021:11:20" "hot_word:2021:11:19" "hot_word:2021:11:18" "hot_word:2021:11:17" "hot_word:2021:11:16"
        # 根据date_list找到最近指定天数的所有集合，并完成并集计算，产生新的有序统计集合constants.DEFAULT_HOT_WORD
        # Redis Zunionstore 命令计算给定的一个或多个有序集的并集，其中给定 key 的数量必须以 numkeys 参数指定，并将该并集(结果集)储存到 destination 。
        redis.zunionstore(constants.DEFAULT_HOT_WORD, date_list, aggregate="sum")
        # 按分数store进行倒序显示排名靠前的指定数量的热词
        # Redis Zrevrange 命令返回有序集中，指定区间内的成员。
        # 其中成员的位置按分数值递减(从大到小)来排列。 ZREVRANGE key start stop [WITHSCORES]
        word_list = redis.zrevrange(constants.DEFAULT_HOT_WORD, 0, constants.HOT_WORD_LENGTH-1)
        return Response(word_list)


class CourseRetrieveAPIView(RetrieveAPIView):
    """课程详情信息"""
    queryset = Course.objects.filter(is_delete=False, is_show=True).all()
    serializer_class = CourseRetrieveModelSerializer


class CourseTypeListAPIView(APIView):
    """课程类型"""

    def get(self, request):
        # Object of type DeferredAttribute is not JSON serializable
        # 因为属性重名故改为大写
        return Response(Course.COURSE_TYPE)


class PolyvViewSet(ViewSet):
    """保利威云视频服务相关的API接口"""
    permission_classes = [IsAuthenticated]

    def token(self, request, vid):
        """获取视频播放的授权令牌token"""
        userId = settings.POLYV["userId"]
        secretkey = settings.POLYV["secretkey"]
        tokenUrl = settings.POLYV["tokenUrl"]
        polyv = PolyvPlayer(userId, secretkey, tokenUrl)

        user_ip = request.META.get("REMOTE_ADDR")  # 客户端的IP地址
        user_id = request.user.id  # 用户ID
        user_name = request.user.username  # 用户名

        token = polyv.get_video_token(vid, user_ip, user_name)

        return Response({"token": token})


