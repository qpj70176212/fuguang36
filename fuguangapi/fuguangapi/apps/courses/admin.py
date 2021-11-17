from django.contrib import admin
from .models import Course, CourseChapter, CourseDirection, CourseLesson, CourseCategory, Teacher
# Register your models here.


class CourseDirectionModelAdmin(admin.ModelAdmin):
    """学习方向的模型管理器"""
    pass


admin.site.register(CourseDirection, CourseDirectionModelAdmin)


class CourseCategoryModelAdmin(admin.ModelAdmin):
    """课程分类的模型管理器"""
    pass


admin.site.register(CourseCategory, CourseCategoryModelAdmin)


class CourseModelAdmin(admin.ModelAdmin):
    """课程信息的模型管理器"""
    pass


admin.site.register(Course, CourseModelAdmin)


class TeacherModelAdmin(admin.ModelAdmin):
    """讲师信息的模型管理器"""
    pass


admin.site.register(Teacher, TeacherModelAdmin)


class CourseChapterModelAdmin(admin.ModelAdmin):
    """课程章节的模型管理器"""
    pass


admin.site.register(CourseChapter, CourseChapterModelAdmin)


class CourseLessonModelAdmin(admin.ModelAdmin):
    """课程课时的模型管理器"""
    pass


admin.site.register(CourseLesson, CourseLessonModelAdmin)

