# Generated by Django 3.2.9 on 2021-11-17 10:00

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('courses', '0002_auto_20211117_1751'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='courselesson',
            options={'verbose_name': '课程课时', 'verbose_name_plural': '课程课时'},
        ),
        migrations.AlterModelTable(
            name='courselesson',
            table='fg_course_lesson',
        ),
    ]
