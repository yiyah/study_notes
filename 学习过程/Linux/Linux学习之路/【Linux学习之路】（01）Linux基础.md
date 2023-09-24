# Linux基础

---

[toc]

## 目录结构

```shell
/bin 普通用户和管理员都可以执行的命令
/sbin 只有管理员才可以执行的命令
/boot 引导分区 主引导目录 独立的分区 启动菜单 内核
/dev device 设备文件存放目录
/etc 配置文件存放目录
/media 光驱的挂载目录
/mnt 临时设备挂载目录
/proc 里面的数据都在内存中，进程的所在目录
/tmp 临时文件存放目录
/usr 软件安装的目录
/var 常变文件存放目录，如日志文件，邮件文件
```

## 颜色分辨文件类型

```shell
# 有时根据权限的不同颜色会有所不同
蓝色 目录
黑色 普通文件
浅蓝色 符号链接（快捷方式）
绿色 带有执行权限的文件
红色 压缩包
紫色 图片，模块文件（紫色代表的东西多）
黑底黄字 设备文件（如硬盘 sda）
```

## 用户的分类和组

```shell
/etc/passwd # 保存了操作系统中所有用户的信息
/etc/shadow # 保存了用户密码信息
/etc/group  # 记录了系统中所有组的信息

# 1. cat /etc/passwd
root:x:0:0:root:/root:/bin/bash
hzh:x:1000:1000::/home/hzh:/bin/sh
# 解释：
# 字段1：用户名；
# 字段2：密码占位符；
# 字段3：用户的 uid，0表示超级用户，500~60000普通用户，1~499程序用户
# 字段4：基本组的 gid，先有组才有用户
# 字段5：用户信息记录字段；
# 字段6：用户的家目录
# 字段7：用户登录系统后使用的命令解释器

# 2. cat /etc/shadow
root:$6$zxaR7Jl8$5GzXgjyrOdiTyEwYWZgXeNlC2NyFTDynJ3eglCsA41hNs7owdkrFv3gTEGi42OqPEPC0Rpj9w/lHPtGIK5wbh0:18370:0:99999:7:::
# 字段1．用户名
# 字段2．用户的密码加密后的字符串
# 字段3：距离1970/1/1密码最近一次的修改时间
# 字段4：密码的最短有效期（用户n天内不能修改密码）
# 字段5：密码的最长有效期90（用户n天后要修改密码）
# 字段6：密码过期前7天警告
# 字段7：密码的不活跃期（密码过期了，N天内还可以登录系统）
# 字段8：用户的失效时间（到什么时间用户失效）
```

先有组再有用户！！！

建立组

```shell
groupadd class1
groupadd -g 2000 class1 # 新建组并且指定 gid
groupmod -g 1000 class1 # 更改组的 gid
grouupdel class1 # 删除组
```

建立用户

```shell
id hzh # 查看用户 hzh 的信息（uid gid groups）
useradd hzh # 新建用户之前会新建一个组，而且组名和用户名一样
useradd -g class1 hzh # 在组 class1 里新建用户 hzh(-g 后可以写 gid)
usermod -G 2000 -u 600 hzh # -G 添加附加组；-u 修改 uid
userdel -r hzh # 删除用户连同家目录
```

## 环境变量

1. 系统变量文件：

    * `/etc/profile`：系统中所有用户登录时都会执行这个启动文件．
    * `/etc/environment`
    * `~/.profile`
    * `~/.bashrc`：这个文件是被上面的/.profile文件执行的

2. 查看系统变量

    ```shell
    # 查看全部
    env
    printenv
    # 查看某个
    echo $PATH
    printenv PATH
    ```

3. 设置系统变量

    * 如果 `source` 命令对其他 terminal 不生效就重启！

    ```shell
    # 1. 仅对当前用户有效
    # 方法一（仅对当前 shell 有用且关闭当前 shell 后，该变量就没有了）
    export PATH=/path/to/where:$PATH # 
    # 方法二（永久有效）
    sudo vim ~/.profile #  文件同理
    export PATH=/path/to/where:$PATH
    source ~/.profile # 保存后，运行此命令使其生效
    # 方法三（推荐，永久有效）
    sudo vim ~/.bashrc
    export PATH=/path/to/where:$PATH
    source ~/.bashrc # 保存后，运行此命令使其生效

    # 2. 对所有用户有效
    # 方法一（推荐）
    sudo vim /etc/profile
    export PATH=/path/to/where:$PATH
    # 保存退出后，输入以下使其生效
    source /etc/profile
    # 方法二（不推荐）
    sudo vim /etc/environment
    # 添加路径后，保存退出，重启生效（经实验，source 并不能使其生效）
    ```

