import random
from django.shortcuts import render
from rest_framework_jwt.views import ObtainJSONWebToken
from fuguangapi.utils.tencentcloudapi import TencentCloudAPI, TencentCloudSDKException
from rest_framework.response import Response
from rest_framework import status
from django.conf import settings
from rest_framework.views import APIView
from .models import User
from rest_framework.generics import CreateAPIView
from .serializers import UserRegisterModelSerializer
from fuguangapi.utils.ronglianyunapi import send_sms
from django_redis import get_redis_connection
# Create your views here.


class LoginAPIView(ObtainJSONWebToken):
    """用户登录视图"""
    def post(self, request, *args, **kwargs):
        # 校验用户操作验证码成功以后的ticket临时票据
        try:
            api = TencentCloudAPI()
            result = api.captcha(
                request.data.get("ticket"),
                request._request.META.get("REMOTE_ADDR"),
                request.data.get("randstr")
            )
            if result:
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
        send_sms(settings.RONGLIANYUN.get("reg_tid"), mobile, datas=(code, time // 60))
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
