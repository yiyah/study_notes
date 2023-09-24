# 代理设置

---

* Creation date: 2020-08-05
* Notes：本文重点关注没有图形界面如何设置代理。

---

[TOC]

## 一、桌面

关于桌面，有两种方法：

1. **法一：** electronic-ssr 软件（GitHub上有）
2. **法二：** 使用命令行配置

> 如果未关闭 SSR 关闭终端或者关机有可能出现无法连接网络的情况，重新开启 SSR 再关闭即可。

### step1：安装和配置软件

* 安装软件

    来自 `参考2` （建议使用`参考1`提到的软件）

    ```shell
    vim ssr
    # 添加下面的脚本文件的内容，然后赋予执行权限
    sudo mv ssr /usr/local/bin/
    sudo chmod 766 ssr
    ssr install  # 可能需要安装依赖，sudo apt-get install libsodium-dev
    ssr config  # 填写代理服务器的相关信息，下文有提示。（该文件在 /usr/local/share/shadowsocksr/config.json 具体位置按实际安装位置）
    ```

    ```shell
    #!/bin/bash
    # 作者：老徐
    # SSR免费分享网站（所有帐号均来源于网上别人的分享）：http://ss.pythonic.life
    # 源代码主页：https://github.com/the0demiurge
    # 访问https://github.com/the0demiurge/CharlesScripts/blob/master/charles/bin/ssr获取本脚本的最新版
    #使用方法：把该脚本放到$PATH里面并加入可执行权限就行（比如说放到/usr/local/bin）
    #首次使用输入ssr install后安装时会自动安装到/usr/local/share/shadowsocksr
    #输入ssr config进行配置，输入JSON格式的配置文件
    #输入ssr uninstall卸载
    #输入ssr help 现实帮助信息
    set -e
    if [ -z $EDITOR ];then
        EDITOR=vi
    fi

    help() {
        echo ShadowSocksR python client tool
        echo -e if you have not install ssr, please run \"ssr install\"
        echo Usage:
        echo -e "\t" ssr help
        echo -e "\t" ssr config : edit config.json
        echo -e "\t" ssr install : install shadowsocksr client
        echo -e "\t" ssr uninstall : uninstall shadowsocksr client
        echo -e "\t" ssr start : start the shadowsocks service
        echo -e "\t" ssr stop : stop the shadowsocks service
    }
    install_path=/usr/local/share/shadowsocksr
    if [ $# == 0 ];then
        help

    elif [ $1 == "help" ];then
        help

    elif [ $1 == "install" ];then
        sudo git clone -b manyuser https://github.com/shadowsocksr-backup/shadowsocksr.git $install_path
        # sudo git clone -b rm https://github.com/the0demiurge/not-in-use.git $install_path

    elif [ $1 == "uninstall" ];then
        echo "Danger! are you to remove $install_path forever?(y/N)"
        read doit
        if [ $doit == 'y' ];then
            sudo rm -rvf $install_path
        fi

    elif [ $1 == "config" ];then
        sudo $EDITOR $install_path/config.json
        cd $install_path/shadowsocks/
        sudo python local.py -d stop
        sudo python local.py -d start

    elif [ $1 == "start" ];then
        cd $install_path/shadowsocks/
        sudo python local.py -d start

    elif [ $1 == "stop" ];then
        cd $install_path/shadowsocks/
        sudo python local.py -d stop

    elif [ $1 == "log" ];then
        tail -f /var/log/shadowsocks.log

    elif [ $1 == "shell" ];then
        cd $install_path/shadowsocks/
        sudo python local.py $@
    fi
    ```

* 配置：填写代理服务器的相关信息

    ```shell
    "server": "0.0.0.0",  # 服务器地址  对于ss:ping+域名，得到地址。
    "server_port": 80890,    # 端口
    "password": " ",    # 密码
    "method": "chacha20",      # 加密方式
    "protocol": "auth_sha1_v4",  # 协议插件
    "obfs": "http_simple",    # 混淆插件
    # 还有一些参数，看着填
    ```

* 启动：启动和关闭命令

    ```shell
    # 停止
    ssr stop
    # 启动
    ssr start
    ```

