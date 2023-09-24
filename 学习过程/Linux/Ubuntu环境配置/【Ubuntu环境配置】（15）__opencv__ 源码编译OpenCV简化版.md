# Ubuntu1804 安装opencv-4.3.0 + opencv_contrib-4.3.0

---

Create Time: 2020-06-02

---

[TOC]

## 一、环境与准备

### 1.1 环境

1. Ubuntu 18.04_x64
2. python2.7 ，python3.6

### 1.2 准备

1. 源码：[`opencv-4.3.0.tar.gz`](https://github.com/opencv/opencv/releases) 和 [`opencv_contrib-4.3.0.tar.gz`](https://github.com/opencv/opencv_contrib/releases)
2. 更新软件 `sudo apt-get update && sudo apt-get upgrade`

## 二、cmake

### 2.1 安装依赖包

```bash
# 因为安装 libjasper-dev 这个依赖包可能会出问题，所以先执行以下命令，在执行后续依赖包的安装
sudo add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main"

# 官网给出的依赖如下：建议全部安装（注意apt源cmake的版本和numpy要用pip装的话，去掉即可）
# 这里建议单独安装 cmake 和 numpy
[compiler] sudo apt-get install build-essential
[required] sudo apt-get install cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
[optional] sudo apt-get install python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev
```

```shell
# 所以我的建议
pip3 install numpy # 然后 cmake 另外装
# then
sudo apt-get install build-essential git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev python-dev libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev
```

### 2.2 安装 cmake GUI

```bash
# 单独安装 cmake 可以到官网下载编译好的二进制，就不用通过apt下载了
sudo apt-get install cmake-gui
# 有些源的名字可能是 cmake-qt-gui
```

### 2.3 opencv_4.3.0 + opencv_contrib-4.3.0

```bash
# 用以下命令解压
tar -xzf xxx.tar.gz
```

### 2.4 配置cmake 选项

```bash
mkdir mybuild
cd mybuild # mybuild 是我自己创的文件夹，大家可以自定义
cmake-gui ../opencv-4.3.0
# type pre pkg opengl  modules python（的路径一般会自动检测到，但还是确认一下） 搜索这几项修改就是了

```

### 2.5 点 configure 看输出信息

1. `GUI` 下的 `GTK+` 是不是 yes
2. `PYTHON` 检测，有没有输出 cmake 选项中配置的信息。

### 2.6 genereate

### 2.7 sudo make -j4

不用 sudo 的话我出了好几次错都不知道什么问题，我也不知道是不是因为sudo才好的。（保险起见，加上为妙）

### 2.8 sudo make install -j4

## 三、配置环境

### 3.1 c++ 环境

1. 移动 `/myInstall/lib/pkgconfig/opencv4.pc` 到 `/usr/lib/pkgconfig/opencv.pc`（注意改了名字）
   * 注意，如果通过`apt-get`方式下载过opencv的话（或者安装caffe时下的依赖也会安装opencv），会在`/usr/lib/x86_64-linux-gnu/pkgconfig/opencv.pc` 这里有一个`opencv.pc`，这个路径下的文件优先被找到，从而使移动的文件失效。可以选择删除它就好了。
   * `pkg-config --cflags opencv` 再查看头文件路径是不是自己编译的路径，确保万无一失
2. 配置库路径

    ```bash
    sudo gedit /etc/ld.so.conf.d/opencv.conf

    # 添加你自己的 lib 路径，就比如我的如下：

    /home/hzh/opencv/mybuild/myInstall/lib

    # 保存后，更新一下

    sudo ldconfig
    ```

**c++ 环境配置的总结：**

（1）把 opencv.pc 放在系统可以找到的地方
（2）添加库路径

### 3.2 python 环境

由于是用 PIP 管理包，所以，创建一个后缀为`pth`的文件在`~/.local/lib/pythonx/site-packages` 下，里面写着 `path/to/yourOpenCVBuild/yourInstall/lib/pythonx/site-packages`
例如：`/home/hzh/opencv/mybuild/myInstall/lib/pythonx/site-packages`

## 参考

1. [opencv 官方说明](https://docs.opencv.org/master/d7/d9f/tutorial_linux_install.html)
