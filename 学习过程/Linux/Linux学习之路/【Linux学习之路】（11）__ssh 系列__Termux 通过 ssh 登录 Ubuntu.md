# 手机 Termux 通过 ssh 登录 Ubuntu

我的手机安装了 termux，然后在本篇文章中相当于客户端，Ubuntu是服务器。

[TOC]

## 一、环境

### 1.  物理环境

![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190509001454.png)

### 2. 手机端环境

* 需要 ssh（openssh）

#### 2.1 安装 openssh

```bash
pkg update
pkg install openssh
# 开启 ssh 服务
sshd
# 手机端环境搞定
```

### 3. 电脑端环境

* Ubuntu 需要 ifconfig（net-tools），ssh（openssh-server）
* win 下需要关闭防火墙，确认VMware 的服务都开启了（看参考3）

#### 3.1 安装 ssh

```bash
# 确认自己有没有 ssh 服务
sudo ps -e |grep ssh    # 如果没有返回东西，或者返回的内容没有 sshd 字眼的就是没有 ssh
# 安装 ssh
sudo apt-get install openssh-server -y
# 启动 ssh 服务
sudo service ssh start
```

#### 3.2 安装 net-tools

```bash
sudo apt-get install net-tools -y
```

#### 3.3 设置 Ubuntu 的联网方式为桥接

why? 看下面的 问题 1。

* 首先关闭客户机 —> 对要操作客户机右键  —> 设置 —>  按下图设置   ，保存确定。

![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190509030038.png)

* 在打开 VMware 上的选项卡 —> 编辑 —>  虚拟网络编辑器  —>  更改设置（右下角，需管理员身份） —>   按下图设置  —>  确定保存 。如果想用 wifi 的就选择无线网卡就好了，并不影响后面的操作。

![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190509030610.png)

* 这个时候开机之后，虚拟机是可以 ping 通宿主机的。然后我 ifconfig 一下，看看当前的 Ubuntu 的网络参数和宿主机是否一样，一样就不用设静态 IP ，结果发现我的 Ubuntu 就是一开机之后 DNS ，网关，网段啊什么的都是和宿主机一样，所以就不用设静态 IP 了，我按照网上的设静态 IP 的方法在 Ubuntu 操作一波结果连网都连不上了。

* 但是如果虚拟机和宿主机并不在同一个网段里，那它就不能和宿主机所在的局域网的其他设备通信了。因为虚拟机是由 DHCP 自动分配地址的。所以此时我们关闭 DHCP ，然后设静态IP 就可以解决了。如果真不在同一网段，我推荐先试一下以下这条命令（因为我修改`/etc/network/`interfaces 这个配置文件连网都上不了，dns 是在）：

    ```bash
    sudo ifconfig ens33 192.168.1.100  # ens33 是你网卡的名字，后面的地址是你想要设置的静态 IP
    ```

#### 3.4 验证

Ubuntu IP ：192.168.1.101
WIN IP：192.108.1.107
手机 IP：192.168.1.100

* 首先我们试一下 宿主机 能不能和 Ubuntu 互相 ping 通

![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190509113248.png)

* 再试一下 WIN 和 手机 能不能 互 ping 通

![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190509130430.png)
![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190509130514.png)

* 再试一下 Ubuntu 和 手机 能不能 互 ping 通

<figure >
	<img src = "https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190509113638.png" width = "400">
	<img src = "https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190509113913.png" width = "420">
</figure>
OK,现在局域网里的各个设备都能通信了。

### 4. 至此，你的环境都搭配好了

## 二、生成密钥对，然后把公钥给到对方，这个步骤和之前的一样了，不累赘了

**难的就是 Ubuntu 要用桥接方式来接入局域网。**

## 问题

1. why 设置桥接？

    相信大家装虚拟机的时候都是选择 NAT 的联网方式吧！要想虚拟机也访问局域网下的其他设备，就必须设成桥接。
    一开始我也不信，我就在 NAT 下，对虚拟机的 ip，掩码，网关全部设为和宿主机一样（ip 设为同一网段）。然后开始 ping 一下虚拟机与宿主机，试一试能不能通信，经实验验证发现是    不行的。
    然后看了网上好多文章，我自己简单的说一下自己理解：
    首先，给初学者提醒，我用的是笔记本，有两张网卡，一张有线网卡，一张无线网卡（高通）。平时用网线上网就接在有线网卡；用 wifi 上网就用无线网卡。（因为我也是小菜鸡，一开始不懂这些，但是网上的文章也没有说清楚，他们只说桥接到网卡上（多数桥接到无线网卡），我以为电脑就一个网卡，能够处理有线和无线的。我的 Ubuntu 下右没有无线网卡的驱动，然后打开 wifi 的选项只看到`No Wi-Fi Adapter Found` （就是说我没有驱动），然后接下来弄了几个小时，一直找解决方法，怎么装驱动啊什么的，然后最后，发现说， Linux 对高通网卡并不太友好。GG，但是因为有了这些经验，我知道我可以用有线网卡去桥接，所以接下来的部分都是用有线网卡桥接的，用无线网卡桥接也是一样的步骤，不同的只是桥接到哪个网卡上而已。）

    * 桥接：就是让虚拟机用你的宿主机的网卡上网（我这就是让 Ubuntu 用 windows 用的网卡上网）。这样子，如果你的网卡接在了一个局域网里，我的 Ubuntu 也可以和该局域网的其他设备通信。
    * NAT：VMware 这个软件会虚拟出一张网卡  ....（这个我意会言转不了，讲不太清楚，为了避免误导，大家可以看下 参考4和5）

2. 如果发现 Ubuntu 的 ip 无法更改的情况，一定一定去看一下是不是桥接，因为我就是明明设置了桥接，然后做完一切发现 Ubuntu 的 ip 怎么都无法修改，原来是 不知道为什么又变回了 NAT 。

## 参考

1. [Ubuntu 下查看 ssh 服务是否安装或启动的方法_LINUX_操作系统 - 编程客栈](http://www.cppcns.com/os/linux/177753.html)
2. [检查你的 linux （ubuntu）服务器有没有安装 ssh](https://blog.csdn.net/joe_le/article/details/79428543)
3. [解决 VMware 虚拟机 ubuntu 版本的 Linux 系统连接不上网络，连接不上 wifi](https://blog.csdn.net/qq_36045385/article/details/81506540)
4. [wmware 的 vmnet0、vmnet1、vmnet8](https://www.cnblogs.com/asker009/p/10143698.html)
5. [虚拟机 vmnet0、vmnet1 和 vmnet8 的区别](https://www.cnblogs.com/feifei-cyj/p/7686166.html)
6. [Ubuntu 下修改 DNS 重启也能用的方法](<https://blog.csdn.net/todd911/article/details/9251087>)
7. [linux 下 /etc/network/interfaces 作用](<https://blog.csdn.net/guoyaoyao1990/article/details/12623729>)
