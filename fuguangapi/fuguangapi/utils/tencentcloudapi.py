import json
from tencentcloud.common import credential
from tencentcloud.common.profile.client_profile import ClientProfile
from tencentcloud.common.profile.http_profile import HttpProfile
from tencentcloud.common.exception.tencent_cloud_sdk_exception import TencentCloudSDKException
from tencentcloud.captcha.v20190722 import captcha_client, models
from django.conf import settings


class TencentCloudAPI(object):
    """腾讯云API操作工具类"""
    def __init__(self):
        self.cred = credential.Credential(settings.TENCENTCLOUD["SecretId"], settings.TENCENTCLOUD["SecretKey"])

    def captcha(self, ticket, user_ip, randstr):
        """
        验证码校验工具方法
        :ticket 客户端验证码操作成功以后得到的临时验证票据
        :user_ip 客户端的IP地址
        :randstr 客户端验证码操作成功以后得到的随机字符串
        """
        Captcha = settings.TENCENTCLOUD["Captcha"]

        params = {
            # 验证码类型固定为9 固定填值：9。可在控制台配置不同验证码类型。
            "CaptchaType": Captcha["CaptchaType"],
            # 客户端提交的临时票据  前端回调函数返回的用户验证票据
            "Ticket": ticket,
            # 客户端IP地址  业务侧获取到的验证码使用者的外网IP
            "UserIp": user_ip,
            # 随机字符串  前端回调函数返回的随机字符串
            "Randstr": randstr,
            # 验证码应用ID  验证码应用ID
            "CaptchaAppId": Captcha["CaptchaAppId"],
            # 验证码应用key 用于服务器端校验验证码票据的验证密钥，请妥善保密，请勿泄露给第三方
            "AppSecretKey": Captcha["AppSecretKey"]
        }

        # 实例化http请求工具类
        httpProfile = HttpProfile()
        # 设置API所在服务器域名
        httpProfile.endpoint = Captcha["endpoint"]
        # 实例化客户端工具类
        clientProfile = ClientProfile()
        clientProfile.httpProfile = httpProfile
        # 实例化验证码服务端请求工具的客户端对象
        client = captcha_client.CaptchaClient(self.cred, "", clientProfile)
        # 客户端对象参数的初始化和发送请求
        req = models.DescribeCaptchaResultRequest()
        req.from_json_string(json.dumps(params))
        # 获取请求结果
        resp = client.DescribeCaptchaResult(req)
        # 把结果转换成json格式
        result = json.loads(resp.to_json_string())

        return result and result.get("CaptchaCode") == 1




# try:
#     cred = credential.Credential("SecretId", "SecretKey")
#     httpProfile = HttpProfile()
#     httpProfile.endpoint = "captcha.tencentcloudapi.com"
#
#     clientProfile = ClientProfile()
#     clientProfile.httpProfile = httpProfile
#     client = captcha_client.CaptchaClient(cred, "", clientProfile)
#
#     req = models.DescribeCaptchaResultRequest()
#     params = {
#         "CaptchaType": 9,
#         "Ticket": "\"t03S0sV04msk10V7F_7xaA-M91czl24QTpWvsKPy_acSLyJjNvVxDLafXyRvj_XlUyHcce1nyiKflMTefHTLM9wW87cBjRtHUypb-AnMYL7ffrvRQBuNXEr3g**\"",
#         "UserIp": "127.0.0.1",
#         "Randstr": "\"@UR9\"",
#         "CaptchaAppId": 2071744404,
#         "AppSecretKey": "02DN3yBANi1xeXI-BQitJug**"
#     }
#     req.from_json_string(json.dumps(params))
#
#     resp = client.DescribeCaptchaResult(req)
#     print(resp.to_json_string())
#
# except TencentCloudSDKException as err:
#     print(err)