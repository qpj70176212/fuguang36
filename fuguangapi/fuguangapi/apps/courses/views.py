from django.shortcuts import render
from rest_framework.generics import ListAPIView
from .models import CourseDirection
from .serializers import CourseDirectionModelSerializer
# Create your views here.


class CourseDirectionListAPIView(ListAPIView):
    """学习方向"""
    queryset = CourseDirection.objects.filter(is_show=True, is_delete=False).order_by("orders", "-id")
    serializer_class = CourseDirectionModelSerializer
