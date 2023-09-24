# Ubuntu1804 安装opencv-4.1.0 + opencv_contrib-4.1.0（最终版）

---

* 在Ubuntu上安装个opencv+opencv-contrib可是遇到了不少坑，感觉什么问题都遇到了。花了两天时间才弄好，时间虽然花的长，但是过程让我学会了不少东西，每个过程都明明白白的。并且理解了很多东西。
* 网上的教程有些说的不明不明的，有些很重要点的也没有说出来。害得一些初学者（比如我）遇到各种各样的问题。当然别人可能是写给自己看的，发到博客只是为了做个记录。还是心存感激。
* 如果按照我的步骤，应该不会出太大问题。大家操作的时候可以先看一遍本文章，有个大概了解，知道需要做什么，实际操作起来才得心应手。
* 我是用 cmke-gui 去 cmake 的。一开始我也是屌的不行，直接用命令行去 cmake，无奈我对Ubuntu的接触还不深，于是乎在各种问题的打压下，放弃了，想着先从简单的开始吧。等将来了解多点知识再来命令行的 CMake。
* 本编文章尽然不能覆盖到每个人，每个人遇到的问题也千奇百怪。在下只能是尽我绵薄之力，希望能给同是初学者的朋友一份参考文档。

---

[TOC]

## 一、环境

### 1.1 Ubuntu 18.04_x64

### 1.2 opencv_4.1.0 + opencv_contrib-4.1.0

### 1.3 python2.7 ，python3.6

## 二、准备

### 2.1.更新下系统

```bash
sudo apt-get update

sudo apt-get upgrade
```

### 2.2 安装依赖包

```bash
# 因为安装 libjasper-dev 这个依赖包可能会出问题，所以先执行以下命令，在执行后续依赖包的安装
sudo add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main"
sudo apt update
sudo apt install libjasper1 libjasper-dev
# 而且一路配置过来犯过一些错（具体错误 ——> 问题 4），说 libgtk 依赖要先于 opencv 某些依赖安装（——> 参考 9），保险起见
sudo apt-get install libgtk-3-dev libgtk2.0-dev pkg-config

# 接下来就可以执行后续命令
# 可以输入下面的一次装，省心省力

# 分步装
sudo apt-get install build-essential
# opencv4.1.0需要 libgtk-3-dev
sudo apt-get install cmake libgtk-3-dev libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
sudo apt-get install python3-dev python3-numpy python-dev python-numpy libpython3.6-dev libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff5-dev libjasper-dev libdc1394-22-dev # 处理图像所需的包
sudo apt-get install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev liblapacke-dev
sudo apt-get install libopenexr-dev
sudo apt-get install libxvidcore-dev libx264-dev # 处理视频所需的包
sudo apt-get install libatlas-base-dev gfortran # 优化opencv功能
sudo apt-get install ffmpeg

# 一次装 （就是把上面的依赖全部写成一行，省心，下载过程中有些依赖需要你确认，-y 是替你输入 y ，省力）
sudo apt-get -y install build-essential cmake libgtk-3-dev libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev python3-dev python3-numpy python-dev python-numpy libpython3.6-dev libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff5-dev libjasper-dev libdc1394-22-dev libavcodec-dev libavformat-dev libswscale-dev libv4l-dev liblapacke-dev libopenexr-dev libxvidcore-dev libx264-dev libatlas-base-dev gfortran ffmpeg
```

### 2.3 安装 cmake GUI

```bash
sudo apt-get install cmake-gui
```

### 2.4 opencv_4.1.0 + opencv_contrib-4.1.0

```bash
# 用以下命令解压
tar -xzf xxx.tar.gz
```

 得到

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190502100217.png)



## 三、camke

```bash
cd mybuild	# mybuild 是我自己创的文件夹，大家可以自定义
cmake-gui ../opencv-4.1.0	# ../opencv-4.1.0 是 CMakeLists.txt 的所在位置，一般在下载的 OpenCV 源码里（非contrib）
```

### 3.1 按照顺序，然后 finish，此时 Configure 按钮变为 Stop ，表示配置进行中。

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190502100301.png)

Configure 结束后，如果 cmake 的主界面仍有红色区域，则再次点击 Configure 进行配置，直到红色区域完全消失。

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190502100329.png)

### 3.2 红色区域没了之后，进行下一步的配置

#### （1）在 CMAKE_BUILD_TYPE 值处选择 Release

#### （2）CMAKE_INSTALL_PREFIX 选择安装的路径

#### 这里我选择 mybuild 目录下自己新建的 myInstall 文件夹。

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190501230720.png)

#### （3）在 OPENCV_EXTRA_MODULES_PATH 处，为其设置 opencv_contrib-4.1.0 的路径，精确到 /modules 目录

