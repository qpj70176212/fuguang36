from django.contrib import admin
from django.contrib.auth.admin import UserAdmin  # 密码加密功能
from django.utils.translation import gettext, gettext_lazy as _
from .models import User, Credit, UserCourse
# Register your models here.


class UserModelAdmin(UserAdmin, admin.ModelAdmin):
    list_display = ["id", "username", "avatar_small", "money", "credit", "mobile"]
    list_editable = ["credit"]
    # # fieldsets 和 add_fieldsets 都在从UserAdmin中复制粘贴过来，重写加上自己需要的字段的。
    # 更新数据时的表单配置项
    fieldsets = (
        (None, {'fields': ('username', 'password', "mobile", 'avatar', "money", "credit")}),
        (_('Personal info'), {'fields': ('first_name', 'last_name', 'email')}),
        (_('Permissions'), {
            'fields': ('is_active', 'is_staff', 'is_superuser', 'groups', 'user_permissions'),
        }),
        (_('Important dates'), {'fields': ('last_login', 'date_joined')}),
    )
    # 添加数据时的表单配置项
    add_fieldsets = (
        ("必填项", {
            'classes': ('wide',),
            'fields': ('username', "mobile", 'password1', 'password2', "avatar"),
        }),
        ('可选项', {
            'classes': ('collapse',),  # 折叠样式
            'fields': ('money', 'credit'),
        }),
    )

    def get_fieldsets(self, request, obj=None):
        if not obj:
            return self.add_fieldsets
        return super().get_fieldsets(request, obj)
    ordering = ("id",)
    # 分页配置，一页数据量
    list_per_page = 10

    def save_model(self, request, obj, form, change):
        if change:
            """更新数据"""
            user = User.objects.get(pk=obj.id)
            has_credit = user.credit  # 原来用户的积分数据
            new_credit = obj.credit  # 更新后用户的积分数据

            Credit.objects.create(
                user=user,
                number=int(new_credit - has_credit),
                operation=2,
            )

        obj.save()

        if not change:
            """新增数据"""
            Credit.objects.create(
                user=obj.id,
                number=obj.credit,
                operation=2,  # 系统赠送
            )


admin.site.register(User, UserModelAdmin)


class CreditModelAdmin(admin.ModelAdmin):
    """积分流水的模型管理器"""
    list_display = ["id", "user", "number", "__str__"]
    ordering = ["id"]


admin.site.register(Credit, CreditModelAdmin)


class UserCourseModelAdmin(admin.ModelAdmin):
    """用户的课程的模型管理器"""
    list_display = ["id", "user", "course", "chapter", "lesson", "study_time", "__str__"]
    ordering = ["id"]


admin.site.register(UserCourse, UserCourseModelAdmin)
