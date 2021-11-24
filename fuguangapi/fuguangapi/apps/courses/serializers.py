from rest_framework import serializers
from .models import CourseDirection, CourseCategory, Course, Teacher, CourseChapter, CourseLesson
from drf_haystack.serializers import HaystackSerializer
from .search_indexes import CourseIndex
from django.conf import settings


class CourseDirectionModelSerializer(serializers.ModelSerializer):
    """学习方向的序列化器"""

    class Meta:
        model = CourseDirection
        fields = ["id", "name"]


class CourseCategoryModelSerializer(serializers.ModelSerializer):
    """课程分类的序列化器"""

    class Meta:
        model = CourseCategory
        fields = ["id", "name"]


class CourseModelSerializer(serializers.ModelSerializer):
    """课程信息的序列化器"""

    class Meta:
        model = Course
        fields = ['id', 'name', 'course_cover', 'level', 'get_level_display', 'students', 'status',
                  'get_status_display', 'lessons', 'pub_lessons', "price", 'discount']


class CourseIndexHaystackSerializer(HaystackSerializer):
    """课程搜索的序列化器"""
    class Meta:
        index_classes = [CourseIndex]
        fields = [
            "text",
            "id",
            "name",
            "course_cover",
            "get_level_display",
            "students",
            "get_status_display",
            "pub_lessons",
            "price",
            "discount",
            "orders"
        ]

    def to_representation(self, instance):
        """用于指定返回数据的字段的"""
        # 课程的图片，在这里通过elasticsearch提供的
        # 所以不会提供图片地址左边的域名的
        # 因此在这里手动拼接
        # instance.course_cover = f'//{self.context["request"]._request.META["HTTP_HOST"]}/uploads/{instance.course_cover}'
        # instance.course_cover = f'//{settings.OSS_BUCKET_NAME}.{settings.OSS_ENDPOINT}/uploads/{instance.course_cover}'
        instance.course_cover = f'https://{settings.OSS_BUCKET_NAME}.{settings.OSS_ENDPOINT}/uploads/{instance.course_cover}'
        return super().to_representation(instance)


class CourseTeachModelSerializer(serializers.ModelSerializer):
    """课程老师信息"""
    class Meta:
        model = Teacher
        fields = ["id", "name", "avatar", "role", "get_role_display", "title", "signature", "brief"]


class CourseLessonModelSerializer(serializers.ModelSerializer):
    """课程课时的序列化器"""
    class Meta:
        model = CourseLesson
        fields = ["id", "name", "orders", "duration", "lesson_type", "lesson_link", "free_trail"]


class CourseChapterModelSerializer(serializers.ModelSerializer):
    """课程章节的序列化器"""
    lesson_list = CourseLessonModelSerializer(many=True)

    class Meta:
        model = CourseChapter
        # 实际开发中，肯定不需要返回2次课时列表，所以lesson_list 和 get_lesson_list 二选一即可。
        fields = ["id", "orders", "name", "summary", "lesson_list", "get_lesson_list"]


class CourseRetrieveModelSerializer(serializers.ModelSerializer):
    """课程详情的序列化器"""
    direction_name = serializers.CharField(source="direction.name")
    category_name = serializers.CharField(source="category.name")
    # 序列化器嵌套
    teacher = CourseTeachModelSerializer()
    # 章节列表
    chapter_list = CourseChapterModelSerializer(many=True)

    class Meta:
        model = Course
        fields = [
            'name', 'course_cover', 'course_video', 'level',
            'get_level_display', 'description', 'pub_date', 'status',
            'get_status_display', 'students', 'discount', 'lessons', 'pub_lessons',
            'price', 'direction', 'direction_name', 'category', 'category_name', 'teacher',
            "chapter_list"
        ]
