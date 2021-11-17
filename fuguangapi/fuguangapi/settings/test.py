"""
Django settings for fuguangapi project.

Generated by 'django-admin startproject' using Django 3.2.5.

For more information on this file, see
https://docs.djangoproject.com/en/3.2/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/3.2/ref/settings/
"""
import sys
from pathlib import Path

# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve().parent.parent

# BASE_DIR = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(BASE_DIR / "apps"))
sys.path.insert(0, str(BASE_DIR / "utils"))
# print(sys.path)
# path = os.path.join(BASE_DIR, 'fuguangapi', 'apps')
# sys.path.append(path)

# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/3.2/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = 'django-insecure-l8tj#^lknpchumj098ng!vp6z*j5ujj)!a5yepjab8^uli=7zr'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True
# DEBUG = False

# 是否处于测试环境下
IS_TEST = True

# ALLOWED_HOSTS = []
ALLOWED_HOSTS = ["*"]


# Application definition

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'rest_framework',
    'corsheaders', # cors跨域子应用
    'home',
    'users'

]

MIDDLEWARE = [
    'corsheaders.middleware.CorsMiddleware',  # cors跨域的中间件
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'fuguangapi.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'fuguangapi.wsgi.application'


# Database
# https://docs.djangoproject.com/en/3.2/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'fuguang',
        'USER': 'root',
        'PASSWORD': '123',
        'HOST': '127.0.0.1',
        'PORT': '3306',
        'POOL_OPTIONS': {      # 连接池的配置信息
            'POOL_SIZE': 10,    # 连接池默认创建的链接对象的数量
            'MAX_OVERFLOW': 10  # 连接池默认创建的链接对象的最大数量
        }
    }

}

# 缓存
CACHES = {
    "default": {
        "BACKEND": "django_redis.cache.RedisCache",
        # 项目上线时，需要调整这里的路径
        "LOCATION": "redis://127.0.0.1:6379/0",
        "OPTIONS": {
            "CLIENT_CLASS": "django_redis.client.DefaultClient",
        }
    },
    # 提供给admin或者session存储
    "session": {
        "BACKEND": "django_redis.cache.RedisCache",
        "LOCATION": "redis://127.0.0.1:6379/1",
        "OPTIONS": {
            "CLIENT_CLASS": "django_redis.client.DefaultClient",
        }
    },
    # 提供存储短信验证码
    "sms_code": {
        "BACKEND": "django_redis.cache.RedisCache",
        "LOCATION": "redis://127.0.0.1:6379/2",
        "OPTIONS": {
            "CLIENT_CLASS": "django_redis.client.DefaultClient",
        }
    },
}

# 设置admin运营站点用户登录时,登录信息session保持到redis
SESSION_ENGINE = "django.contrib.sessions.backends.cache"
# 设置session保持的位置对应的缓存配置项
SESSION_CACHE_ALIAS = "session"  # 指定redis连接配置

# Password validation
# https://docs.djangoproject.com/en/3.2/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]


# Internationalization
# https://docs.djangoproject.com/en/3.2/topics/i18n/

# LANGUAGE_CODE = 'en-us'
LANGUAGE_CODE = 'zh-hans'

# TIME_ZONE = 'UTC'
TIME_ZONE = 'Asia/Shanghai'

USE_I18N = True

USE_L10N = True

USE_TZ = True


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/3.2/howto/static-files/

STATIC_URL = '/static/'

# Default primary key field type
# https://docs.djangoproject.com/en/3.2/ref/settings/#default-auto-field

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'