### step2：转换 http 代理

> Shadowsocks 默认是用 Socks5 协议的，对于 Terminal 的 get, wget 等走 http 协议的地方是无能为力的，所以需要转换成 http 代理，加强通用性，这里使用的转换方法是基于 Polipo 的。

* 安装

    ```shell
    sudo apt-get install polipo      # 安装Polipo
    ```

* 配置

    ```shell
    sudo gedit /etc/polipo/config    # 修改配置文件
    ```

    将下面的内容整个替换到文件中并保存：(最后一行的端口可自行定义)

    ```shell
    # This file only needs to list configuration variables that deviate
    # from the default values. See /usr/share/doc/polipo/examples/config.sample
    # and "polipo -v" for variables you can tweak and further information.
    logSyslog = false
    logFile = "/var/log/polipo/polipo.log"

    socksParentProxy = "127.0.0.1:1080"
    socksProxyType = socks5

    chunkHighMark = 50331648
    objectHighMark = 16384

    serverMaxSlots = 64
    serverSlots = 16
    serverSlots1 = 32

    proxyAddress = "0.0.0.0"
    proxyPort = 8123
    ```

* 启动 Polipo

    ```shell
    /etc/init.d/polipo start
    /etc/init.d/polipo restart
    ```

### step3：验证

```shell
export http_proxy="http://127.0.0.1:8123"
curl www.google.com  # 成功的话，返回网页源码
# 另外，在浏览器中输入 http://127.0.0.1:8123/ 便可以进入到 Polipo 的使用说明和配置界面。
```

```shell
# 搜狐的这个接口能够返回你的IP地址
curl "http://pv.sohu.com/cityjson?ie=utf-8"
```

### step4：配置 pac

* 安装

    ```shell
    pip install setuptools
    pip install genpac
    pip install --upgrade genpac
    ```

* 生成 gfwlist

    ```shell
    # –output 处填写生成的 .pac 储存位置
    genpac --format=pac --pac-proxy="SOCKS5 127.0.0.1:1080" --gfwlist-proxy="SOCKS5 127.0.0.1:1080" --output="home/xxx/pac/autoproxy.pac"
    ```

* 配置

    打开 设置 --> Network --> Automatic --> url 填写 `file:///home/xxx/path/autoproxy.pac`

## 二、服务器配置

### step1：安装软件和配置

这个和桌面配置的命令行的`前三步`一样。（可以使用 `参考1` 的软件,如下）

* 安装

    ```python
    sudo apt install python-pip
    sudo pip install shadowsocks
    sudo ln -s /usr/local/python/bin/sslocal /usr/bin/sslocal
    ```

* 配置

    ```python
    sudo vi /etc/shadowsocks.conf
    {
        "server":"your_server_ip",
        "server_port":your_server_port,
        "local_address":"127.0.0.1",
        "local_port":1080,
        "password":"your_server_passwd",
        "timeout":300,
        "method":"aes-256-cfb"
    }
    ```

* 启动

    ```python
    sudo sslocal -c /etc/shadowsocks.conf -d start
    ```

### step2：将Socks5转换为HTTP代理

这里和桌面配置安装的软件不一样了，这个软件可以设置 PAC

* 安装

    ```shell
    sudo apt install privoxy
    ```

* 配置

    ```shell
    sudo vi /etc/privoxy/config
    # 找到 listen-address 确保有这行代码
    listen-address 127.0.0.1:8118 # 根据设置的http代理端口来设置

    # 找到 forward-socks5 确保有这行代码并且打开注释
    # 没有自己加，具体还是看看文件的说明，我看到文件时写着 forward-socks5t / 127.0.0.1:1080 .
    forward-socks5 / 127.0.0.1:1080 .
    ```

* 启动

    ```shell
    sudo service privoxy start
    sudo service privoxy status
    ```

### step3：配置环境变量，让终端也走代理

```shell
vim ~/.bashrc
export https_proxy=https://127.0.0.1:12333
export http_proxy=http://127.0.0.1:12333
export ftp_proxy=http://127.0.0.1:12333
```

