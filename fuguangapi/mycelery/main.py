import os, django
from celery import Celery

# 初始化Django
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'fuguangapi.settings.dev')
django.setup()

# 实例化celery应用
app = Celery("fuguang")

# 通过app实例对象加载配置
app.config_from_object("mycelery.settings")
# app.config_from_object("mycelery.config")

# 注册任务，自动搜索并加载任务
# 参数必须时一个列表，里面的每一个任务都是任务的路径名称
# app.autodiscover_tasks(["任务1", "任务2", ......])
app.autodiscover_tasks(["mycelery.sms", "mycelery.email"])

# 启动Celery的终端命令
# 强烈建议切换目录到项目的根目录下启动celery！！
# celery -A mycelery.main worker --loglevel=info
