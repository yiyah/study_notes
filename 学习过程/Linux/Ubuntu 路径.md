# 目录说明

[TOC]

## 1. 软件安装的位置

```txt
/etc 配置文件可能安装到了。
/opt/ opt目录用来安装附加软件包，是用户级的程序目录，可以理解为D:/Software。
/usr 系统级的目录，可以理解为C:/Windows/
/usr/bin 可执行的文件，如常用的命令ls、tar、mv、cat
/usr/lib  lib文件 C:/Windows/System32
/usr/src：系统级的源码目录。
/usr/local 用户自己安装的程序与源码编译安装的软件，C:/Progrem Files/
/usr/local/bin 是给用户放置自己的可执行程序的地方，推荐放在这里，不会被系统升级而覆盖同名文件。
/usr/local/src：用户级的源码目录。
/usr/share apt-get 安装的软件在此分散的放着,可执行文件放到/usr/bin,帮助文档/usr/share/doc /usr/share/man
/usr/share/applications # 快捷方式放这
/var/cache/apt/archieve apt-get 下的安装包缓存。

1. 源码编译，make&make install这样的安装是在你的“本地”用源码编译安装的，所以会针对你的电脑硬件进行优化，因为是“本地”编译的，所以默认安装路径是/usr/local（头文件安装到/usr/local/include,库：/usr/local/lib;所以如果编译的时候，指定了安装目录，再以后编译其他文件的时候，如果需要依赖这些安装在其他目录的文件，需要软连接到/usr/include /usr/lib）

2. deb,rpm这样的包是别人预编译好的二进制包，“共享”给你的，默认安装路径是/usr/share

3. apt install是下载并且安装同时解决依赖问题,安装目录是包的维护者确定的，不是用户。make是源码编译

Linux中服务器软件为什么需要编译安装：https://blog.csdn.net/wishfly/article/details/62043151

例如：
apt-get install python-numpy 会安装在 /usr/lib/python2.7/dist-packages/
pip install numpy 安装在 /usr/local/lib/python2.7/dist-packages/ # root 用户
        ~/.local/lib/python2.7/dist-packages/ # 普通用户
```

## 2. 软件的图标

```bash
/usr/share/applications
# 新建 xxxx.desktop文件
# 这个是火狐
[Desktop Entry]
Name=firefox            # -------改这里
Name[zh_CN]=火狐浏览器   # -------改这里
Comment=火狐浏览器       # -------改这里
Exec=/opt/firefox/firefox        # -------改这里
Icon=/opt/firefox/browser/chrome/icons/default/default128.png   # -------改这里
Terminal=false
Type=Application
Categories=Appliction;
Encoding=UTF-8
StartupNotify=true

# 这个是pycharm
[Desktop Entry]
Version=1.0
Type=Application
Name=Pycharm
Icon=/home/hzh/ProgramFiles/pycharm-2019.1.2/bin/pycharm.png    # -------改这里
Exec=sh /home/hzh/ProgramFiles/pycharm-2019.1.2/bin/pycharm.sh  # -------改这里
MimeType=application/x-py;
Name[en_US]=pycharm

# 这个是 ssr
[Desktop Entry]
Version=1.0
Type=Application
Name=SSR
Exec=/home/howareyou/App/electron-ssr-0.2.6.AppImage
```

## 3. hosts 文件

```bash
vim /etc/hosts
```

## 参考

1. [(关于1，2)火狐的安装与新建图标](https://blog.csdn.net/wrongyao/article/details/81809917)
2. [Linux 软件安装到哪里合适，目录详解](https://blog.csdn.net/qq_15766181/article/details/80755786)
3. [Linux /usr/bin与/usr/local/bin区别](https://www.jianshu.com/p/5de2286b2e97)
4. [linux 程序安装目录/opt目录和/usr/local目录的区别](https://www.jb51.net/article/141748.htm)
5. [Linux 下各个目录的作用及内容](https://www.cnblogs.com/sytfyf/p/6364691.html)
6. [apt-get下载、安装的软件在哪里](https://www.cnblogs.com/hanxing/p/3996103.html)
