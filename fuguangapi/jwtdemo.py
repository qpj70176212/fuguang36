import base64, json, hashlib
from datetime import datetime
if __name__ == '__main__':
    """jwt 头部的生成"""

    header_data = {"typ": "JWT", "alg": "HS256"}
    header = base64.b64encode(json.dumps(header_data).encode()).decode()
    print(header)  # eyJ0eXAiOiAiand0IiwgImFsZyI6ICJIUzI1NiJ9

    """jwt 载荷的生成"""
    iat = int(datetime.now().timestamp())
    payload_data = {
        # 标准声明
        # sub: jwt所面向的用户
        "sub": "root",
        # exp: jwt的过期时间，这个过期时间必须要大于签发时间
        "exp": iat + 3600,  # 假设一小时过期
        # iat: jwt的签发时间
        "iat": iat,
        # 公共声明
        "name": "wangxiaoming",
        "admin": True,
        # 私有声明
        "acc_pwd": "eyJ0eXAiOiAiand0IiwgImFsZyI6ICJIUzI1NiJ9"
    }
    # 将其进行base64编码，得到jwt的第二部分
    payload = base64.b64encode(json.dumps(payload_data).encode()).decode()
    print(payload)
    # eyJzdWIiOiAicm9vdCIsICJleHAiOiAxNjM2NTQzMDc4LCAiaWF0IjogMTYzNjUzOTQ3OCwgIm5hbWUiOiAid2FuZ3hpYW9taW5nIiwgImFkbWluIjogdHJ1ZSwgImFjY19wd2QiOiAiZXlKMGVYQWlPaUFpYW5kMElpd2dJbUZzWnlJNklDSklVekkxTmlKOSJ9

    """jwt 签证信息"""
    # 秘钥绝对不能提供给客户端
    SECRET_KEY = 'django-insecure-l8tj#^lknpchumj098ng!vp6z*j5ujj)!a5yepjab8^uli=7zr'
    data = header + payload + SECRET_KEY
    HS256 = hashlib.sha256()
    HS256.update(data.encode("utf-8"))
    signature = HS256.hexdigest()
    print(signature)  # 300685b3f2c0a4acccc77b643f98390949440c54ea0feb8a6bc8dcceca5f8f37

    # jwt 最终的生成
    token = f"{header}.{payload}.{signature}"
    print(token)
    # eyJ0eXAiOiAiand0IiwgImFsZyI6ICJIUzI1NiJ9.
    # eyJzdWIiOiAicm9vdCIsICJleHAiOiAxNjM2NTQzODIzLCAiaWF0IjogMTYzNjU0MDIyMywgIm5hbWUiOiAid2FuZ3hpYW9taW5nIiwgImFkbWluIjogdHJ1ZSwgImFjY19wd2QiOiAiZXlKMGVYQWlPaUFpYW5kMElpd2dJbUZzWnlJNklDSklVekkxTmlKOSJ9.
    # 474605e35c71f2e18652ba51b8b81a32d56f2520333d27c76a7fc6acbf6d4e97

    """验证逻辑"""
    token = "eyJ0eXAiOiAiand0IiwgImFsZyI6ICJIUzI1NiJ9.eyJzdWIiOiAicm9vdCIsICJleHAiOiAxNjM2NTUwMDQ1LCAiaWF0IjogMTYzNjU0NjQ0NSwgIm5hbWUiOiAid2FuZ3hpYW9taW5nIiwgImFkbWluIjogdHJ1ZSwgImFjY19wd2QiOiAiZXlKMGVYQWlPaUFpYW5kMElpd2dJbUZzWnlJNklDSklVekkxTmlKOSJ9.50f6c7e89492e9c7fe94e2a9f3652fe09df8af92fe3845ec9fd3c94d19386eb3"
    header, payload, signature = token.split(".")

    # 验证是否过期了
    payload_data = json.loads(base64.b64decode(payload.encode()))
    exp = payload_data.get("exp", None)
    if exp is not None and exp < datetime.now().timestamp():
        raise Exception("token过期了！！！")

    # 验证token是否有效，是否被篡改
    SECRET_KEY = 'django-insecure-l8tj#^lknpchumj098ng!vp6z*j5ujj)!a5yepjab8^uli=7zr'
    # 秘钥绝对不能提供给客户端
    data = header + payload + SECRET_KEY
    HS256 = hashlib.sha256()
    HS256.update(data.encode("utf-8"))
    new_signature = HS256.hexdigest()

    if new_signature != signature:
        print("认证失败！")
    else:
        print("认证成功！")
