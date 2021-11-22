from django.shortcuts import render
from drf_haystack.viewsets import HaystackViewSet
from drf_haystack.filters import HaystackFilter
from rest_framework.generics import ListAPIView
from .models import CourseDirection, CourseCategory, Course
from .serializers import CourseDirectionModelSerializer, CourseCategoryModelSerializer, CourseModelSerializer, CourseIndexHaystackSerializer
from rest_framework.filters import OrderingFilter
from .paginations import CourseListPageNumberPagination

# Create your views here.


class CourseDirectionListAPIView(ListAPIView):
    """学习方向的视图"""
    queryset = CourseDirection.objects.filter(is_show=True, is_delete=False).order_by("orders", "id")
    serializer_class = CourseDirectionModelSerializer
    pagination_class = None


class CourseCategoryListAPIView(ListAPIView):
    """学习课程分类列表"""
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


class CourseListAPIView(ListAPIView):
    """课程列表接口"""
    serializer_class = CourseModelSerializer
    filter_backends = [OrderingFilter, ]
    ordering_fields = ['id', 'students', 'orders']
    pagination_class = CourseListPageNumberPagination

    def get_queryset(self):
        """列表页数据"""
        direction = int(self.kwargs.get("direction", 0))
        category = int(self.kwargs.get("category", 0))

        queryset = Course.objects.filter(is_delete=False, is_show=True).order_by("orders", "id")
        # 只有在学习方向大于0的情况下才进行学习方向的过滤
        if direction > 0:
            queryset = queryset.filter(direction=direction)
        # 只有在课程分类大于0的情况下才进行课程分类的过滤
        if category > 0:
            queryset = queryset.filter(category=category)

        return queryset.all()


class CourseSearchViewSet(HaystackViewSet):
    # 指定本次搜索的最终真实数据的保存模型
    index_models = [Course]
    serializer_class = CourseIndexHaystackSerializer
    # 过滤
    filter_backends = [OrderingFilter, HaystackFilter]
    # 排序
    ordering_fields = ("id", "students", "orders")
    # 分页
    pagination_class = CourseListPageNumberPagination
