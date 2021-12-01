# Generated by Django 3.2.9 on 2021-12-01 16:04

from django.db import migrations, models
import django.utils.timezone


class Migration(migrations.Migration):

    dependencies = [
        ('courses', '0008_auto_20211130_1520'),
    ]

    operations = [
        migrations.AlterField(
            model_name='activity',
            name='end_time',
            field=models.DateTimeField(default=django.utils.timezone.now, verbose_name='结束时间'),
        ),
        migrations.AlterField(
            model_name='activity',
            name='start_time',
            field=models.DateTimeField(default=django.utils.timezone.now, verbose_name='开始时间'),
        ),
        migrations.AlterField(
            model_name='courselesson',
            name='orders',
            field=models.SmallIntegerField(default=1, verbose_name='第几课时'),
        ),
        migrations.AlterField(
            model_name='discount',
            name='condition',
            field=models.IntegerField(blank=True, default=0, help_text='设置享受优惠的价格条件,如果不填或0则没有使用门槛', verbose_name='满足优惠的价格条件'),
        ),
        migrations.AlterField(
            model_name='discount',
            name='sale',
            field=models.TextField(help_text='\n    0表示免费；<br>\n    *号开头表示折扣价，例如填写*0.82，则表示八二折；<br>\n    -号开头表示减免价，例如填写-100，则表示减免100；<br>', verbose_name='优惠公式'),
        ),
    ]