#### （4）勾选 OPENCV_PYTHON3_VERSION 

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190501234041.png)

#### （5）添加 python 的路径，如下图：

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190502100540.png)

这个路径是根据官方文档设置的。如下图：![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190501231134.png)

#### （6） <span id = "OPENCV_GENERATE_PKGCONFIG">勾选 OPENCV_GENERATE_PKGCONFIG</span>

**这个很重要，是生成 opencv.pc 的，如果没有勾选就只能自己新建，后面也会提到。血的教训，而且网上很多教程都没提到，我是从官方文档看到的**。

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190501231631.png)

* 再次点击 Configure 进行配置，如果还有红色就继续 Configure ,直到没有红色才可进行下一步。

* 红色区域没了之后还要注意下图，红框圈住的信息栏，滚一下看看有没有错误信息（通常也是红色字体，很显眼），一般是下载问题，如果有错误信息，就继续 Configure ，直到没有错误信息。

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190502100727.png)

* 最后，点击 Generate，出现 “Generating done” 则意味着 cmake 的工作结束了。

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190502100748.png)



## 四、安装的最后一步

### 4.1 在 mybuild 目录下输入 `sudo make -j2`

 -j2 意思是用两个 CPU 去 make ,这样快很多 
 ```bash
 cat /proc/cpuinfo | grep "processor" | wc -l	#可以查看你的系统多少个 CPU
 ```

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190502100821.png)

### 4.2 然后 `sudo make install`

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190502100845.png)

此时可以打开 myInstall 文件看看，已经好了。

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190502100906.png)



## 五、C++ 环境配置

在还没配置前，先试一下两个测试：(大家可以不用做，看我操作，当然，自己操作一遍加深印象也未尝不可)

### 5.1 测试一：显示 OpenCV 版本号

```bash
# 命令行输入以下命令
pkg-config --modversion opencv
```

完了之后你会发现

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190502105104.png)

好，继续下一个测试

### 5.2 测试二：运行一个简单的程序，注意放张图片进去。

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190502105131.png)

```bash
# 输入下句命令得到 可执行文件 test

g++ showPhoto.cpp -o test `pkg-config --cflags --libs opencv`
```

完了之后你会发现

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190502101016.png)

### 5.3 这两个测试说明了什么？

* 说明了编译时还没找到 opencv 的相关文件（这不废话嘛，都还没配置）

有这两个过程是想大家有个感觉，并且至始至终都是围绕 `opencv.pc` 这个文件。

* 并且解释一下 `pkg-config` 这个什么意思，有助于大家理解待会为什么这么去配置环境。

`pkg-config` 就是我们告诉程序编译时从哪里找头文件和库相关信息。

那 `pkg-config` 从哪儿知道这些信息的呢？

它是从包名为 xxx.pc 这个文件中查找到的。就比如上面两个测试，它是从 opencv.pc 里去找，但是问题是我编译完之后整台电脑都没有 opencv.pc 这个文件啊（不信你试试 `sudo find / -name opencv.pc`）

那怎么办呢？没有枪没有炮我们自己造！

当然，这个造大炮的前提是在 <a href = "#OPENCV_GENERATE_PKGCONFIG">步骤 3.2（6）</a>中没有勾选 OPENCV_GENERATE_PKGCONFIG。如果勾选了就跳过 步骤5.4。

给大家看看，勾选了和没勾选的区别：

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190502085408.png)

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190502085600.png)

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190502085720.png)

### 5.4 新建一个 opecv.pc （勾选了就跳过此步骤，勾选生成的opencv4.pc 我印象中好像不用修改的，不放心可以打开看看确认一下）

现在我们自己造一个 `opencv.pc` （下面的代码中一份是我自己复制的 opencv.pc，一份是官方的 opencv4.pc，大家可以自行选择（当然是官方的好），然后根据自己路径修改（下面会提怎么修改））

