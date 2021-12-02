from django.urls import path, re_path
from . import views

urlpatterns = [
    path("", views.OrderCreateAPIView.as_view()),
    path("pay/status/", views.OrderPayChoicesAPIView.as_view()),
    path("list/", views.OrderListAPIView.as_view()),
    re_path(r"^(?P<pk>\d+)/$", views.OrderViewSet.as_view({"put": "pay_cancel"})),
]