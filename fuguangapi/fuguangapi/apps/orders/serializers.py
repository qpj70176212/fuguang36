import random, logging
from django.db import transaction
from django.utils.decorators import method_decorator
from rest_framework import serializers
from django_redis import get_redis_connection
from django.utils.timezone import datetime

import constants
from .models import Order, OrderDetail
from courses.models import Course
from coupon.models import CouponLog

logger = logging.getLogger("django")


class OrderModelSerializer(serializers.ModelSerializer):
    """订单序列化器"""
    # 支付链接地址
    # link = serializers.CharField(read_only=True)
    user_coupon_id = serializers.IntegerField(write_only=True, default=-1)

    class Meta:
        model = Order
        fields = ["pay_type", "id", "order_number", "user_coupon_id", "credit"]
        read_only_fields = ["order_number"]
        extra_kwargs = {
            "pay_type": {"write_only": True},
        }

    def create(self, validated_data):
        """创建订单"""
        # 本次客户端的HTTP请求对象
        user = self.context["request"].user
        user_id = user.id
        # user_id = self.context["request"].user.id

        # 判断用户如果使用了优惠券，则优惠券需要判断验证
        user_coupon_id = validated_data.get("user_coupon_id")
        # 本次下单时，用户使用的优惠券
        user_coupon = None
        if user_coupon_id != -1:
            user_coupon = CouponLog.objects.filter(pk=user_coupon_id, user_id=user_id).first()

        # 本次下单时使用的积分数量
        use_credit = validated_data.get("credit", 0)
        # 如果本次下单用户使用了抵扣积分，并且抵扣的积分数量 > 用户拥有的积分数量，则报错。
        if use_credit > 0 and use_credit > user.credit:
            raise serializers.ValidationError(detail="您拥有的积分不足以抵扣本次下单的积分，请重新下单！")

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
                    order_number=order_number,  # 订单号
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

                total_discount_price = 0  #
                max_discount_course = None  # 享受最大优惠的课程

                # 本次下单最多可以抵扣的积分
                max_use_credit = 0

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
                    # 统计订单的总价格和实付价格
                    total_price += float(course.price)
                    real_price += float(course.price) if discount_price == 0 else discount_price

                    # 在用户使用了优惠券，并且当前课程没有参与其他优惠活动时，找到最佳优惠课程
                    # 优惠券和价格为空时
                    # if user_coupon and discount_price < 1:
                    if user_coupon and discount_price is None:
                        # 最大优惠价格为None
                        if max_discount_course is None:
                            max_discount_course = course
                        else:
                            # 判断课程价格
                            if course.price >= max_discount_course.price:
                                max_discount_course = course

                    # 添加每个课程的可用积分
                    if use_credit > 0:
                        max_use_credit += course.credit

                # 在用户使用了优惠券以后，根据循环中得到的最佳优惠课程进行计算最终抵扣金额
                if user_coupon:
                    # 优惠公式
                    sale = float(user_coupon.coupon.sale[1:])
                    if user_coupon.coupon.discount == 1:
                        """减免优惠券"""
                        total_discount_price = sale
                    elif user_coupon.coupon.discount == 2:
                        """折扣优惠券"""
                        total_discount_price = float(max_discount_course.price) * (1 - sale)

                # 在用户使用了积分抵扣以后
                if use_credit > 0:
                    # 如果本次下单最大可用积分数量 < 用户提交的抵扣数量，则报错
                    if max_use_credit < use_credit:
                        raise serializers.ValidationError(detail="本次使用的抵扣积分数额超过了限制！")

                    # 当前订单添加积分抵扣的数量
                    order.credit = use_credit
                    total_discount_price = float(use_credit / constants.CREDIT_TO_MONEY)

                    # todo 扣除用户拥有的积分，后续在订单超时未支付或用户取消下单时，则返还订单中对应数量的积分给用户。

                    #  如果订单成功支付，则添加一个积分流水记录。
                    user.credit = user.credit - use_credit
                    user.save()

                # 一次性批量添加本次下单的商品记录
                OrderDetail.objects.bulk_create(detail_list)
                # 保存订单的总价格和实付价格
                order.total_price = total_price
                order.real_price = float(real_price - total_discount_price)
                # order.real_price = float(real_price) - float(total_discount_price)
                order.save()

                # 支付链接地址
                # order.link = ""
                # 找出购物车中的没有被勾选的商品信息
                cart = {key: value for key, value in cart_hash.items() if value == b'0'}
                pipe = redis.pipeline()
                pipe.multi()
                # if cart == {}:
                #     # 删除原来的购物车
                #     pipe.delete(f"cart_{user_id}")
                #     pipe.execute()
                #     return order

                # 删除原来的购物车
                pipe.delete(f"cart_{user_id}")
                # 重新把未勾选的商品记录到购物车中
                if len(cart) > 0:
                    pipe.hmset(f"cart_{user_id}", cart)
                pipe.execute()

                # # 从购物车中删除掉已经被勾选的商品课程，保留没有勾选的
                # cart = {key: value for key, value in cart_hash.items() if value == b'0'}
                # pipe = redis.pipeline()
                # pipe.multi()
                # pipe.delete(f"cart_{user_id}")
                # pipe.hmset(f"cart_{user_id}", cart)
                # pipe.execute()

                # 如果有使用了优惠券，则把优惠券和当前订单进行绑定
                if user_coupon:
                    redis = get_redis_connection("coupon")
                    user_coupon.order = order
                    user_coupon.save()
                    # 把优惠券从redis中移除
                    redis.delete(f"{user_id}:{user_coupon_id}")

                    # todo 将来订单状态发生改变，再修改优惠券的使用状态，如果订单过期，则再次还原优惠券到redis中

                return order
            except Exception as e:
                # 1. 事务回滚
                transaction.savepoint_rollback(t1)
                # 2. 日志记录
                logger.error(f"生成订单失败！{e}")
                # 3. 抛出异常
                raise serializers.ValidationError(detail="生成订单失败！")
