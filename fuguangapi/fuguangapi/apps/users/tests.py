from django.test import TestCase  # 测试基类，基于这个类，可以编写测试类，用于测试代码的编写
from django.contrib.auth import get_user_model  # 获取当前测试需要使用到的模型类
# 基于drf框架编写的restfulAPI接口，drf默认提供了一个发送http的客户端工具类，方便请求视图接口
from rest_framework.test import APIClient
# 接口在执行以后，可通过http状态码来表达接口的操作结果是成功还是失败，为方便判断，引入drf提供的状态码文件
from rest_framework import status
# Create your tests here.

# 编写测试的接口地址
TOKEN_URL = "/users/login/"
MOBILE_URL = "/users/mobile/"
REGISTER_URL = "/users/register/"
SMS_URL = "/users/sms/"

# 测试是不会使用原来数据库的，django会为测试单独生成数据库
# 不管你的测试是否通过，当所有的测试都执行过后，这个测试数据就会被销毁


def create_user(**params):
    return get_user_model().objects.create_user(**params)


# 编写测试用例的类，测试类必须直接或间接继承于django.test.TestCase测试基类
# 这种测试类一般在测试中，也叫“测试集”
class MobileTestCase(TestCase):
    """手机号验证相关接口的测试集"""
    def setUp(self):
        # 相当于 __init__ ，setUp会在测试开始的时候，自动执行这里的代码
        self.client = APIClient()

    def test_mobile_by_unregister_mobile(self):
        """Test that a mobile phone number is pass if the mobile phone number unregister"""
        mobile = "13312340000"
        res = self.client.get(f"{MOBILE_URL}{mobile}/")
        # self.assertXX 断言，期望，相当于程序中的if
        # self.assertXX 如果断言中的参数条件成立了，则测试通过，否则测试失败，则证明程序编写有问题！
        # 常用断言[属于Python默认内置的unittest测试模块内部提供的方法，unittest.case.py]
        # self.assertIn(A,B) 期望A作为B的成员存在，如果存在则断言通过，测试通过，否则失败
        # self.assertNotIn(A,B) 期望B的成员中没有A的存在，如果A不存在则断言通过，测试通过，否则失败
        # self.assertEqual(A,B) 期望A的值和B相等，如果相等则断言通过，测试通过，否则失败
        # self.assertIs(A,B) 期望A是否就是B，如果是则断言通过，测试通过，否则失败
        self.assertIn("errmsg", res.data)
        self.assertEqual("OK", res.data["errmsg"])
        self.assertEqual(res.status_code, status.HTTP_200_OK)

    def test_mobile_by_register_mobile(self):
        """Test that a mobile phone number is pass if the mobile phone number is registered"""
        # 先注册拥有当前手机号码的用户信息
        data = {"username": "xiaoming", "password": "123456", "mobile": "13334500000"}
        create_user(**data)
        # 基于已经注册的手机号码进行单元测试
        mobile = "13334500000"
        res = self.client.get(f"{MOBILE_URL}{mobile}/")
        self.assertIn("errmsg", res.data)
        self.assertEqual("当前手机号已注册", res.data["errmsg"])
        self.assertEqual(res.status_code, status.HTTP_400_BAD_REQUEST)

    def test_mobile_by_invalid_mobile(self):
        """Test that a mobile phone number is pass if the mobile phone number is invalid"""
        # 基于已经注册的手机号码进行单元测试
        mobile = "133345000"
        res = self.client.get(f"{MOBILE_URL}{mobile}/")
        self.assertEqual(res.status_code, status.HTTP_404_NOT_FOUND)


class UserTestCase(TestCase):
    """用户相关接口的测试集"""
    def setUp(self) -> None:
        self.client = APIClient()

    def test_create_token_for_user_login_by_username(self):
        """Test that a token is created if the user login by username"""
        data = {'username': 'xiaoming', 'password': 'xiaoming123456'}
        create_user(**data)
        res = self.client.post(TOKEN_URL, data)
        self.assertIn('token', res.data)
        self.assertEqual(res.status_code, status.HTTP_200_OK)

    def test_create_token_for_user_login_by_mobile(self):
        """Test that a token is created if the user login by username"""
        data = {'username': 'xiaoming', 'mobile': '17260808696', 'password': 'qpj12345'}
        create_user(**data)
        data = {"username": "17260808696", 'password': 'qpj12345'}
        res = self.client.post(TOKEN_URL, data)
        self.assertIn('token', res.data)
        self.assertEqual(res.status_code, status.HTTP_200_OK)

    def test_create_token_invalid_credentials(self):
        """Test that token is not created if invalid credentials are given"""
        create_user(username='xiaoming', password="xiaoming12345")
        data = {'username': 'xiaoming', 'password': 'wrong'}
        res = self.client.post(TOKEN_URL, data)

        self.assertNotIn('token', res.data)
        self.assertEqual(res.status_code, status.HTTP_400_BAD_REQUEST)

    def test_create_token_no_user(self):
        """Test that token is not created if user doesn't exist"""
        data = {'username': 'xiaoming', 'password': 'xiaoming12345'}
        res = self.client.post(TOKEN_URL, data)

        self.assertNotIn('token', res.data)
        self.assertEqual(res.status_code, status.HTTP_400_BAD_REQUEST)

    def test_create_token_missing_field(self):
        """Test that email and password are required"""
        res = self.client.post(TOKEN_URL, {'username': 'xiaoming', 'password': ''})
        self.assertNotIn('token', res.data)
        self.assertEqual(res.status_code, status.HTTP_400_BAD_REQUEST)