* 可以用以下命令验证此时，所有连接都走代理，不太好（所以有 `step4`）。

    ```shell
    curl www.google.com
    # 搜狐的这个接口能够返回你的IP地址
    curl "http://pv.sohu.com/cityjson?ie=utf-8"
    ```

### step4：配置 PAC

* 安装软件

    ```shell
    pip install gfwlist2privoxy  # 注意一定要 Python2
    ```

* 获取gfwlist文件，生成actionsfile

    ```shell
    cd /tmp
    wget https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt
    ~/.local/bin/gfwlist2privoxy -i gfwlist.txt -f gfwlist.action -p 127.0.0.1:1080 -t socks5
    sudo cp gfwlist.action /etc/privoxy/

    # 关于 gfwlist.action
    # 如果以后某个pac文件之外的网站也想走代理的话，那么仅需要把域名添加到pac文件里面就可以了，比如添加wp.com到pac里面：
    echo '.wp.com' >> /etc/privoxy/gfwlist.action
    ```

* 让终端代理自动走pac模式

    ```shell
    vim /etc/privoxy/config
    # 加上下面一句，保存退出，然后重启Privoxy，
    actionsfile gfwlist.action
    service privoxy restart
    ```

### step5：验证

```shell
curl www.google.com  # 能访问则正常

curl "http://pv.sohu.com/cityjson?ie=utf-8"  # 返回的是自己的IP，则正常
```

**如果还是显示代理服务器的IP，则把 `/etc/privoxy/config` 中的 `forward-socks5 / 127.0.0.1:1080 .` 这一行注释了，然后重启 `privoxy` 如果不注释这行，所有的流量都走代理，我们刚才做的pac模式，它就不走了**

## 三、使用方法

### 3.1 仅为当前命令设置代理

```shell
http_proxy="http://127.0.0.1:8123" curl www.google.com
# 即在命令前加入 http_proxy="http://127.0.0.1:8123/" 或 http_proxy="http://localhost:8123/"
# 为了方便，可以加入别名
vim ~/.bashrc
alias hp="http_proxy=http://127.0.0.1:8123" # 保存退出
hp curl www.google.com
```

### 3.2 仅为当前会话设置代理

```shell
export http_proxy="http://127.0.0.1:8123"
```

### 3.3 直接全局代理

```shell
vim ~/.bashrc
export http_proxy="http://127.0.0.1:8123"
```

### PIP

在有梯子的情况下

```shell
export http_proxy=http://127.0.0.1:12333
export https_proxy=http://127.0.0.1:12333
# 这样就不用更换 PIP 源也可以下载了
```

### git

```shell
git config --global http.proxy http://127.0.0.1:12333
# 或者
git config --global http.proxy socks5://127.0.0.1:1080
# 取消
git config --global --unset http.proxy
```

## 参考

1. [Linux 使用 ShadowSocks + Privoxy 实现 PAC 代理](https://huangweitong.com/229.html)（本文基础）
2. [Ubuntu 下 ShadowsocksR 客户端的安装与配置](https://www.wx-smile.com/128)（本文的基础）
3. [Linux 有问必答：如何在桌面版 Ubuntu 中用命令行更改系统代理设置](https://developer.aliyun.com/article/87331)
4. [gsettings (1) - Linux Man Pages](https://www.systutorials.com/docs/linux/man/1-gsettings/)（gsettings 的参数说明）
5. [How to easily switch between proxy methods from terminal](https://askubuntu.com/questions/404337/how-to-easily-switch-between-proxy-methods-from-terminal)（也是一个告诉怎么在命令行设置桌面选项的网址）
6. [全局代理](https://www.bookstack.cn/read/learning-linux-mint/daily-network-global_proxy.md)
7. [gsettings简介及常用操作介绍](https://blog.csdn.net/feng98ren/article/details/78792240)
8. [如何在桌面版 Ubuntu 中用命令行更改系统代理设置](https://my.oschina.net/idufei/blog/1570254)
9. [Ubuntu 中 gconf, dconf, gsettings 和 dconf-editor 的功能与使用](https://blog.csdn.net/zhe_d/article/details/52011394?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.channel_param&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.channel_param)
