from rest_framework.viewsets import ViewSet
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework import status
from django_redis import get_redis_connection
from courses.models import Course
# Create your views here.


class CartViewSet(ViewSet):
    """购物车"""
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

    def list(self, request):
        """购物车商品列表页"""
        # 1. 查询购物车中的商品课程ID列表
        user_id = request.user.id
        redis = get_redis_connection("cart")
        cart_hash = redis.hgetall(f"cart_{user_id}")
        """
        cart_hash = {
            # b'商品课程ID': b'勾选状态', 
            b'2': b'1', 
            b'4': b'1', 
            b'5': b'1'
        }
        """
        if len(cart_hash) < 1:
            return Response({"errmsg": "购物车没有任务商品！"}, status=status.HTTP_204_NO_CONTENT)
        # 把redis中的购物车信息转换成普通字典
        cart_dict = {int(course_id.decode()): bool(int(selected.decode())) for course_id, selected in cart_hash.items()}
        """
       cart_dict = {
           # 商品课程ID: 勾选状态,
           2: True, 
           4: True, 
           5: True
       }
        """
        # 2. 从mysql中提取购物车商品对应的商品其他信息
        course_list = Course.objects.filter(pk__in=cart_dict.keys(), is_delete=False, is_show=True).all()
        # 把course_list进行遍历，提取课程中的信息组成列表
        data = []
        for course in course_list:
            data.append({
                "id": course.id,
                "name": course.name,
                "course_cover": course.course_cover.url,  # 课程封面图片
                "price": float(course.price),  # 价格
                "discount": course.discount,  # 优惠信息
                "course_type": course.get_course_type_display(),  # 优惠类型
                "selected": cart_dict[course.id],  # 勾选状态 布尔值
            })

        # 3. 返回客户端
        return Response({"errmsg": "OK!", "cart": data})

    def change_select(self, request):
        """切换单个商品的勾选状态"""
        # 谁的购物车？user_id
        # 获取购物车的课程ID与勾选状态
        user_id = request.user.id
        course_id = int(request.data.get("course_id", 0))
        selected = int(bool(request.data.get("selected", True)))
        redis = get_redis_connection("cart")

        try:
            Course.objects.get(pk=course_id, is_show=True, is_delete=False)
        except Course.DoesNotExist:
            redis.hdel(f"cart_{user_id}", course_id)
            return Response({"errmsg": "当前商品不存在或已经被下载！"})
        redis.hset(f"cart_{user_id}", course_id, selected)
        return Response({"errmsg": "OK"})

    def together_select(self, request):
        """全选/全不选"""
        user_id = request.user.id
        selected = int(bool(request.data.get("selected", True)))
        redis = get_redis_connection("cart")
        # 获取购物车中所有商品课程信息
        cart_hash = redis.hgetall(f"cart_{user_id}")
        """
        cart_hash = {
            # b'商品课程ID': b'勾选状态', 
            b'2': b'1', 
            b'4': b'1', 
            b'5': b'1'
        }
        """
        if len(cart_hash) < 1:
            return Response({"errmsg": "购物车没有任何商品！"}, status=status.HTTP_204_NO_CONTENT)
        # 把redis中的购物车课程ID信息转换成普通列表
        cart_list = [int(course_id.decode()) for course_id in cart_hash]
        # 批量修改购物车中所有商品课程的勾选状态
        pipe = redis.pipeline()
        pipe.multi()
        for course_id in cart_list:
            pipe.hset(f"cart_{user_id}", course_id, selected)
        pipe.execute()
        return Response({"errmsg": "OK"})

    def delete_course(self, request):
        """从购物车中删除课程"""
        user_id = request.user.id
        course_id = int(request.data.get("course_id", 0))
        redis = get_redis_connection("cart")
        redis.hdel(f"cart_{user_id}", course_id)
        return Response(status=status.HTTP_204_NO_CONTENT)
