from django.db import models
from fuguangapi.utils.models import BaseModel, models
# Create your models here.

class Nav(BaseModel):
    """导航菜单"""
    # 字段选项
    # 模型对象.<字段名> ---> 实际数据
    # 模型对象.get_<字段名>_display() ---> 文本提示
    POSITION_CHOICES = (
        # (实际数据，“文本提示”)
        (0, "顶部导航"),
        (1, "脚部导航")
    )

    link = models.CharField(max_length=255, verbose_name="导航连接")
    is_http = models.BooleanField(default=False, verbose_name="是否站外连接地址")
    position = models.SmallIntegerField(default=0, choices=POSITION_CHOICES,
                                        verbose_name="导航位置")

    class Meta:
        db_table = "fg_nav"
        verbose_name = "导航菜单"
        verbose_name_plural = verbose_name


from models import BaseModel, models

class Banner(BaseModel):
    image = models.ImageField(upload_to="banner/%Y/", verbose_name="图片地址")
    link = models.CharField(max_length=500, verbose_name="链接地址")
    note = models.CharField(max_length=150, verbose_name="备注信息")
    is_http = models.BooleanField(default=False, verbose_name="是否外链地址",
                                  help_text="站点链接地址: http://www.baidu.con/book<br>站点链接地址: /book/")

    class Meta:
        db_table = "fg_banner"
        verbose_name = "轮播广告"
        verbose_name_plural = verbose_name