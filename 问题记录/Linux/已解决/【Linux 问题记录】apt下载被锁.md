# 使用 apt 下载提示被锁的错误

## 问题一

* 错误如下

```shell
E: Could not get lock /var/lib/dpkg/lock-frontend - open (11: Resource temporarily unavailable)
E: Unable to acquire the dpkg frontend lock (/var/lib/dpkg/lock-frontend), is another process using it?
```

## 解决方法一

```shell
sudo rm /var/cache/apt/archives/lock-frontend
sudo  rm /var/lib/dpkg/lock-frontend
```

## 问题二

```shell
E: Could not get lock /var/lib/apt/lists/lock - open (11: Resource temporarily unavailable)
E: Unable to lock directory /var/lib/apt/lists/
```

## 解决方法二

```shell
sudo rm /var/lib/apt/lists/lock
```

## 参考

1. [ubuntu 常见问题系列：E：Could not get lock /var/lib/dpkg/lock-frontend - open](https://my.oschina.net/u/3803405/blog/3098643)
2. [解决 E: Could not get lock /var/lib/apt/lists/lock](https://www.cnblogs.com/qq952693358/p/6537846.html)