# 日志配置
# https://docs.djangoproject.com/zh-hans/3.2/topics/logging/
LOGGING = {
    'version': 1,  # 使用的日志模块的版本，目前官方提供的只有版本1，但是官方有可能会升级，为了避免升级出现的版本问题，所以这里固定为1
    'disable_existing_loggers': False,  # 是否禁用其他的已经存在的日志功能？肯定不能，有可能有些第三方模块在调用，所以禁用了以后，第三方模块无法捕获自身出现的异常了。
    'formatters': {  # 日志格式设置，verbose或者simple都是自定义的
        'verbose': {  # 详细格式，适合用于开发人员不在场的情况下的日志记录。
            # 格式定义：https://docs.python.org/3/library/logging.html#logrecord-attributes
            # levelname 日志等级
            # asctime   发生时间
            # module    文件名
            # process   进程ID
            # thread    线程ID
            # message   异常信息
            'format': '{levelname} {asctime} {module} {funcName} {process:d} {thread:d} {message}',
            'style': '{',  # 变量格式分隔符
        },
        'simple': {  # 简单格式，适合用于开发人员在场的情况下的终端输出
            'format': '{levelname} {module} {funcName} {message}',
            'style': '{',
        },
    },
    'filters': {  # 过滤器
        'require_debug_true': {
            '()': 'django.utils.log.RequireDebugTrue',
        },
    },
    'handlers': { # 日志处理流程，console或者mail_admins都是自定义的。
        'console': {
            'level': 'DEBUG',  # 设置当前日志处理流程中的日志最低等级
            'filters': ['require_debug_true'],  # 当前日志处理流程的日志过滤
            'class': 'logging.StreamHandler',  # 当前日志处理流程的核心类，StreamHandler可以帮我们把日志信息输出到终端下
            'formatter': 'simple'              # 当前日志处理流程的日志格式
        },
        # 'mail_admins': {
        #     'level': 'ERROR',                  # 设置当前日志处理流程中的日志最低等级
        #     'class': 'django.utils.log.AdminEmailHandler',  # AdminEmailHandler可以帮我们把日志信息输出到管理员邮箱中。
        #     'filters': ['special']             # 当前日志处理流程的日志过滤
        # }
        # 按文件大小来分割日志
        'file': {
            'level': 'DEBUG',
            'class': 'logging.handlers.RotatingFileHandler',
            # 日志位置,日志文件名，日志保存目录logs必须手动创建
            'filename': BASE_DIR.parent / "logs/fuguang.log",
            # 单个日志文件的最大值，这里我们设置300M
            'maxBytes': 300 * 1024 * 1024,
            # 备份日志文件的数量，设置最大日志数量为10
            'backupCount': 20,
            # 日志格式: 详细格式
            'formatter': 'verbose'
        },
    },
    'loggers': {  # 日志处理的命名空间
        'django': {  # 要在django中调用当前配置项的loging写入日志到文件中，名字必须叫"django"
            'handlers': ['console', 'file'],  # 当基于django命名空间写入日志时，调用那几个日志处理流程
            'propagate': True,   # 是否在django命名空间对应的日志处理流程结束以后，冒泡通知其他的日志功能。True表示允许
        },
    }
}


# drf配置
REST_FRAMEWORK = {
    # 自定义异常处理
    'EXCEPTION_HANDLER': 'fuguangapi.utils.exceptions.exception_handler',
    # 自定义认证
    'DEFAULT_AUTHENTICATION_CLASSES': (
        'rest_framework_jwt.authentication.JSONWebTokenAuthentication',
        'rest_framework.authentication.SessionAuthentication',
        'rest_framework.authentication.BasicAuthentication',
    ),
}

import datetime
JWT_AUTH = {
    # 设置jwt的有效期 默认300秒
    # 'JWT_EXPIRATION_DELTA': datetime.timedelta(weeks=1),  # 一周有效
    'JWT_EXPIRATION_DELTA': datetime.timedelta(minutes=1),  # 一周有效
    # 自定义载荷
    'JWT_PAYLOAD_HANDLER': 'fuguangapi.utils.authenticate.jwt_payload_handler'
}

# CORS 跨域资源共享
CORS_ALLOW_ALL_ORIGINS = True


# 访问静态文件的url地址前缀
STATIC_URL = '/static/'
# 设置django的静态文件目录[手动创建]
STATICFILES_DIRS = [
    BASE_DIR / "static",
]

# 项目中存储上传文件的根目录[手动创建]，注意，uploads目录需要手动创建否则上传文件时报错
MEDIA_ROOT = BASE_DIR / "uploads"
# 访问上传文件的url地址前缀
MEDIA_URL = "/uploads/"