## 1. 隐藏文件与非隐藏文件

Linux中：linux中隐藏文件特点是文件名以.开头，跟文件属性无关。在linux中查看隐藏文件用`ls -a`命令（普通显示`ls`）

## 2. ~ 代表普通用户，# 代表管理员

## 3. `ls -l`显示的详细信息中

* -rw-r--r--
* drwxr-xr-x 一共10个字符，第一个字符表示文件类型，后面9个字符表示文件权限。
**文件类型：**
* \- 表示普通文件。普通文件指文本文件和二进制文件，如a.c 1.txt a.out都是普通文件
* d 表示文件夹，d是directory的缩写
* l 表示符号连接文件，后面会用->打印出它指向的文件
* s 表示socket文件
* p 表示管道文件 pipe
* rwxr-xr-xn 10个字符，第一个表示文件类型。剩下的9个分成3组，表示文件权限。
 前三个表示此文件的属主对文件的权限,中间三个表示此文件属主所在的组对文件的权限,最后三个表示其他用户对文件的权限
    rwx怎么解析：
  * r代表可读，w代表可写，x代表可执行
  * rwx：可读，可写，可执行
  * r-x: 可读，不可写，可执行
  * r--: 可读，不可写，不可执行

## 4. linux命令行中一些符号的含义

* . &nbsp; &nbsp;&nbsp; 代表当前目录
* .. &nbsp;&nbsp;&nbsp; 代表上一层目录，当前目录的父目录
* \- &nbsp;&nbsp;&nbsp; 代表前一个目录，我刚才从哪个目录cd过来
* ~ &nbsp;&nbsp;&nbsp;  代表当前用户的宿主目录
* / &nbsp;&nbsp;&nbsp;  代表根目录
* $ &nbsp;&nbsp;&nbsp;  普通用户的命令行提示符
* \#  &nbsp;&nbsp;&nbsp;  root用户的命令行提示符
* *&nbsp;&nbsp;&nbsp;万能匹配符

宿主目录：所谓宿主目录，就是操作系统为当前用户所设计的用来存放文件、工作的默认目录。如Windows中的“我的文档”目录，就是Windows为我们设计的宿主目录。

## 5. `/dev`放着硬件设备文件

在linux系统中，每个设备都被当成一个文件来对待。
几乎所有的硬件设备文件都在/dev这个目录。

## 6. 双引号与单引号的区别

双引号仍然可以保有变量的内容，但单引号内仅能是一般字符，而不会有特殊符号。

## 7. ` 的作用

在一串命令中，在 ` 之内的命令将会被先执行，而执行出的结果将作为外部的输入信息。
如进入到目前内核的模块目录

```shell
cd /lib/modules/`uname -r`/kernel
cd /lib/modules/$(uname -r)/kernel    #此例较佳
```

## 8. | 的作用

参考1

```shell
# | 表示管道，上一条命令的输出，作为下一条命令参数，如
echo | wc -l hello.c
```

## 9. 关于Ubuntu的 进程处理

1. 挂起进程：【CTRL + Z】
2. `jobs`：查看进程号
3. `fg[进程号]`：前台运行进程
4. `bg`：后台运行

## 10. 关于挂载

插入U盘后，Linux 会分配一个设备节点，怎么确定了？

```shell
cat /proc/partitions    # 先看有哪些分区
# 插 U盘，再用上面的命令看下 多了哪个分区，对应的 名字就是 设备节点的名字，如 sda

fdisk -l /dev/sda       # 查看分区类型，如：NTFS, FAT32
mount -t vfat /mnt /dev/sda # 一般可以不用 -t 指定

umount /mnt             # 用完后取消挂载
```

## 参考

1. [linux中的&&和&，|和||](https://blog.csdn.net/chinabestchina/article/details/72686002)
2. [linux每个文件都要挂载吗,linux为何要挂载](https://blog.csdn.net/weixin_35466750/article/details/116594847)
