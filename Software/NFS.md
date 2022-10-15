# NFS

## 实现 Windows 映射网络驱动器（映射Ubuntu的文件夹到 win）

* step1: Ubuntu 操作

    ```shell
    # step1: install
    sudo apt install nfs-kernel-server  # 安装nfs服务端
    # sudo apt install nfs-common         # 安装nfs客户端

    # step2: configure
    sudo vim /etc/exports
    /home/book *(rw,sync,no_root_squash,no_subtree_check)  # 添加这一行，*代表哪些IP可以访问，即所有人
    # /home/xincheng/share 192.168.1.100/24(rw,sync,no_root_squash)   
    # 权限选项中的rw表示读写，ro为只读，sync表示同步写入，no_root_squash表示当客户机以root身份访问时赋予本地root权限

    # step3: restart
    sudo exportfs -ra # 更新配置文件
    sudo service nfs-kernel-server restart # 重启nfs服务
    # sudo /etc/init.d/nfs-kernel-server restart  # 这个也是重启

    showmount -e        # 查看共享哪些目录
    ```

* step2: Windows

  直接添加映射就好了，但是有时候好像得等个几分钟才行，我就试过一直提示输入账号密码
  （可能需要进控制面板添加功能：NFS 服务）

  * 当然可以用命令来添加

    ```shell
    showmouont -e server_IP  # 也可在 windows 下用此条命令查看服务器开放哪些 NFS 共享路径
    mount 192.168.1.200:/home/xxx y:    # 添加的是网络位置
    umount  # 取消
    ```

    下面的命令 fail 了，不知道为啥，可能不是这个服务？

    ```cmd
    # net use y: \\目标IP\ipc$ "密码" /user:"用户名"  # 未试过
    net use y: \\192.168.10.72\yiya
    net use y: /del  # 删除
    ```

## 实现 Ubuntu 映射 Ubuntu 文件

* step1: 第一步和上面一样，只不过 服务端和客户端 各安装对应的 nfs
* step2: 客服端执行以下

    ```shell
    # mount ip:服务器的共享路径 本地路径
    sudo mount 192.168.10.62:/home/yiya/ ubuntu_test/
    ```

## 问题

1. 如果有时候 网络驱动器 断开了，但是一打开文件夹就会卡顿导致闪退之类的问题。
我们需要删除这个 网络驱动器，怎么做呢？ `net use Y: /delete`

2. 映射的时候有错误

    ```cmd
    发生系统错误 53。

    找不到网络路径。
    ```

    可能是 Ubuntu 没有开 445 端口

    ```shell
    sudo uwf status # 查看防火墙状态，inactive 未开启
    netstat -a      # 查看已经连接的服务端口（ESTABLISHED）
    netstat -ap|grep 445 # 查看所有的服务端口（LISTEN，ESTABLISHED）
    ```

## 参考

1. [ubuntu18.4搭建nfs网络文件系统windows挂载虚拟机nfs实现在物理机下实时修改虚拟机内容](https://blog.csdn.net/dsp1406790497/article/details/104954290/)
2. [win10 映射ubuntu共享盘为网络驱动器](https://blog.csdn.net/czw707703387/article/details/104922904)
3. [如何移除网络驱动器？](https://answers.microsoft.com/zh-hans/windows/forum/windows_7-networking/%E5%A6%82%E4%BD%95%E7%A7%BB%E9%99%A4%E7%BD%91/f07e4ae4-0bbf-4e96-ace2-38144e688030?auth=1)
4. [通过NFS实现Linux和window共享文件夹](https://blog.csdn.net/Perfect886/article/details/118968875)
