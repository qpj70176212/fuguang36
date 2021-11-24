import random
import json
from random import choice
from django.db import models
from fuguangapi.utils.models import models, BaseModel
# 不支持上传文件
from ckeditor.fields import RichTextField
# 支持上传文件
from ckeditor_uploader.fields import RichTextUploadingField
from stdimage import StdImageField
from django.utils.safestring import mark_safe  # 站点展示缩略图

# Create your models here.


class CourseDirection(BaseModel):
    name = models.CharField(max_length=255, unique=True, verbose_name="方向名称")
    # remark = models.TextField(default="", blank=True, null=True, verbose_name="方向描述")
    remark = RichTextField(default="", blank=True, null=True, verbose_name="方向描述")
    recommend_home_hot = models.BooleanField(default=False, verbose_name="是否推荐到首页新课栏目")
    recommend_home_top = models.BooleanField(default=False, verbose_name="是否推荐到首页必学栏目")

    class Meta:
        db_table = "fg_course_direction"
        verbose_name = "学习方向"
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.name


class CourseCategory(BaseModel):
    name = models.CharField(max_length=255, unique=True, verbose_name="分类名称")
    # remark = models.TextField(default="", blank=True, null=True, verbose_name="分类描述")
    remark = RichTextField(default="", blank=True, null=True, verbose_name="分类描述")
    direction = models.ForeignKey("CourseDirection", related_name="category_list", on_delete=models.DO_NOTHING,
                                  db_constraint=False, verbose_name="学习方向")

    class Meta:
        db_table = "fg_course_category"
        verbose_name = "课程分类"
        verbose_name_plural = verbose_name

    # def __str__(self):
    #     return self.name


