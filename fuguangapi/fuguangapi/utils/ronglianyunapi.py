import json
from ronglian_sms_sdk import SmsSDK
from django.conf import settings


def send_sms(tid, mobile, datas):
    """
    发送短信
    @params tid: 模板ID，默认测试使用1
    @params mobile: 接收短信的手机号，多个手机使用逗号隔开
        单个号码: mobile="13312345678"
        多个号码: mobile="13312345678,13312345679,......"
    @params datas: 短信模板的参数列表
        例如短信模板为: 【云通讯】您的验证码是{1}，请于{2}分钟内正确输入。其中{1}和{2}为短信模板参数。
        则datas=("123456",5,)
    """
    ronglianyun = settings.RONGLIANYUN
    # 初始化SDK
    sdk = SmsSDK(ronglianyun.get("accId"), ronglianyun.get("accToken"), ronglianyun.get("appId"))
    #  调用发送短信方法
    # 参数	     类型	说明
    # tid	    String	短信模板 ID
    # mobile	String	发送手机号，多个以英文逗号分隔，最多 200 个号码
    # datas	    tuple	替换短信模板占位符的内容变量
    resp = sdk.sendMessage(tid, mobile, datas)
    response = json.loads(resp)
    print(response, type(response))
    # statusCode	String	状态码，000000 为发送成功
    return response.get("statusCode") == "000000"




# accId = '容联云通讯分配的主账号ID'
# accToken = '容联云通讯分配的主账号TOKEN'
# appId = '容联云通讯分配的应用ID'
#
#
# def send_message():
#     sdk = SmsSDK(accId, accToken, appId)
#     tid = '容联云通讯创建的模板ID'
#     mobile = '手机号1,手机号2'
#     datas = ('变量1', '变量2')
#     resp = sdk.sendMessage(tid, mobile, datas)
#     print(resp)