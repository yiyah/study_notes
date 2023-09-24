# Pixhawk 固件介绍、选择与固件代码编译

---

Creation Date: 2020-08-19

---

[TOC]

## 一、介绍

1. Pixhawk 有两套固件，一是：`PX4Firmware` （对应的地面站是 `QGroundControl`），二是：`Ardupilot` （对应的地面站是`Mission Planner`）
2. `PX4Firmware` 与 `Ardupilot` 的关系

    * 首先，先知道有两个硬件平台，分别是 Pixhawk 和 APM。
    * `PX4Firmware` 是 Pixhawk 的原生固件，专门为 Pixhawk 开发的。`Ardupilot`是APM的固件，所以称ArduPilot固件也叫APM
    * Ardupilot由一群爱好者开发维护的,从最早的APM1,APM2开始,后来软件代码不断状大,原来的APM2的硬件不能胜任最新代码,再后来开发者就把Ardupilot代码转移到了Pixhawk平台上，兼容了Pixhawh硬件平台，所以就导致现在Pixhawk上有两套飞控代码的原因，所以在Pixhawk硬件平台上可以运行PX4固件（原生固件），也可以运行APM固件。
3. 因为 ardupilot 支持的机型多，发展悠久，选择它作为开发。

## 二、编译代码

1. 环境

    * 硬件：Pixhawk 2.4.8
    * Ubuntu 1804x64(VMware)
    * ardupilot 源代码（`master`）

2. 搭建编译环境

    ```shell
    git clone git@github.com:ArduPilot/ardupilot.git
    cd ardupilot
    git submodule update --init --recursive  # 更新子模块，这一步要很久，很可能还出错，
    # 我的解决方法是 cd module 后，手动 clone 每个子模块的仓库下来。（去ardupilot github主页，点进 module 后再点进相应的文件夹，就可以跳转到子模块的github仓库）
    Tools/environment_install/install-prereqs-ubuntu.sh -y
    . ~/.profile
    ~/.waf distclean  # 在开始前，完全 distclean 一遍（包括板的信息）。 ./waf clean 命令只clean编译后的文件，板的信息保留。
    ```

3. 使用

    * 相关命令

    ```shell
    ./waf configure --board fmuv2  # 在开始前，最重要的是设置你的板的类型
    ./waf list_boards  # 列出所有支持的板

    ./waf list  # 列出所有可以构建的 target
    ./waf rover  # 编译固件 rover
    ./waf --targets examples/UART_test  # 编译程序 examples/UART_test
    ./waf --targets bin/ardurover --upload  # 上传固件
    ./waf --targets examples/UART_test --upload  # 上传程序
    # 编译上传的代码文件是 ./libraries/AP_HAL/examples/UART_test/   UART_test.cpp
    ```

    * 烧写的流程

    ```shell
    ./waf configure --board fmuv2
    ./waf rover  # 这里可以换成你想要编译的任何程序
    ./waf --targets bin/ardurover --upload
    # 就可以实现上传 车的固件 到 Pixhawk
    # 这和通过地面站上传固件是一样的，不同的是版本而已。
    ```

## 参考

1. [Pixhawk的历史](https://blog.csdn.net/mou_it/article/details/80352234)
2. [Ardupilot源码框架](https://blog.csdn.net/MOU_IT/article/details/80394644)
3. [Setting up the Build Environment (Linux/Ubuntu)](https://ardupilot.org/dev/docs/building-setup-linux.html#building-setup-linux)
4. [PX4 自动驾驶用户指南](https://docs.px4.io/master/zh/)
5. [Pixhawk源码笔记六：源码预览与APM:Copter程序库](http://blog.sina.com.cn/s/blog_402c071e0102v5t1.html)