class Course(BaseModel):
    course_type = (
        (0, '付费购买'),
        (1, '会员专享'),
        (2, '学位课程')
    )
    level_choices = (
        (0, '初级'),
        (1, '中级'),
        (2, '高级'),
    )
    status_choices = (
        (0, '上线'),
        (1, '下线'),
        (2, '预上线')
    )
    # course_cover = models.ImageField(upload_to="course/cover", max_length=255, verbose_name="封面图片", blank=True,
    #                                  null=True)
    course_cover = StdImageField(variations={
        'thumb_1080x608': (1080, 608),  # 高清图
        'thumb_540x304': (540, 304),  # 中等比例
        'thumb_108x61': (108, 61, True),  # 小图（第三个参数表示保持图片质量）
    }, upload_to="course/cover", max_length=255, verbose_name="封面图片", blank=True,
                                     null=True)
    course_video = models.FileField(upload_to="course/video", max_length=255, verbose_name="封面视频", blank=True,
                                    null=True)
    course_type = models.SmallIntegerField(choices=course_type, default=0, verbose_name="付费类型")
    # choices提供了一个get_字段_display用于获取选项对应的文本
    # course.level获取的是字段值，
    # course.get_level_display 获取的是字段值在选项中对应的文本
    level = models.SmallIntegerField(choices=level_choices, default=1, verbose_name="难度等级")
    # description = models.TextField(null=True, blank=True, verbose_name="详情介绍")
    description = RichTextUploadingField(null=True, blank=True, verbose_name="详情介绍")
    pub_date = models.DateField(auto_now_add=True, verbose_name="发布日期")
    period = models.IntegerField(default=7, verbose_name="建议学习周期(day)")
    attachment_path = models.FileField(max_length=1000, blank=True, null=True, verbose_name="课件路径")
    attachment_link = models.CharField(max_length=1000, blank=True, null=True, verbose_name="课件链接")
    status = models.SmallIntegerField(choices=status_choices, default=0, verbose_name="课程状态")
    students = models.IntegerField(default=0, verbose_name="学习人数")
    lessons = models.IntegerField(default=0, verbose_name="总课时数量")
    pub_lessons = models.IntegerField(default=0, verbose_name="已更新课时数量")
    price = models.DecimalField(max_digits=10, decimal_places=2, verbose_name="课程原价", default=0)
    recommend_home_hot = models.BooleanField(default=False, verbose_name="是否推荐到首页新课栏目")
    recommend_home_top = models.BooleanField(default=False, verbose_name="是否推荐到首页必学栏目")
    direction = models.ForeignKey("CourseDirection", related_name="course_list", on_delete=models.DO_NOTHING, null=True,
                                  blank=True, db_constraint=False, verbose_name="学习方向")
    category = models.ForeignKey("CourseCategory", related_name="course_list", on_delete=models.DO_NOTHING, null=True,
                                 blank=True, db_constraint=False, verbose_name="课程分类")
    teacher = models.ForeignKey("Teacher", related_name="course_list", on_delete=models.DO_NOTHING, null=True,
                                blank=True, db_constraint=False, verbose_name="授课老师")

    class Meta:
        db_table = "fg_course_info"
        verbose_name = "课程信息"
        verbose_name_plural = verbose_name

    def __str__(self):
        return "%s" % self.name

    def course_cover_small(self):
        if self.course_cover:
            return mark_safe(f'<img style="border-radius: 0%;" src="{self.course_cover.thumb_108x61.url}">')
        return ""

    course_cover_small.short_description = "封面图片(108x61)"
    course_cover_small.allow_tags = True
    course_cover_small.admin_order_field = "course_cover"

    def course_cover_medium(self):
        if self.course_cover:
            return mark_safe(f'<img style="border-radius: 0%;" src="{self.course_cover.thumb_540x304.url}">')
        return ""

    course_cover_medium.short_description = "封面图片(540x304)"
    course_cover_medium.allow_tags = True
    course_cover_medium.admin_order_field = "course_cover"

    def course_cover_large(self):
        if self.course_cover:
            return mark_safe(f'<img style="border-radius: 0%;" src="{self.course_cover.thumb_1080x608.url}">')
        return ""

    course_cover_large.short_description = "封面图片(1080x608)"
    course_cover_large.allow_tags = True
    course_cover_large.admin_order_field = "course_cover"

    @property
    def discount(self):
        # todo 通过计算获取折扣优惠相关的信息
        return {
            "type": choice(["限时优惠", "限时减免"]),  # 优惠类型
            "expire": random.randint(100000, 1200000),  # 优惠倒计时 636050
            "price": float(self.price) - random.randint(1, 10) * 10,  # 优惠价格 1488.00
        }

    def discount_json(self):
        # 必须转成字符串才能保存到es中。所以该方法提供给es使用的。
        return json.dumps(self.discount)

    @property
    def can_free_study(self):
        """是否允许试学"""
        lesson_list = self.lesson_list.filter(is_delete=False, is_show=True, free_trail=True).order_by("orders").all()
        return len(lesson_list) > 0


class Teacher(BaseModel):
    role_choices = (
        (0, '讲师'),
        (1, '导师'),
        (2, '班主任')
    )
    role = models.SmallIntegerField(choices=role_choices, default=0, verbose_name="讲师身份")
    title = models.CharField(max_length=64, verbose_name="职位、职称")
    signature = models.CharField(max_length=255, blank=True, null=True, verbose_name="导师签名")
    # avatar = models.ImageField(upload_to="teacher", null=True, verbose_name="讲师头像")
    # 使用缩略图提供的StdImageFiled字段以后，每次客户端提交图片时，stdImage模块会自动根据字段里面的配置项生成对应尺寸的缩略图
    # delete_orphans 是否联动删除
    avatar = StdImageField(variations={
        'thumb_800x800': (800, 800),  # 'large': (800, 800),
        'thumb_400x400': (400, 400),  # 'medium': (400, 400),
        'thumb_50x50': (50, 50, True),  # 'small': (50, 50, True),
    }, delete_orphans=True, upload_to="teacher", null=True, verbose_name="讲师头像")
    # brief = models.TextField(max_length=1024, verbose_name="讲师描述")
    brief = RichTextUploadingField(max_length=1024, verbose_name="讲师描述")

    class Meta:
        db_table = "fg_teacher"
        verbose_name = "讲师信息"
        verbose_name_plural = verbose_name

    def avatar_small(self):
        if self.avatar:
            return mark_safe(f'<img style="border-radius: 100%;" src="{self.avatar.thumb_50x50.url}">')
        return ""

    avatar_small.short_description = "头像信息(50x50)"
    avatar_small.allow_tags = True
    avatar_small.admin_order_field = "avatar"

    def avatar_medium(self):
        if self.avatar:
            return mark_safe(f'<img style="border-radius: 100%;" src="{self.avatar.thumb_400x400.url}">')
        return ""

    avatar_medium.short_description = "头像信息(400x400)"
    avatar_medium.allow_tags = True
    avatar_medium.admin_order_field = "avatar"

    def avatar_large(self):
        if self.avatar:
            return mark_safe(f'<img style="border-radius: 100%;" src="{self.avatar.thumb_800x800.url}">')
        return ""

    avatar_large.short_description = "头像信息(800x800)"
    avatar_large.allow_tags = True
    avatar_large.admin_order_field = "avatar"

    def __str__(self):
        return "%s" % self.name


