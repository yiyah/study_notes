# 更改源

---

[TOC]

# 方法一：
我目前用的是 Ubuntu1804x64
要修改的文件在  ```/etc/apt/sources.list```

## 1. 先备份（先 cd 到 /etc/apt/ 目录）
```
sudo cp sources.list copy_sources.list
```
## 2. 修改 sources.list 里的内容

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190517012500.png)
```
sudo gedit sources.list
```
覆盖保存
```
deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse

deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse

deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse

deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
```

## 3. 更新软件列表
```
sudo apt-get update
```
## 4. 更新软件包
```
sudo apt-get upgrade
```

# 方法二：
![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190509205035.png)
![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190509205410.png)


# 参考：
1. https://blog.csdn.net/zhangjiahao14/article/details/80554616
2. https://www.cnblogs.com/litifeng/p/9123818.html