import json
import constants
from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from django_redis import get_redis_connection
from .services import get_user_enable_coupon_list
# Create your views here.


class CouponListAPIView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        """获取当前用户拥有的优惠券列表"""
        user_id = request.user.id
        # redis = get_redis_connection("coupon")
        # coupon_list = redis.keys(f"{user_id}:*")
        # # print(coupon_list) # [b'10:9', b'10:5', b'10:10', b'10:8']
        # try:
        #     coupon_id_list = [item.decode() for item in coupon_list]
        # except:
        #     coupon_id_list = []
        # coupon_data = []
        # # 遍历redis中所有的优惠券数据并转换数据格式
        # for coupon_key in coupon_id_list:
        #     coupon_item = {}
        #     coupon_hash = redis.hgetall(coupon_key)
        #     for key, value in coupon_hash.items():
        #         key = key.decode()
        #         value = value.decode()
        #         if key in ["to_course", "to_category", "to_direction"]:
        #             value = json.loads(value)
        #         coupon_item[key] = value
        #     coupon_data.append(coupon_item)

        # 获取用户拥有的所有优惠券
        coupon_data = get_user_enable_coupon_list(user_id)

        # 获取购物车中的勾选商品[与优惠券的适用范围进行比对，找出能用的优惠券]
        # return Response(coupon_data)
        return Response({
            "errmsg": "OK",
            'has_credit': request.user.credit,
            'credit_to_money': constants.CREDIT_TO_MONEY,
            "coupon_list": coupon_data
        })
