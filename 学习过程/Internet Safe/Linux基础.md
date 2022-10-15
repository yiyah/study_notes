# Linux 基础

[TOC]

## 一、常用命令

```shell
find 目录 -name 文件名

# =====================================
uname     # 查看系统相关信息
uname -a  # 显示主机名、内核版本、硬件平台等详细信息
uname -r  # 显示内核版本
hostname  # 查看主机的完整名称
cat /proc/cpuinfo  # 查看 cpu 信息
cat /proc/meminfo  # 内存信息

du -sh /etc  # 查看文件（夹）大小

# =====================================
useradd yiya     # 添加账户 yiya
userdel -r yiya  # 删除 yiya 的账户，不加 -r 的话，yiya 的家目录不会被删除
passwd yiya      # 修改 yiya 的密码

# =====================================
service network restart  # 重启 网络服务
ifdown eth0  # 禁用网络接口
ifup eth0    # 启用网络接口

# 计划任务==============================
crontab -e  # 进入编辑模式（第一次进入，会让你选择编辑器），注意，新创建的任务至少等2分钟后才执行
# 格式： 分 时 日 月 周 命令，如以下
30 13 * * * touch /test.txt
crontab -l  # 查看计划任务
```

## 关于 Red Hat 的软件安装

### 1. 通过 RPM 安装

step1: 加载 iso，通过以下命令挂载光驱

```shell
umount /dev/sr0  # 先卸载 光驱0 （iso在光驱0）
mount /dev/sr0 /media  # 把光驱挂载在 /media 目录
# 此时 iso 文件内的安装包都在 /media/Packages 下
```

step2: 安装 `rpm -ivh 软件名称` （-i 就可以了，vh 是现实安装过程）

### 2. 通过 yum 安装

* 该步骤是在【1. 通过 RPM 安装】的基础上进行的，即 yum 安装的软件还是 iso 内的。至于如何配置从网络上下载，待以后解决。

step1: 配置 yum 源

```shell
vi /etc/yum.repos.d/rhel-source.repo
```

改为如下：
  ![看不到图是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20210109120218.png)

step2: `rpm --import 【setp1复制的内容】`

step3: 验证 `yum -y install firefox`

## 关于网站

1. 搭建网站需要的软件

    `yum -y install httpd php mysql mysql-server php-mysql`

2. 搭建

* step1: 网站权限

    安装好软件后，需要给网站的根目录设置权限，因为网站的目录在 `/var/www` ，可以查看详细信息，它的所属拥有者是 root，且具备 rwx 的权限，很危险！

    ```shell
    chown -R apache /var/www  # apache 用户 在安装httpd 的时候创建的，是一个程序用户。
    ```

* step2: 开启服务

```shell
service httpd start
service mysqld start

# 此时，通过访问 该服务器的网站是不行的，因为还有个防火墙！
iptables -F  # 关闭防火墙，就可以访问了
# 当然，即使 /var/www 下没有网站，还是会显示 apache 的默认页面；只需把 网站的源码 放到 /var/www/html/ 目录下就可以了
```

## 参考
