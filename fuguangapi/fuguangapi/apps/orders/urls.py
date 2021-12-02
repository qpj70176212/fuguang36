from django.urls import path
from . import views

urlpatterns = [
    path("", views.OrderCreateAPIView.as_view()),
    path("pay/status/", views.OrderPayChoicesAPIView.as_view()),
    path("list/", views.OrderListAPIView.as_view()),
]