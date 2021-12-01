# Generated by Django 3.2.9 on 2021-11-30 15:20

import datetime
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('courses', '0007_auto_20211129_1412'),
    ]

    operations = [
        migrations.AddField(
            model_name='course',
            name='credit',
            field=models.IntegerField(blank=True, default=0, null=True, verbose_name='积分'),
        ),
        migrations.AlterField(
            model_name='activity',
            name='end_time',
            field=models.DateTimeField(default=datetime.datetime(2021, 11, 30, 15, 20, 9, 841551), verbose_name='结束时间'),
        ),
        migrations.AlterField(
            model_name='activity',
            name='start_time',
            field=models.DateTimeField(default=datetime.datetime(2021, 11, 30, 15, 20, 9, 841510), verbose_name='开始时间'),
        ),
        migrations.AlterField(
            model_name='course',
            name='price',
            field=models.DecimalField(blank=True, decimal_places=2, default=0, max_digits=10, null=True, verbose_name='课程原价'),
        ),
    ]