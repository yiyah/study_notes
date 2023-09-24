# 【Linux 问题记录】（2）编译时出现 virtual memory exhausted: Cannot allocate memory 或 c++: internal compiler ereor: killed(program cciplus)

---

* 使用 `free -m` 查看内存使用状态

---

[TOC]

## 一、问题

### 1. virtual memory exhausted: Cannot allocate memory

![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190501072617.png)

### 2. c++: internal compiler ereor: killed(program cciplus)

![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190501113401.png)

## 二、解决方法

### 方法一: 使用交换分区

出现这两个问题的原因都是因为编译时内存不足，临时使用交换分区来解决：

```shell
# 1. 创建分区
sudo dd if=/dev/zero of=/swapfile bs=1M count=1024    # 1 * 1024 = 1024 创建 1 g 的内存分区
sudo mkswap /swapfile
sudo swapon /swapfile

# free -m    #可以查看内存使用
# 创建完交换分区之后就可以继续编译
# 编译完之后记得用以下命令关闭交换分区
# 某次我就是忘了关闭交换分区，导致开不了机，然后切换 tty1 ，登进去之后关闭交换分区才可以进入桌面的。

#2. 关闭分区
sudo swapoff /swapfile
sudo rm /swapfile
```

但是有可能你运行`sudo dd if=/dev/zero of=/swapfile bs=1M count=1024` 这条命令的时候它也会给你报个错

比如：

`dd: failed to open '/swapfile': Text file busy`  如下图：

![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190501113728.png)

这个时候你只需要运行 `sudo swapoff -a` 即可解决。然后继续创建交换分区即可。

### 方法二: 清除内存

* 关于此方法，可参考3 的内容，了解了解。

```shell
sudo sh -c 'echo 1 > /proc/sys/vm/drop_caches'
sudo sh -c 'echo 2 > /proc/sys/vm/drop_caches'
sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'
```

## 三、参考

1. [Linux上创建SWAP文件/分区](https://blog.csdn.net/zhangxiaoyang0/article/details/82501209)
2. [Ubuntu16.04用命令释放内存](https://blog.csdn.net/qq_25604813/article/details/83615330)
3. [buff/cache 了解一下？](https://www.cnblogs.com/byfboke/articles/9012780.html)
