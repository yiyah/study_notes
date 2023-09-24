# Win10 配置OpenCV4.2.0+contrib

[toc]

## 一、环境

1. Win10x64
2. VS2019
3. 准备工具：（解压后使用）
    * opencv-4.2.0.zip
    * opencv_contrib-4.2.0.zip
    * cmake-3.17.0-win64-x64.zip

## 二、步骤

### step1：打开 CMake 软件，【source code】选择 opencv-4.2.0 路径；【Where to build】选择自己新建的文件夹（mybuild）

例如：以下是我的目录结构和配置选择。

![看不到图是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20200325233559.png)

### step2:点击左下角的【configure】选择与自己相应的VS版本和位，然后finish

<img src="https://raw.githubusercontent.com/yiyah/Picture_Material/master/20200325233940.png" style="zoom: 80%;" />

### step3:  一般来说，第一次configure 完成后，会有一大片红色区域，继续configure直到没有红色区域。然后找到【OPENCV_ EXTRA MODULES_PATH】添加contrib的路径，精确到modules目录。再点击configure

### step4：同样configure后有红色区域就继续configure直到没有

### step5:没有红色区域后，到第二个显示框看看有没有红色提示，有的话解决它，直到没有红色提示！再点击Generate。如下图

![看不到图是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20200326230825.png)

### step6: 编译 OpenCV 源程序

去到 yourpath/mybuid/install 下打开OpenCV.sln，先编译 solution ，再到CMakeTargets 编译 install（先解决方案后install，Debug和Release模式下都 build solution）

### step7: 配置路径

新建一个工程，在属性管理器界面中配置路径。

## 三、问题

1. 第一次configure 的时候弹框【Error in configuration process, project files may be invalid】

    解决方法：左上角 file --- DeleteCache 后重新configure 就好了。（我也不知道为啥）

2. 配置好后还不行的话，先重启！再看以下几点：

    * 把dll文件放到System32文件夹下
    * 我的电脑--- 环境变量---- path ---- 添加 bin 目录到path里（一般我不用）
    * 配置路径的时候，是不是Debug模式用了release的lib

## 参考

1. [OpenCV 4.1.1 编译和配置](https://www.cnblogs.com/xinxue/p/5766756.html)

2. [CMake opencv时Download: opencv_ffmpeg.dll、ippicv等失败的解决方法](https://blog.csdn.net/KayChanGEEK/article/details/79919417?depth_1-utm_source=distribute.pc_relevant.none-task&utm_source=distribute.pc_relevant.none-task)

3. [VS2017永久配置openCV](https://blog.csdn.net/zhuofai_/article/details/79937088)
