from django.urls import path
from . import views

urlpatterns = [
    path("redis/", views.HomeAPIView.as_view())
]