# 自定义认证用户使用的模型对象
# AUTH_USER_MODEL 参数的设置以点.来分隔，表示应用名.模型类名。
AUTH_USER_MODEL = 'users.User'

# django自定义认证
AUTHENTICATION_BACKENDS = ['fuguangapi.utils.authenticate.CustomAuthBackend']

# 腾讯云API接口配置
TENCENTCLOUD = {
    # 腾讯云访问秘钥ID
    "SecretId": "AKIDvf9MIyMTKuDF0TjjSt4ybw2sQhqiJceQ",
    # 腾讯云访问秘钥key
    "SecretKey": "XmkSt4ycy3rOedKlvpSnreAPN5WfX9TW",
    # 验证码API配置
    "Captcha": {
        # 验证码校验服务端域名
        "endpoint": "captcha.tencentcloudapi.com",
        # 固定填值：9。可在控制台配置不同验证码类型。
        "CaptchaType": 9,
        "CaptchaAppId": 2071744404,  # 验证码应用ID
        # 用于服务器端校验验证码票据的验证密钥，请妥善保密，请勿泄露给第三方
        "AppSecretKey": "02DN3yBANi1xeXI-BQitJug** "
    }
}


# 容联云短信
RONGLIANYUN = {
    # accId	String	开发者主账号,登陆云通讯网站后,可在控制台首页看到开发者主账号ACCOUNT SID
    "accId": "8aaf07087ce03b67017d141ad4380ba6",
    # accToken	String	主账号令牌 TOKEN,登陆云通讯网站后,可在控制台首页看到主账号令牌AUTH TOKEN
    "accToken": "b3f15b8095b34862b4e9f82c234ae477",
    # appId	String	请使用管理控制台中已创建应用的APPID
    "appId": "8aaf07087ce03b67017d141ad5610bad",
    # tid	String	短信模板 ID
    "reg_tid": 1,  # 注册短信验证码的模板ID
    "sms_expire": 300,  # 短信有效期，单位：秒（s）
    "sms_interval": 60,  # 短信发送的冷却时间，单位：秒（s）
}


# Celery异步任务队列框架的配置项【注意：django的配置项必须大写所以这里的所有配置项必须全部大写】
# 任务队列
CELERY_BROKER_URL = 'redis://127.0.0.1:6379/14'
# 结果队列
CELERY_RESULT_BACKEND = 'redis://127.0.0.1:6379/15'
# 时区，于django的时区同步
CELERY_TIMEZONE = TIME_ZONE
# 防止死锁
CELERY_FORCE_EXECV = True
# 设置并发的worker数量
CELERYD_CONCURRENCY = 20
# 设置失败允许重试【这个慎用，如果失败任务无法再次执行成功，会产出指数级别的失败记录】
CELERY_ACKS_LATE = True
# 每个worker工作进程最多执行500个任务被销毁，可以防止内存泄漏，500是举例，根据自己的服务器的性能可以调整数值
CELERYD_MAX_TASKS_PER_CHILD = 500
# 单个任务的最大运行时间，超时会被杀死
CELERYD_TIME_LIMIT = 10 * 60
# 任务发出后，经过一段时间还未收到acknowledge，就将任务重新交给其他worker执行
CELERY_DISABLE_RATE_LIMITS = True
# celery的任务结果内容格式
CELERY_ACCERT_CONTENT = ['json', 'pickle']
# 设置定时任务的调用列表，需要单独运行SCHEDULE命令才能让celery执行定时任务: celery -A mycelery.main beat，当然worker还是要启动的
# https://docs.celeryproject.org/en/stable/userguide/periodic-tasks.html
CELERY_BEAT_SCHEDULE = {
    "user-add": {  # 定时任务的注册标记符【必须唯一的】
        "task": "add",  # 定时任务的任务名称
        "schedule": 10,  # 定时任务的调用时间，10表示每隔10秒调用一次add任务
        # "schedule": crontab(hour=7, minute=30, day_of_week=1),  # 定时任务的调用时间，每周一早上7点30分调用一次add任务
    }
}