class CourseChapter(BaseModel):
    """课程章节"""
    orders = models.SmallIntegerField(default=1, verbose_name="第几章")
    # summary = models.TextField(blank=True, null=True, verbose_name="章节介绍")
    summary = RichTextUploadingField(blank=True, null=True, verbose_name="章节介绍")
    pub_date = models.DateField(auto_now_add=True, verbose_name="发布日期")
    course = models.ForeignKey("Course", related_name="chapter_list", on_delete=models.CASCADE, db_constraint=False,
                               verbose_name="课程名称")

    class Meta:
        db_table = "fg_course_chapter"
        verbose_name = "课程章节"
        verbose_name_plural = verbose_name

    def __str__(self):
        # return "%s-第%s章-%s" % (self.course.name, self.orders, self.name)
        return "%s-第%s章-%s" % (self.course.name, self.orders, self.name)

    # 自定义字段
    def text(self):
        return self.__str__()
    # admin站点配置排序规则和显示的字段文本提示
    text.short_description = "章节名称"
    text.allow_tags = True
    text.admin_order_field = "orders"

    @property
    def get_lesson_list(self):
        """获取课时列表的自定义字段"""
        lesson_list = self.lesson_list.filter(is_delete=False, is_show=True).order_by("orders").all()
        return [{
            "id": lesson.id,
            "name": lesson.name,
            "orders": lesson.orders,
            "duration": lesson.duration,
            "lesson_type": lesson.lesson_type,
            "lesson_link": lesson.lesson_link,
            "free_trail": lesson.free_trail
        } for lesson in lesson_list]


class CourseLesson(BaseModel):
    """课程课时"""
    lesson_type_choices = (
        (0, '文档'),
        (1, '练习'),
        (2, '视频')
    )
    orders = models.SmallIntegerField(default=1, verbose_name="第几节")
    lesson_type = models.SmallIntegerField(default=2, choices=lesson_type_choices, verbose_name="课时种类")
    lesson_link = models.CharField(max_length=255, blank=True, help_text="若是video，填视频地址或者视频id，若是文档，填文档地址",
                                   null=True,verbose_name="课程链接")
    duration = models.CharField(blank=True, null=True, max_length=32, verbose_name="课时时长")  # 仅在前端展示使用
    pub_date = models.DateTimeField(auto_now_add=True, verbose_name="发布时间")
    free_trail = models.BooleanField(default=False, verbose_name="是否可试看")
    recommend = models.BooleanField(default=False, verbose_name="是否推荐到课程列表")
    chapter = models.ForeignKey("CourseChapter", related_name='lesson_list', on_delete=models.CASCADE,
                                db_constraint=False, verbose_name="章节")
    course = models.ForeignKey("Course", related_name="lesson_list", on_delete=models.DO_NOTHING, db_constraint=False,
                               verbose_name="课程")

    class Meta:
        db_table = "fg_course_lesson"
        # db_table = "fg_course_lesson"
        verbose_name = "课程课时"
        verbose_name_plural = verbose_name

    def __str__(self):
        # return "%s-%s" % (self.chapter, self.name)
        return "%s-第%s章-%s-第%s课时-%s" % (self.course.name, self.chapter.orders, self.chapter.name, self.orders, self.name)

    def text2(self):
        return self.__str__()

    text2.short_description = "课时名称"
    text2.allow_tags = True
    text2.admin_order_field = "order"
