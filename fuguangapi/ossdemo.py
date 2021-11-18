import oss2, uuid
if __name__ == '__main__':
    OSS_ACCESS_KEY_ID = "LTAI5tK52iM391jcoq9QjQLw"
    OSS_ACCESS_KEY_SECRET = "VlyEUuhPtHzEV5VGvV2AtLa5ipINA8"
    OSS_ENDPOINT = "oss-cn-beijing.aliyuncs.com"  # 访问域名, 根据服务器上的实际配置修改
    OSS_BUCKET_NAME = "fuguangonline"  # oss 创建的 BUCKET 名称

    OSS_SERVER_URL = f"https://{OSS_BUCKET_NAME}.{OSS_ENDPOINT}"

    # 创建命名空间操作实例对象
    auth = oss2.Auth(OSS_ACCESS_KEY_ID, OSS_ACCESS_KEY_SECRET)
    bucket = oss2.Bucket(auth, OSS_ENDPOINT, OSS_BUCKET_NAME)

    # 上传文件
    image = f"demo/{str(uuid.uuid4())}.jpg"
    with open('/home/moluo/Desktop/pythonproject/949504.jpg', "rb") as f:
        result = bucket.put_object(image, f.read())
        print(result)
        print(result.status)
        # 访问资源的地址
        print(f"{OSS_SERVER_URL}/{image}")

# python ossdemo.py




# # -*- coding: utf-8 -*-
# import oss2
# import os
# # 阿里云账号AccessKey拥有所有API的访问权限，风险很高。强烈建议您创建并使用RAM用户进行API访问或日常运维，请登录RAM控制台创建RAM用户。
# auth = oss2.Auth('yourAccessKeyId', 'yourAccessKeySecret')
# # yourEndpoint填写Bucket所在地域对应的Endpoint。以华东1（杭州）为例，Endpoint填写为https://oss-cn-hangzhou.aliyuncs.com。
# # 填写Bucket名称。
# bucket = oss2.Bucket(auth, 'yourEndpoint', 'examplebucket')
#
# # 必须以二进制的方式打开文件。
# # 填写本地文件的完整路径。如果未指定本地路径，则默认从示例程序所属项目对应本地路径中上传文件。
# with open('D:\\localpath\\examplefile.txt', 'rb') as fileobj:
#     # Seek方法用于指定从第1000个字节位置开始读写。上传时会从您指定的第1000个字节位置开始上传，直到文件结束。
#     fileobj.seek(1000, os.SEEK_SET)
#     # Tell方法用于返回当前位置。
#     current = fileobj.tell()
#     # 填写Object完整路径。Object完整路径中不能包含Bucket名称。
#     bucket.put_object('exampleobject.txt', fileobj)