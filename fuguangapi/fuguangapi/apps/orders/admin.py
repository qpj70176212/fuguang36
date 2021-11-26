from django.contrib import admin
from .models import Order, OrderDetail
# Register your models here.


class OrderDetailInLine(admin.StackedInline):
    """课程的内嵌类"""
    model = OrderDetail
    fields = ["course", "price", "real_price", "discount_name"]


class OrderModelAdmin(admin.ModelAdmin):
    """订单信息的模型管理器"""
    list_display = ["id", "order_number", "user", "total_price", "real_price", "order_status"]
    inlines = [OrderDetailInLine]


admin.site.register(Order, OrderModelAdmin)
