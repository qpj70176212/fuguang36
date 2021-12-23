class Router(object):
    """数据库主从读写分离路由"""

    def db_for_read(self, model, **hints):
        """读数据库【从库】"""
        # print("从库被访问了", model)
        return "read1"

    def db_for_write(self, model, **hints):
        """写数据库[写库]"""
        # print("主库被访问了")
        return "default"