```bash
vim opencv.pc

# 在里面输入以下内容

# 这个是我不知道 OPENCV_GENERATE_PKGCONFIG 选项 的时候复制别人的
# ---------------------开始（这行不用复制）-------------------------
# Package Information for pkg-config
prefix=/home/hzh/opencv/mybuild/myInstall
exec_prefix=${prefix}
includedir=${prefix}/include
libdir=${exec_prefix}/lib

Name: OpenCV
Description: Open Source Computer Vision Library
Version: 4.1.0
Cflags: -I${includedir}/opencv4 -I${includedir}/opencv4/opencv2
Libs: -L${exec_prefix}/lib -lopencv_shape -lopencv_stitching -lopencv_superres -lopencv_videostab -lopencv_aruco -lopencv_bgsegm -lopencv_bioinspired -lopencv_ccalib -lopencv_datasets -lopencv_dpm -lopencv_face -lopencv_fuzzy -lopencv_line_descriptor -lopencv_optflow -lopencv_video -lopencv_plot -lopencv_reg -lopencv_saliency -lopencv_stereo -lopencv_structured_light -lopencv_phase_unwrapping -lopencv_rgbd -lopencv_surface_matching -lopencv_text -lopencv_ximgproc -lopencv_calib3d -lopencv_features2d -lopencv_flann -lopencv_xobjdetect -lopencv_objdetect -lopencv_ml -lopencv_xphoto -lopencv_highgui -lopencv_videoio -lopencv_imgcodecs -lopencv_photo -lopencv_imgproc -lopencv_core
# ---------------------结束（这行不用复制）-------------------------

# 下面这个是我勾选 OPENCV_GENERATE_PKGCONFIG 生成的官方的 opencv4.pc
# ---------------------开始（这行不用复制）-------------------------
# Package Information for pkg-config

prefix=/home/hzh/opencv/mybuild/myInstall
exec_prefix=${prefix}
libdir=${exec_prefix}/lib
includedir_old=${prefix}/include/opencv4/opencv
includedir_new=${prefix}/include/opencv4

Name: OpenCV
Description: Open Source Computer Vision Library
Version: 4.1.0
Libs: -L${exec_prefix}/lib -lopencv_gapi -lopencv_stitching -lopencv_aruco -lopencv_bgsegm -lopencv_bioinspired -lopencv_ccalib -lopencv_dnn_objdetect -lopencv_dpm -lopencv_face -lopencv_freetype -lopencv_fuzzy -lopencv_hfs -lopencv_img_hash -lopencv_line_descriptor -lopencv_quality -lopencv_reg -lopencv_rgbd -lopencv_saliency -lopencv_stereo -lopencv_structured_light -lopencv_phase_unwrapping -lopencv_superres -lopencv_optflow -lopencv_surface_matching -lopencv_tracking -lopencv_datasets -lopencv_text -lopencv_dnn -lopencv_plot -lopencv_videostab -lopencv_video -lopencv_xfeatures2d -lopencv_shape -lopencv_ml -lopencv_ximgproc -lopencv_xobjdetect -lopencv_objdetect -lopencv_calib3d -lopencv_features2d -lopencv_highgui -lopencv_videoio -lopencv_imgcodecs -lopencv_flann -lopencv_xphoto -lopencv_photo -lopencv_imgproc -lopencv_core
Libs.private: -ldl -lm -lpthread -lrt
Cflags: -I${includedir_old} -I${includedir_new}
# ---------------------结束（这行不用复制）-------------------------

```



要注意的是以下我圈住的 5 个框。

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190502101302.png)



（1） `prefix` 这个是根据自己路径去设置的(`/home/你的名字/你的路径`)，因为我安装在 myInstall ，看下图可以看到 myInstall 是 include 和 lib 的上一级目录，所以路径写到这就好了。切忌写成 `~/`这样的路径（血的教训）。

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190502101325.png)

（2）`includedir` 就是包含的头文件目录

​         `libdir` 就是库的目录

（3）`Version` 这个是你自己安装opencv的版本

（4）`Cflags` 这个就起码精确到 opencv4 ，要不然以后写程序 可能要 `#include<opencv4/opencv2/opencv.hpp>`

（5）`Libs:` 精确到 lib 目录就好了

大家可以根据自己安装的路径去设置。

### 5.5 那么这个 opencv.pc 要放在哪里？

这就又要讲到 `pkg-config`，它默认会去`/usr/lib/pkgconfig` 里面找 opencv.pc 。当它在这里找不到 opencv.pc ，它就会到 `PKG_CONFIG_PATH` 所设置的环境变量去找，如果还没找到就会报错，比如上两个测试的报错。所以：

如果是 opencv4.pc 的就把下面提到的 `opencv.pc` 改为 `opencv4.pc`，当然你也可以重命名为 `opencv.pc`

方法一：移动 opencv.pc 到 `/usr/lib/pkgconfig`

方法二：把 opencv.pc 放在你想放的路径，然后

```bash
1. 打开 bash.bashrc

sudo gedit /etc/bash.bashrc

2. 在文件后添加

PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/设为你的opencv.pc的路径

export PKG_CONFIG_PATH

3. 更新配置

sudo updatedb
```

关于 pkg-config 更详细的的介绍 ---> [参考 4.](#cankao4)

### 5.6 配置库路径

```bash
sudo gedit /etc/ld.so.conf.d/opencv.conf 

# 添加你自己的 lib 路径，就比如我的如下：

/home/hzh/opencv/mybuild/myInstall/lib

# 保存后，更新一下

sudo ldconfig
```

### 5.7 c++ 环境配置的总结：
（1）把 opencv.pc 放在系统可以找到的地方
（2）添加库路径

## 六、python2 和 python3 环境配置(不用python 可以跳过)

下面以 python3 为例：

* 下两张图是 编译 opencv 时产生的 python3.6 的 opencv 库

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190502023747.png)

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190502023831.png)

