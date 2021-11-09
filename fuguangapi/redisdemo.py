from redis import Redis, StrictRedis

if __name__ == '__main__':
    # redis = StrictRedis()
    # # print(redis)
    # # 字符串操作
    # # 设置一个字符串
    # # 终端命令，set name xiaoming
    # redis.set("name", "xiaoming")

    # 连接redis的写法有2种：
    # redis = Redis.from_url(url="redis://:123456@127.0.0.1:6379/0")
    redis = Redis.from_url(url="redis://:@127.0.0.1:6379/0")
    # redis = Redis(host="127.0.0.1", port=6379, db=0, password="123456")
    # 字符串操作
    # set name xiaoming
    redis.set("name", "xiaohong")

    # get name
    ret = redis.get("name")
    # redis中最基本的数据类型时字符串，但是这种字符串时bytes
    # 所以对于Python而言，读取出来的字符串数据还要decode才能使用
    # print(ret.decode())  # xiaohong

    redis.delete("username")
    ret = redis.get("username")
    # print(ret)   # 不存在的数据结果是None

    # 设置有效期
    # setex key seconds value
    mobile = "13312345678"
    # redis.setex(f"code_{mobile}", 10, "333333")
    # 提取数据
    code_bytes = redis.get(f"code_{mobile}")
    # print(code_bytes.decode())
    if code_bytes:  # 判断只有获取到数据才需要decode解码
        print(code_bytes.decode())

    # 设置哈希字典，单个成员
    # hset user name xiaoming
    # redis.hset(name="user", key="name", value="xiaohuang")
    # 设置hash字典，多个成员
    # hset user name xiaohong age 12 sex 1
    data = {
        "name": "xiaohong",
        "age": 12,
        "sex": 1
    }
    # redis.hset("user", mapping=data)
    # 获取字典所有成员，字典的所有成员都是键值对，而键值对也是bytes类型，所以需要推导式进行转换
    # ret = redis.hgetall("user")
    # print(ret)
    # data = {key.decode(): value.decode() for (key, value) in ret.items()}
    # print(data)

    # 获取所有的key
    ret = redis.keys("*")
    print(ret)
    # 删除key
    # if len(ret) > 0:
        # redis.delete(ret[0])

