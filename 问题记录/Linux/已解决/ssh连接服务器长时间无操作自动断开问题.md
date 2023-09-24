# 解决阿里云ssh远程连接短时间就会断掉的问题

```shell
vim /etc/ssh/sshd_config
# 修改以下参数
ClientAliveInterval 30 #客户端每隔30秒向服务发送一个心跳数据
ClientAliveCountMax 1800 # 客户端多少秒没有相应，服务器自动断掉连接

# 重启服务
service sshd restart
```

## 参考

1. [解决阿里云ssh远程连接短时间就会断掉的问题](https://www.jb51.net/article/190532.htm)
