from redis import Redis, StrictRedis

if __name__ == '__main__':
    redis = StrictRedis()
    # print(redis)
    # 字符串操作
    # 设置一个字符串
    # 终端命令，set name xiaoming
    redis.set("name", "xiaoming")
