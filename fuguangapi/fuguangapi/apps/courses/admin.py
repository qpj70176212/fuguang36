from django.contrib import admin
from .models import Course, CourseChapter, CourseDirection, CourseLesson, CourseCategory, Teacher, Activity, Discount, DiscountType, CourseActivityPrice


# Register your models here.


class CourseCategoryInLine(admin.StackedInline):
    """课程分类的内嵌类"""
    model = CourseCategory
    fields = ["id", "name", "orders"]


class CourseDirectionModelAdmin(admin.ModelAdmin):
    """学习方向的模型管理器"""
    list_display = ["id", "name", "recommend_home_hot", "recommend_home_top"]
    # 默认排序字段
    ordering = ["id"]
    # 字段过滤
    list_filter = ["recommend_home_hot", "recommend_home_top"]
    # 搜索字段
    search_fields = ["name"]
    # 内嵌外键数据
    inlines = [CourseCategoryInLine]
    # 分页配置，一夜数据量
    list_per_page = 10


admin.site.register(CourseDirection, CourseDirectionModelAdmin)


class CourseCategoryModelAdmin(admin.ModelAdmin):
    """课程分类的模型管理器"""
    list_display = ["id", "name", "direction"]
    ordering = ["id"]
    list_filter = ["direction"]
    search_fields = ["name"]
    # 分页配置，一页数据量
    list_per_page = 10
    # 更新数据时的表单配置项
    fieldsets = (
        ("必填", {"fields": ('name', 'direction', 'remark')}),
        ("选填", {
            'classes': ('collapse',),
            'fields': ('is_show', 'orders')
        })
    )

    # 添加数据时的表单配置项
    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': ('name', 'direction', 'remark')
        }),
    )

    # 当前方法会在显示表单的时候，自动执行，返回值就是表单配置项
    # def get_fieldsets(self, request, obj=None):
    #     """
    #     获取表单配置项
    #     :param request: 客户端的http请求对象
    #     :param obj: 本次修改的模型对象，如果时添加数据操作，则obj为None
    #     :return:
    #     """
    #     if not obj:
    #         return self.add_fieldsets
    #     # return super(CourseCategoryModelAdmin, self).get_fieldsets(request, obj)
    #     return super().get_fieldsets(request, obj)

    def get_fieldsets(self, request, obj=None):
        if not obj:
            return self.add_fieldsets
        return super().get_fieldsets(request, obj)


admin.site.register(CourseCategory, CourseCategoryModelAdmin)


class CourseModelAdmin(admin.ModelAdmin):
    """课程信息的模型管理器"""
    list_display = ["id", 'name', "course_cover_small", "course_type", "level", "pub_date", "students", "lessons",
                    "price"]
    # 分页配置 一页数据量
    list_per_page = 10
    ordering = ["id"]
    # 设置过滤器的字段条件
    list_filter = ["direction", "category"]  # 过滤器,按指定字段的不同值来进行展示


admin.site.register(Course, CourseModelAdmin)


class TeacherModelAdmin(admin.ModelAdmin):
    """讲师信息的模型管理器"""
    list_display = ["id", "name", "avatar_small", "title", "role", "signature"]
    # 分页配置 一页数据量
    list_per_page = 10
    # 默认排序
    ordering = ['id']
    # 搜索字段
    search_fields = ["name", "title", "role", "signature"]


admin.site.register(Teacher, TeacherModelAdmin)


class CourseChapterModelAdmin(admin.ModelAdmin):
    """课程章节的模型管理器"""
    list_display = ["id", "text", "pub_date"]
    # 分页配置 一页数据量
    list_per_page = 10
    ordering = ["id"]


admin.site.register(CourseChapter, CourseChapterModelAdmin)


class CourseLessonModelAdmin(admin.ModelAdmin):
    """课程课时的模型管理器"""
    list_display = ["id", "text", "text2", "lesson_type", "duration", "pub_date", "free_trail"]
    # 分页配置 一页数据量
    list_per_page = 10
    ordering = ["id"]

    def text(self, obj):
        return obj.__str__()

    text.admin_order_field = "orders"
    text.short_description = "课时名称"


admin.site.register(CourseLesson, CourseLessonModelAdmin)


class ActivityModelAdmin(admin.ModelAdmin):
    """优惠活动的模型管理器"""
    list_display = ["id", "name", "start_time", "end_time", "remark"]
    ordering = ["id"]


admin.site.register(Activity, ActivityModelAdmin)


class DiscountTypeModelAdmin(admin.ModelAdmin):
    """优惠类型的模型管理器"""
    list_display = ["id", "name", "remark"]
    ordering = ["id"]


admin.site.register(DiscountType, DiscountTypeModelAdmin)


class DiscountModelAdmin(admin.ModelAdmin):
    """优惠公式的模型管理器"""
    list_display = ["id", "name", "discount_type", "condition", "sale"]
    ordering = ["id"]


admin.site.register(Discount, DiscountModelAdmin)


class CourseActivityPriceModelAdmin(admin.ModelAdmin):
    """课程活动价格的模型管理器"""
    list_display = ["id", "activity", "course", "discount"]
    ordering = ["id"]


admin.site.register(CourseActivityPrice, CourseActivityPriceModelAdmin)
