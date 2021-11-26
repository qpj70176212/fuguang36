import random, logging
from django.db import transaction
from django.utils.decorators import method_decorator
from rest_framework import serializers
from django_redis import get_redis_connection
from django.utils.timezone import datetime
from .models import Order, OrderDetail
from courses.models import Course

logger = logging.getLogger("django")


class OrderModelSerializer(serializers.ModelSerializer):
    """订单序列化器"""
    # 支付链接地址
    link = serializers.CharField(read_only=True)

    class Meta:
        model = Order
        fields = ["pay_type", "id", "order_number", "link"]
        read_only_fields = ["order_number"]
        extra_kwargs = {
            "pay_type": {"write_only": True},
        }

    def create(self, validated_data):
        """创建订单"""
        # 本次客户端的HTTP请求对象
        user_id = self.context["request"].user.id
        redis = get_redis_connection("cart")
        # 唯一订单号[基于时间、用户ID、随机数]
        # 基于redis生成分布式唯一订单号
        # order_number = datetime.datetime.now().strftime("%Y%m%d%H%M%S") + ("%08d" % user_id) + "%08d" % random.randint(1, 99999999)  # 基于随机数
        order_number = datetime.now().strftime("%Y%m%d") + ("%08d" % user_id) + "%08d" % redis.incr("order_number")
        # 开启事务操作
        with transaction.atomic():
            # 设置事务的回滚点标记
            t1 = transaction.savepoint()
            try:
                # 创建订单记录  创建订单基本信息的记录
                order = Order.objects.create(
                    name="购买课程",  # 订单标题
                    user_id=user_id,  # 当前下单的用户ID
                    total_price=0,  # 订单总价，先默认为0，后面计算了所有的课程价格以后。累加得出
                    real_price=0,  # 订单实价，先默认为0，后面计算了所有的课程价格以后。累加得出
                    order_number= order_number,  # 订单号
                    pay_type=validated_data.get("pay_type"),  # 支付方式
                )
                # 记录本次下单的商品列表
                cart_hash = redis.hgetall(f"cart_{user_id}")
                if len(cart_hash) < 1:
                    raise serializers.ValidationError(detail="购物车没有要下单的商品！")
                # 提取购物车中所有勾选状态为b'1'的商品
                course_id_list = [int(course_id.decode()) for course_id, selected in cart_hash.items() if selected == b'1']
                # 添加订单与课程的关系
                course_list = Course.objects.filter(pk__in=course_id_list, is_delete=False, is_show=True).all()
                detail_list = []  # 订单详情的模型列表[避免出现在循环中执行IO操作]
                total_price = 0   # 订单总价
                real_price = 0  # 订单实价
                for course in course_list:
                    # 判断商品课程是否有优惠价格，有就转换数据类型
                    try:
                        discount_price = float(course.discount["price"])
                    except:
                        discount_price = 0
                    # 判断商品课程是否有优惠，有就记录优惠类型
                    try:
                        discount_name = course.discount["type"]
                    except:
                        discount_name = ""

                    detail_list.append(OrderDetail(
                        order=order,
                        course=course,
                        name=course.name,
                        price=course.price,
                        real_price=discount_price,
                        discount_name=discount_name,
                    ))
                    # 统计订单的总结和实付价格
                    total_price += float(course.price)
                    real_price += float(course.price) if discount_price == 0 else discount_price

                # 一次性批量添加本次下单的商品记录
                OrderDetail.objects.bulk_create(detail_list)
                # 保存订单的总价格和实付价格
                order.total_price = total_price
                order.real_price = real_price
                order.save()
                # todo 支付链接地址
                order.link = ""
                # 找出购物车中的没有被勾选的商品信息
                cart = {key: value for key, value in cart_hash.items() if value == b'0'}
                pipe = redis.pipeline()
                pipe.multi()
                if cart == {}:
                    # 删除原来的购物车
                    pipe.delete(f"cart_{user_id}")
                    pipe.execute()
                    return order

                # 删除原来的购物车
                pipe.delete(f"cart_{user_id}")
                # 重新把未勾选的商品记录到购物车中
                pipe.hmset(f"cart_{user_id}", cart)
                pipe.execute()
                return order
            except Exception as e:
                # 1. 事务回滚
                transaction.savepoint_rollback(t1)
                # 2. 日志记录
                logger.error(f"生成订单失败！{e}")
                # 3. 抛出异常
                raise serializers.ValidationError(detail="生成订单失败！")
