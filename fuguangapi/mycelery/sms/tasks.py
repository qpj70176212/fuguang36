from ..main import app
from ronglianyunapi import send_sms as send_sms_code


@app.task
def send_sms1():
    """没有任何参数的异步任务"""
    print('任务: send_sms1执行了...')


@app.task(name="send_sms2")
def send_sms2(mobile, code):
    """有参数的异步任务"""
    print(f'任务: send_sms2执行了...mobile={mobile}, code={code}')


@app.task
def send_sms3():
    """有结果的异步任务"""
    print('任务: send_sms3执行了...')
    return 100


@app.task(name="send_sms4")
def send_sms4(x, y):
    """有结果的异步任务"""
    print('任务: send_sms4执行了...')
    return x + y


@app.task(name="send_sms")
def send_sms(tid, mobile, datas):
    """发送短信"""
    return send_sms_code(tid, mobile, datas)
