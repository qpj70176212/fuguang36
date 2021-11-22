from django.urls import path, re_path
from . import views
from rest_framework import routers

router = routers.DefaultRouter()
# 注册全文搜索到视图集中生成url路由信息
router.register("search", views.CourseSearchViewSet, basename="course-search")

urlpatterns = [
    path("directions/", views.CourseDirectionListAPIView.as_view()),
    # path("categories/", views.CourseCategoryListAPIView.as_view()),
    re_path(r"^categories/(?P<direction>\d+)/$", views.CourseCategoryListAPIView.as_view()),
    re_path(r"^(?P<direction>\d+)/(?P<category>\d+)/$", views.CourseListAPIView.as_view()),
] + router.urls

# urlpatterns += router.urls
