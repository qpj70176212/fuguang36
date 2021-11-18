from django.contrib import admin
from django.contrib.auth.admin import UserAdmin  # 密码加密功能
from django.utils.translation import gettext, gettext_lazy as _
from .models import User
# Register your models here.


class UserModelAdmin(UserAdmin):
    # list_display = ["id", "username", "avatar_small", "money"]
    fieldsets = (
        (None, {'fields': ('username', 'password')}),
        (_('Personal info'), {'fields': ('first_name', 'last_name', 'email')}),
        (_('Permissions'), {
            'fields': ('is_active', 'is_staff', 'is_superuser', 'groups', 'user_permissions'),
        }),
        (_('Important dates'), {'fields': ('last_login', 'date_joined')}),
    )
    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': ('username', 'password1', 'password2'),
        }),
    )
    ordering = ("id",)


admin.site.register(User, UserModelAdmin)
