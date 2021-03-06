from rest_framework.views import exception_handler as drf_exception_handler

from django.db import DatabaseError
from rest_framework.response import Response
from rest_framework import status
from redis.exceptions import RedisError

import logging
logger = logging.getLogger('django')


def exception_handler(exc, context):
    """
    自定义异常处理
    :param exc: 异常类  本次出现异常的异常实例对象
    :param context: 抛出异常的上下文
    :return: Response响应对象
    """
    # 调用drf框架原生的异常处理方法
    # response = exception_handler(exc, context)
    response = drf_exception_handler(exc, context)

    if response is None:
        view = context['view']
        # 判断异常属于DatabaseError的实例对象
        if isinstance(exc, DatabaseError):
            # 数据库异常
            logger.error('[%s] %s' % (view, exc))
            response = Response({'message': '服务器内部错误'}, status=status.HTTP_507_INSUFFICIENT_STORAGE)
        elif isinstance(exc, RedisError):
            logger.error("redis操作异常！[%s] %s" % (view, exc))
            response = Response({"errmsg": "内部存储错误"}, status=status.HTTP_507_INSUFFICIENT_STORAGE)

    return response
