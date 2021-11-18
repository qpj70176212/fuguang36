#! /home/moluo/anaconda3/enc/guguang/bin/python

# 首行以后的代码必须符合Python的语法
"""
针对通用代码的运行，可以直接使用系统内置的全局环境Python解释器，也可以使用虚拟环境的解析器
#！/usr/bin/python3
如果这个代码需要调用对应的第三方模块，那么就要写上安装该模块的Python解释器
#！/home/moluo/anaconda3/envs/fuguang/bin/python
"""
import os, sys
from faker import Faker

faker = Faker(["zh_CN"])
user = faker.unique.name()
print(f"hello, {user}")

# python获取终端参数
try:
    dir = sys.argv[1]  # 0 -> ./test1.py  1-> user
except Exception as e:
    dir = "2021"

# python直接执行shell命令
ret = os.popen("ls -l")
print(ret.read())

ret = os.popen(f"mkdir {dir} && cd {dir} && echo 'hello {user}' > index.html")
# ret = os.popen(f"mkdir {dir} && cd {dir} && touch index.html && echo 'hello {user}' > index.html")
print(ret.read())