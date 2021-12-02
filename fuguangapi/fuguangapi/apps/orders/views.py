from rest_framework.generics import CreateAPIView, ListAPIView
from rest_framework.views import APIView
from rest_framework.response import Response
from .models import Order, OrderDetail
from .serializers import OrderModelSerializer, OrderListModelSerializer
from .paginations import OrderListPageNumberPagination
from rest_framework.permissions import IsAuthenticated
# Create your views here.


class OrderCreateAPIView(CreateAPIView):
    """创建订单"""
    permission_classes = [IsAuthenticated]
    queryset = Order.objects.all()
    serializer_class = OrderModelSerializer


class OrderPayChoicesAPIView(APIView):
    def get(self, request):
        """订单过滤过滤选项"""
        # status_choices = (
        #     (0, '未支付'), (1, '已支付'),
        #     (2, '已取消'), (3, '已超时'),)
        return Response(Order.status_choices)


class OrderListAPIView(ListAPIView):
    """当前登录用户的订单列表"""
    permission_classes = [IsAuthenticated]
    serializer_class = OrderListModelSerializer
    pagination_class = OrderListPageNumberPagination

    def get_queryset(self):
        user = self.request.user  # 获取当前登录用户
        query = Order.objects.filter(user=user, is_delete=False, is_show=True)
        order_status = int(self.request.query_params.get("status", -1))
        status_list = [item[0] for item in Order.status_choices]
        if order_status in status_list:
            query = query.filter(order_status=order_status)
        return query.order_by("-id").all()


