from django.contrib import admin
from django.contrib.auth.admin import UserAdmin  # 密码加密功能
from .models import User
# Register your models here.


class UserModelAdmin(UserAdmin):
    pass


admin.site.register(User, UserModelAdmin)
