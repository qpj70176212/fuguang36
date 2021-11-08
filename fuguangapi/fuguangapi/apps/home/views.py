from django.shortcuts import render

# Create your views here.
from rest_framework.views import APIView
from rest_framework.response import Response
from django_redis import get_redis_connection


class HomeAPIView(APIView):
    def get(self, request):
        # 测试django操作redis
        redis = get_redis_connection("default")
        # 设置键值
        redis.set("name", "xiaoming")
        # 向键authors的集合中添加元素
        redis.sadd("authors", 'xiaoming', "xiaohong", "xiaoli")
        # rpush 在右侧(后)添加一条或多条数据
        redis.rpush("team", "zhangfei", "guanyu", "liubei")
        # 查看键的有效期  -1 表示永久有效
        ret = redis.ttl("name")
        print(ret)  # -1
        # 根据键获取值
        ret = redis.get("name")
        print(ret, ret.decode())  # b'xiaoming'  bytes类型数据
        # 获取键authors的集合中所有元素
        ret = redis.smembers("authors")
        print(ret)  # {b'slili', b'zhangsan', b'xiaohong', b'xiaoli', b'xiaoming'}
        print(ret, [item.decode() for item in ret])
        # 获取列表的切片 获取team的全部成员
        ret = redis.lrange("team", 0, -1)
        print(ret, [item.decode() for item in ret])  # [b'zhangfei', b'guanyu', b'liubei']
        return Response('ok')