然后参考<a href = "Ubuntu 中 Python 添加第三方库路径.md">Ubuntu 中 Python 添加第三方库路径</a>

* python 2 像 python 3一样的操作步骤，成功如下图：

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190502114455.png)

## 七、验证

### 7.1 先输入`pkg-config --modversion opencv`

 如果是 opencv4.pc  的就输入 `pkg-config --modversion openc4`

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190502101701.png)

说明找到了 opencv.pc

### 7.2  编译一个程序（.cpp）

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190502101734.png)

一样，如果是 opencv4.pc  的就输入 

```bash
g++ showPhoto.cpp -o showPhoto `pkg-config --cflags --libs opencv4`
```

我想经过这些例子，再加上[参考 4](#cankao4)的解释，大家应该知道 pkg-config 和 opencv.pc 的关系了吧？

也说下我的理解：

​	 \`pkg-config  --cflags --libs xxx \` 告诉程序在 xxx.pc 里找相应的头和库。

所以不管你是 opencv.pc 还是 opencv4.pc 都好，只要你 \`pkg-config  后面的 xxx \` 写成你的 xxx.pc 的名字 xxx 就好了。

编译成功后生成了可执行文件 showPhoto，执行结果如下：

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190502102315.png)

### 7.3 编写程序（.py）

 ![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190502024301.png)

`python3 1.py` 的运行结果如下：

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/1556763926324.png)

交互式命令行结果如下：

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190502025118.png)

##  八、问题

### 1. ippicv，face_landmark_model等下载错误

在 Configure 配置的时候，我遇到了 `ippicv_2019_lnx_intel64_general_20180723.tgz` 和 `face_landmark_model.dat` 这两个文件下载不通，我 Configure 多几下，它也可以下载完，如果等不及的可以直接下载。教程在下面的 [参考 5](#cankao5) ，其他的文件类推。

### 2. virtual memory exhausted: Cannot allocate memory

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190502102738.png)

出现这个问题的原因也是因为内存不足

 解决方法：[【Linux 问题记录】（2）内存不足.md](wiz://open_document?guid=2a5a4fb6-25e3-44fb-9f12-f34b73ffa9f9&kbguid=&private_kbguid=05a2819d-194d-4711-9d07-0bcb0de87e8b)

### 3.  undefined reference to symbol '_ZN2cv8fastFreeEPv' undefined reference to symbol '_ZN2cv8fastFreeEPv'

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190502102841.png)

这个是因为 我当时写的 opencv.pc 有问题 漏了 -lopencv_core ，补上去就好了。

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190502102852.png)

### 4. 运行错误 

`error:(-2:Unspecified error)The function is not implemented. Rebuild the library with Windows, GTK+ 2.x or Cocoa support. If you are on Ubuntu or Debian, install libgtk2.0-dev and pkg-config, then re-run cmake or configure script in function 'cvShowImage' `

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190502103731.png)

what？re-run cmake ?? GG ~ 

原来当时

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190502110452.png)

所以在安装依赖项的时候，先把 `libgtk-3-dev libgtk2.0-dev pkg-config`给安装了先，避免不必要的错误。

## 参考：

### 1. [Package OpenCV not found? Let’s Find It.](https://prateekvjoshi.com/2013/10/18/package-opencv-not-found-lets-find-it/)
### 2. [【安装教程】Ubuntu16.04 中用 CMake-gui 安装 OpenCV3.2.0 和 OpenCV_contrib-3.2.0（图文）](https://blog.csdn.net/jindunwan7388/article/details/80397700)
### 3. [OpenCV 4.1 编译和配置](https://www.cnblogs.com/xinxue/p/5766756.html)
### 4. <span id = "cankao4">[pkg-config 的用法](<http://www.cppblog.com/colorful/archive/2012/05/05/173750.html>)</span>
### 5. <span id = cankao5>[源码编译 opencv 卡在 IPPICV: Download: ippicv_2017u3_lnx_intel64_general_20170822.tgz 解决办法](<https://blog.csdn.net/u010739369/article/details/79966263>)</span>
### 6. [opencv undefined reference to symbol '_ZN2c... 异常](<https://blog.csdn.net/jacke121/article/details/54707710>)
### 7. [opencv官方文档](<https://docs.opencv.org/trunk/d7/d9f/tutorial_linux_install.html>)
### 8. [Ubuntu18.04下安装OpenCv依赖包libjasper-dev无法安装的问题](<https://blog.csdn.net/weixin_41053564/article/details/81254410>)
### 9. [问题 4 error:(-2:Unspecified error)的原因](https://blog.csdn.net/u011783201/article/details/52086560)