from django.shortcuts import render
from rest_framework.generics import ListAPIView
from .models import CourseDirection, CourseCategory
from .serializers import CourseDirectionModelSerializer, CourseCategoryModelSerializer
# Create your views here.


class CourseDirectionListAPIView(ListAPIView):
    """学习方向"""
    queryset = CourseDirection.objects.filter(is_show=True, is_delete=False).order_by("orders", "id")
    serializer_class = CourseDirectionModelSerializer
    pagination_class = None


class CourseCategoryListAPIView(ListAPIView):
    """学习分类"""
    # queryset = CourseCategory.objects.filter(is_show=True, is_delete=False).order_by("orders", "-id")
    serializer_class = CourseCategoryModelSerializer
    pagination_class = None

    def get_queryset(self):
        """重写获取课程分类的查询集方法"""
        print(self.kwargs)  # 获取路由中声明的路径参数
        direction = int(self.kwargs.get("direction", 0))
        queryset = CourseCategory.objects.filter(is_show=True, is_delete=False).order_by("orders", "id")

        # 只有在学习方向大于0的情况下才进行过滤
        if direction > 0:
            queryset = queryset.filter(direction=direction)

        return queryset.all()