class UserRegisterTestCase(TestCase):
    """用户注册相关接口的测试集"""
    def setUp(self) -> None:
        self.client = APIClient()

    # 1.提交不存在的手机号测试是否通过
    def test_mobile_register_by_does_not_exist_mobile(self):
        data = {
            "mobile": "27260808696",
            "password": "123444",
            "sms_code": "55555",
            "re_password": "123444",
            "randstr": "@9ob",
            "ticket": "t03CDv0Df55l1Mh2tC5R01hefd4knbz-sJscxz7wzgNFX_rPClu4ecQCsJTAzxuXA-qP1L1z9g98UCaAAcAeoSMG1o4KeY13zrePr0AQei97H8HuWD2VfN36g**"
        }
        res = self.client.post(REGISTER_URL, data)
        self.assertIn("non_field_errors", res.data)
        self.assertIn("手机号格式不正确！", res.data["non_field_errors"])
        # self.assertEqual('mobile', res.data['code'])

        self.assertEqual(res.status_code, status.HTTP_400_BAD_REQUEST)

    # 2.提交已注册的手机号测试是否通过
    def test_mobile_register_by_registered_mobile(self):
        data = {
            "mobile": "17260808696",
            "password": "123444",
            "sms_code": "55555",
            "re_password": "123444",
            "randstr": "@9ob",
            "ticket": "t03CDv0Df55l1Mh2tC5R01hefd4knbz-sJscxz7wzgNFX_rPClu4ecQCsJTAzxuXA-qP1L1z9g98UCaAAcAeoSMG1o4KeY13zrePr0AQei97H8HuWD2VfN36g**"
        }
        res = self.client.post(REGISTER_URL, data)
        self.assertIn("token", res.data)
        # self.assertEqual("手机号码已注册！", res.data["non_field_errors"])
        # self.assertIn('non_field_errors', res.data["手机号码已注册！"])
        # self.assertEqual('mobile', res.data['code'])

        self.assertEqual(res.status_code, status.HTTP_201_CREATED)

    # 3.提交无效的手机号测试是否通过
    def test_mobile_register_by_invalid_mobile(self):
        data = {
            "mobile": "133123456",
            "password": "123444",
            "sms_code": "55555",
            "re_password": "123444",
            "randstr": "@9ob",
            "ticket": "t03CDv0Df55l1Mh2tC5R01hefd4knbz-sJscxz7wzgNFX_rPClu4ecQCsJTAzxuXA-qP1L1z9g98UCaAAcAeoSMG1o4KeY13zrePr0AQei97H8HuWD2VfN36g**"
        }
        res = self.client.post(REGISTER_URL, data)
        self.assertIn("non_field_errors", res.data)
        # self.assertEqual("手机号格式不正确！", res.data["non_field_errors"])
        # self.assertEqual('mobile', res.data['code'])

        self.assertEqual(res.status_code, status.HTTP_400_BAD_REQUEST)

    # 4.提交长度过短的密码是否测试通过
    def test_password_register_by_short_password(self):
        data = {
            "mobile": "15709282073",
            "password": "1234",
            "sms_code": "55555",
            "re_password": "1234",
            "randstr": "@9ob",
            "ticket": "t03CDv0Df55l1Mh2tC5R01hefd4knbz-sJscxz7wzgNFX_rPClu4ecQCsJTAzxuXA-qP1L1z9g98UCaAAcAeoSMG1o4KeY13zrePr0AQei97H8HuWD2VfN36g**"
        }
        res = self.client.post(REGISTER_URL, data)
        self.assertIn("password", res.data)
        # self.assertEqual("请确保这个字段至少包含 6 个字符。", res.data["password"])
        self.assertIn("请确保这个字段至少包含 6 个字符。", res.data["password"])
        self.assertEqual(res.status_code, status.HTTP_400_BAD_REQUEST)

    # 5.提交长度过长的密码是否测试通过
    def test_password_register_by_long_password(self):
        data = {
            "mobile": "15709282073",
            "password": "123456789",
            "sms_code": "55555",
            "re_password": "123456789",
            "randstr": "@9ob",
            "ticket": "t03CDv0Df55l1Mh2tC5R01hefd4knbz-sJscxz7wzgNFX_rPClu4ecQCsJTAzxuXA-qP1L1z9g98UCaAAcAeoSMG1o4KeY13zrePr0AQei97H8HuWD2VfN36g**"
        }
        res = self.client.post(REGISTER_URL, data)
        self.assertIn("token", res.data)

        self.assertEqual(res.status_code, status.HTTP_201_CREATED)

    # 6.提交空密码是否测试通过
    def test_password_register_by_null_password(self):
        data = {
            "mobile": "15709282073",
            "password": "",
            "sms_code": "55555",
            "re_password": "",
            "randstr": "@9ob",
            "ticket": "t03CDv0Df55l1Mh2tC5R01hefd4knbz-sJscxz7wzgNFX_rPClu4ecQCsJTAzxuXA-qP1L1z9g98UCaAAcAeoSMG1o4KeY13zrePr0AQei97H8HuWD2VfN36g**"
        }
        res = self.client.post(REGISTER_URL, data)
        self.assertIn("password", res.data)
        self.assertIn("该字段不能为空。", res.data["password"])
        # self.assertEqual("该字段不能为空。", res.data["password"])
        self.assertEqual(res.status_code, status.HTTP_400_BAD_REQUEST)

