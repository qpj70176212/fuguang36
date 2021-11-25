from django.urls import path
from . import views

urlpatterns = [
    path("", views.CartViewSet.as_view({
        "post": "add_cart",
        "get": "list",
        "patch": "change_select",  # 切换单个课程的勾选状态
        "put": "together_select",  # 切换购物车中所有商品的勾选状态[全选/全不选]
        "delete": "delete_course",
    })),
]
