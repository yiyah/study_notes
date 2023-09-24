# Ubuntu 上安装 Kinect 驱动 libfreenect

---

[TOC]

## 一、环境

* Ubuntu1804x64(VMware)
* 因为我是虚拟机安装，所以需要打开 “USB 兼容性 3.0”（虚拟机设置---USB 控制器---右方设置 USB 3.0）
  
## 二、步骤

### 2.1 编译 freenect

```shell
sudo apt-get install git-core cmake freeglut3-dev pkg-config build-essential libxmu-dev libxi-dev libusb-1.0-0-dev
git clone git://github.com/OpenKinect/libfreenect.git
cd libfreenect
mkdir build
cd build
# ===================================================================
# 在编译之前，请阅读本注释：
# 1. 如果你要使用 python 调用摄像头，在cmake之前，查看有哪些选项。执行下面的命令
# cmake -L ..
# 你会看到以下三个选项默认是OFF的，你要使用2和3，指定ON就好了，第一个不用管。
# BUILD_PYTHON:BOOL=OFF
# BUILD_PYTHON2:BOOL=OFF
# BUILD_PYTHON3:BOOL=OFF
# 2. 要开python，就要安装依赖先
# sudo apt-get install cython python-dev python-numpy # python2 依赖
# sudo apt-get install cython python3-dev python3-numpy # python3 依赖
# ===================================================================
cmake -DBUILD_PYTHON2=ON -DBUILD_PYTHON=ON -DBUILD_CV=ON ..
make
sudo make install
sudo ldconfig /usr/local/lib64/
sudo freenect-glview # 这里如果不能打开摄像头的话，看问题1
# 当sudo make install 就会提示把安装在哪个目录下，freenect.so就是在那里！

# 还有一步：此步不知道有没有影响。留待下次验证：(本次我执行了)
cd libfreenect/wrapper/python
sudo python3 setup.py install # 用python2就写python2 
```

### 2.2  添加用户到相关的安全组中和配置规则，以防用户不能使用摄像头。

```shell
sudo adduser $USER video
sudo vim /etc/udev/rules.d/51-kinect.rules
# 添加以下内容：
# ===============================我不用添加=========================================
# ATTR{product}=="Xbox NUI Motor"
SUBSYSTEM=="usb", ATTR{idVendor}=="045e", ATTR{idProduct}=="02b0", MODE="0666"
# ATTR{product}=="Xbox NUI Audio"
SUBSYSTEM=="usb", ATTR{idVendor}=="045e", ATTR{idProduct}=="02ad", MODE="0666"
# ATTR{product}=="Xbox NUI Camera"
SUBSYSTEM=="usb", ATTR{idVendor}=="045e", ATTR{idProduct}=="02ae", MODE="0666"
# ATTR{product}=="Xbox NUI Motor"
SUBSYSTEM=="usb", ATTR{idVendor}=="045e", ATTR{idProduct}=="02c2", MODE="0666"
# ATTR{product}=="Xbox NUI Motor"
SUBSYSTEM=="usb", ATTR{idVendor}=="045e", ATTR{idProduct}=="02be", MODE="0666"
# ATTR{product}=="Xbox NUI Motor"
SUBSYSTEM=="usb", ATTR{idVendor}=="045e", ATTR{idProduct}=="02bf", MODE="0666"
# =================================我不用添加=======================================
# 完成之后：log out and back in.
lsusb # 查看有没有检测到Kinect

# python中使用摄像头可以参考3最后的python代码
```

## 三、测试

### 3.1 测试一

```shell
sudo freenect-glview 
```

### 3.2 测试二：python 的 demo

```shell
cd path/to/your/libfreenect/wrappers/python
sudo python3 demo_cv2_sync.py
```
* 可能会出现的问题：
```shell
# ...
X Error: BadDrawable (invalid Pixmap or Window parameter) 9
Major opcode: 62 (X_CopyArea)
Resource id:  0x2800016
# ...
```
* 解决方法：（问题2）
```shell
sudo vim /etc/environment
# 在末尾添加 QT_X11_NO_MITSHM=1 保存退出后即可正常启动
```

### 3.3 测试三：自己编写程序

```python

import freenect
import cv2
import numpy as np

while 1:
    frame,_ = freenect.sync_get_video()
    frame = cv2.cvtColor(frame,cv2.COLOR_RGB2BGR)
    cv2.imshow('frame',frame)
    k = cv2.waitKey(1)
    if k == 'q':
        break

cv2.destroyAllWindows()                        
```
* 如果可以运行说明环境没问题了。


## 四、问题

4.1 当你运行 `sudo freenect-glview` 的时候提示：Could not open device，如下：

```shell

$ sudo freenect-glview 
[sudo] password for hzh: 
Kinect camera test
Number of devices found: 1
Found sibling device [same parent]
Found sibling device [same parent]
Trying to open ./audios.bin as firmware...
Trying to open /home/hzh/.libfreenect/audios.bin as firmware...
Trying to open /usr/local/share/libfreenect/audios.bin as firmware...
Trying to open /usr/share/libfreenect/audios.bin as firmware...
Trying to open ./../Resources/audios.bin as firmware...
upload_firmware: failed to find firmware file.
upload_firmware failed: -2
Could not open device
```

* 问题原因：
  Kinect audio system requires a firmware to be sent at runtime. It should   be found in your installation (in share/libfreenect/audios.bin) but it     might be absent  
* 解决方法是：（参考5）
  1. 先确保自己电脑没有 `audios.bin`(方法：sudo find / -name audios.bin)
  2. 如果第一步没有找到就下载 `python /usr/local/share/fwfetcher.py`(注意这个文件有时候不在这个路径下，建议也搜索一下)
  
  3. 把下载的文件放在 问题出现时提示的路径，如：`Trying to open /usr/local/share/libfreenect/audios.bin`


4.2 X Error: BadDrawable (invalid Pixmap or Window parameter) 9

* 解决方法：（参考6）

  ```shell
  sudo vim /etc/environment
  # 在末尾添加 QT_X11_NO_MITSHM=1 保存退出后即可正常启动
  ```



## 五、参考

1. [libfreenect](https://github.com/OpenKinect/libfreenect)
2. [OpenKinect的官网](https://openkinect.org/wiki/Getting_Started#Manual_Build_on_Linux)
3. [Experimenting with Kinect using opencv, python and open kinect (libfreenect)](https://naman5.wordpress.com/2014/06/24/experimenting-with-kinect-using-opencv-python-and-open-kinect-libfreenect/)（python可以 import freenect 从这位老哥get 到的灵感）
4. [Ubuntu安装Kinect驱动（openni、NITE、Sensor）及遇到的问题](https://blog.csdn.net/u013453604/article/details/48013959?depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromBaidu-1&utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromBaidu-1)（这个是openNI的驱动）
5. [upload_firmware: failed to find firmware file. upload_firmware failed: -2 #532](https://github.com/OpenKinect/libfreenect/issues/532)
6. [X Error: BadDrawable (invalid Pixmap or Window parameter)解决方案
](https://blog.csdn.net/m0_37469948/article/details/105224822?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromBaidu-1.nonecase&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromBaidu-1.nonecase)


## 六、更新说明
1. 2020/05/12 更新：
    * 增加安装驱动后的环境测试。
    * 增加问题说明。


​    