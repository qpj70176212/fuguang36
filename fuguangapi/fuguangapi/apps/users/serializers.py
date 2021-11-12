import re, constants
from rest_framework import serializers
from rest_framework_jwt.settings import api_settings
from .models import User


class UserRegisterModelSerializer(serializers.ModelSerializer):
    """
    用户注册的序列化器
    """
    re_password = serializers.CharField(required=True, write_only=True)
    sms_code = serializers.CharField(min_length=4, max_length=6, required=True, write_only=True)
    token = serializers.CharField(read_only=True)

    class Meta:
        model = User
        fields = ["mobile", "password", "re_password", "sms_code", "token"]
        extra_kwargs = {
            "mobile": {
                "required": True,
                "write_only": True
            },
            "password": {
                "required": True,
                "write_only": True,
                "min_length": 6,
                "max_length": 16
            }
        }

    def validate(self, attrs):
        """验证客户端数据"""
        # 手机号格式验证
        mobile = attrs.get("mobile", None)
        if not re.match("^1[3-9]\d{9}$", mobile):
            raise serializers.ValidationError(detail="手机号格式不正确！", code="mobile")
        # 密码和确认密码
        password = attrs.get("password")
        re_password = attrs.get("re_password")
        if password != re_password:
            raise serializers.ValidationError(detail="密码和确认密码不一致！", code="password")
        # 手机号是否已注册
        try:
            User.objects.get(mobile=mobile)
            raise serializers.ValidationError(detail="手机号码已注册！")
        except User.DoesNotExist:
            pass

        # todo 验证短信验证码

        return attrs

    def create(self, validated_data):
        """保存用户信息，完成注册"""
        mobile = validated_data.get("mobile")
        password = validated_data.get("password")

        user = User.objects.create_user(
            username=mobile,
            mobile=mobile,
            avatar=constants.DEFAULT_USER_AVATAR,
            password=password,
        )

        # 注册成功以后免登陆
        jwt_payload_handler = api_settings.JWT_PAYLOAD_HANDLER
        jwt_encode_handler = api_settings.JWT_ENCODE_HANDLER
        payload = jwt_payload_handler(user)
        user.token = jwt_encode_handler(payload)

        return user