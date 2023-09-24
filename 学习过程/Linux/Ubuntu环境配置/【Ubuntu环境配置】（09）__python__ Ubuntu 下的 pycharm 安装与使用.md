# Ubuntu下python环境搭建

[TOC]



## 一、环境与准备

1.  Ubuntu1804x64
2.  到 pycharm 官网下载 pycharm 的 Linux 版本
3.  下好放在 Ubuntu 下。

## 二、安装

```bash
# 解压
tar -xzvf xxx.tar.gz
# 我把解压后的文件夹放在 ProgramFiles 文件夹下，因为解压后的文件夹就是相当于安装在里面的文件夹了
cd ~/ProgramFiles/pycharm-2019.1.2/bin
sh pycharm.sh	# 就开始安装了，它不会问你安装在哪，因为解压的文件夹就是它的安装路径了，但其中有个选项是让你选择导入之前的配置，不要以为这个是安装路径
```

关于注册：我就买了25的全家桶，教育认证

**启动方式：**

1.  在`/usr/share/applications`新建一个桌面文件就好了
2.  `sh xxx/pycharm.sh`

## 三、环境配置

我想要运行 OpenCV 的代码怎么办呢？

因为 anaconda 安装的时候默认安装了最新的 python3.7，而我安装的 opencv 只支持3.6，所以只能用 anaconda 新建一个 python3.6 的环境，然后配置 opencv 的链接库进去。接下来默认是 python36 的环境。

注意看我的路径是在 anaconda 的一个虚拟环境里面的，![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190516134932.png)

```bash
# 我之前编译好的 opencv 环境是在 ~/opencv/mybuild 里面
# 编译好的相关文件在 ~/opencv/mybuild/myinstall 里，其中mybuild/myinstall/lib/python3.6就是python调用opencv的库的路径，我们要做的就是把下图的动态链接库放到 anaconda 创建的python36环境的第三方包的文件夹里
# 但是我们不这么做，我们只需要创建一个软连接就行了
sudo ln -s /home/hzh/opencv/mybuild/myInstall/lib/python3.6/dist-packages/cv2/python-3.6/cv2.cpython-36m-x86_64-linux-gnu.so /home/hzh/ProgramFiles/anaconda3/envs/opencv/lib/python3.6/site-packages/cv2.so
```

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190516135623.png)

做完这些，在pycharm选择解释器的路径是 anaconda 创建的opencv 环境下的python36。如下图选择第一个。

*   第一个：这是 我用anaconda 创建的专运行opencv的 python 环境
*   第二个：这是安装anaconda时默认安装的python环境是3.7版本的
*   第三个：这是系统的python的路径

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190516140228.png)



## 关于代码提示

勾上箭头指的选项，就会在你输入的时候提示你输入什么参数

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190516111512.png)

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190516111606.png)