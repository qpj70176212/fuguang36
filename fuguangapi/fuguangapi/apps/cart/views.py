from rest_framework.viewsets import ViewSet
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework import status
from django_redis import get_redis_connection
from courses.models import Course
# Create your views here.


class CartViewSet(ViewSet):
    permission_classes = [IsAuthenticated]  # 保证用户必须登录状态才能调用当前视图

    def add_cart(self, request):
        """添加课程商品到购物车中"""
        # 1. 接受客户端提交的商品信息: 用户ID，课程ID，勾选状态
        user_id = request.user.id
        course_id = request.data.get("course_id", None)
        selected = 1  # 默认商品时勾选状态的
        print(f"user_id={user_id}, course_id={course_id}")

        # 2. 验证课程是否允许购买[is_show=True, is_delete=False]
        try:
            # 判断课程是否存在
            # todo 判断用户是否已经购买
            course = Course.objects.get(is_show=True, is_delete=False, pk=course_id)
        except Course.DoesNotExist:
            return Response({"errmsg": "当前课程不存在！"}, status=status.HTTP_400_BAD_REQUEST)

        # 3. 获取redis连接
        redis = get_redis_connection("cart")

        # 4. todo 因为我们当前实现是属于虚拟商品的购买，是没有数量的。
        #  所以，针对同一个课程，或者曾经购买过的课程，不让用户再次添加到购物车
        ret = redis.hexists(f"cart_{user_id}", course_id)
        cart_total = redis.hlen(f"cart_{user_id}")
        if ret:
            return Response({
                "errmsg": "当前商品课程已经被添加到购物车，请不要重复添加！",
                "cart_total": cart_total,
            })
        # 5. 添加商品到购物车 保存商品信息到购物车
        # hset <user_id> <course_id> <selected>
        """
           cart_用户ID: {
               课程ID: 1
           }
        """
        redis.hset(f"cart_{user_id}", course_id, selected)
        """
             cart_1: {
                course_id: True,
                course_id: True,
                course_id: True,
             }

             cart_2: {
                ....
             }
             """
        # 6. 获取购物车中的商品课程数量  返回操作结果，购物车中的商品总数
        # hlen <user_id>
        cart_total = redis.hlen(f"cart_{user_id}")
        # 7. 返回结果给客户端
        return Response({
            "errmsg": "成功添加商品课程到购物车！",
            "cart_total": cart_total
        }, status=status.HTTP_201_CREATED)
