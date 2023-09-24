# Pixhawk自定义应用

---

Creation Date: 2020-08-19

---

[TOC]

## 一、环境

1. 硬件：Pixhawk 2.4.8
2. Ubuntu 1804x64(Vmware)
3. ardupilot 源代码（`master`）

## 二、修改代码

烧写一个串口例程就可以实现串口输出。但是，例程只是输出，不能控制。我们想要的功能是在 Pixhawk 的一些`copter`固件的基础上进行串口输出。怎么做呢？（这里涉及到太多东西了，先看参考1，对 ardupilot 框架有个大概了解先）

这里在 copter 的代码基础上修改。

* 方式一：
  
  * 代码位置: `ardupilot/ArduCopter/`
  * 修改代码

    ```cpp
    // 在 Copter.cpp 下添加
    // 添加第一处：
    void Copter::my_printf()
    {
        hal.console ->printf("\r\n====== I'm in copter! heihei =====\r\n");
    }
    // 添加第二处：
    // 在任务数组 const AP_Scheduler::Task Copter::scheduler_tasks[] = { ... } 仿照它的格式添加
    SCHED_TASK(my_printf,              10,    500),  // 10hz 运行一次，500us内完成
    ```

    ```cpp
    // 在 Copter.h 添加
    // 最好在注释 // Copter.cpp 后添加，表明该函数位于该 Copter.cpp 中。
    void my_printf();  // 声明
    ```

    * 烧写代码：验证一下

* 方式二：方式一在自定义代码多的时候难免会对原有的代码造成很大改动。希望有一种别的方式可以更加优雅的实现自己想要的功能。

    在你阅读了大量的关于 ardupilot 框架的文章后，你就会知道诸如 `ardupilot/ArduCopter`, `ardupilot/Plane`, `ardupilot/Sub`, `ardupilot/Rover` 等文件夹下的代码是属于上层应用，`ardupilot/libraries` 是共享库。
    于是乎，我们可以通过把自定义代码放到 `ardupilot/libraries` 文件夹下，再通过上层应用调用！思路正确。

  * step1: 首先，在 ardupilot/libraries 下新建一个文件夹用于存自己的代码，如 AA_my_lib
  * step2: 新建 `my_head.h`

    ```cpp
    #pragma once
    #include "AP_HAL/AP_HAL.h"
    #include "AP_HAL/AP_HAL_Namespace.h"

    class mytest
    {
    private:
        /* data */
    public:
        mytest(/* args */);
        // ~test();
        void my_printf();
    };
    ```

    * step3: 新建 `my_printf.cpp`

    ```cpp
    #include "my_head.h"

    extern const AP_HAL::HAL& hal;

    mytest::mytest()
    {}

    void mytest::my_printf()
    {
        hal.console ->printf("\r\n====== I'm in libraries! heihei =====\r\n");
    }
    ```

    * step4: 创建 object

    ```cpp
    // 在 `Copter.h` 的 `class Copter` 中
    // 添加头文件
    #include "AA_my_lib/my_head.h"
    // 添加成员变量
    mytest test_myout;
    ```

    * step5: 添加到任务列表

    ```cpp
    // 在 Copter.cpp 下添加
    // 在任务数组 const AP_Scheduler::Task Copter::scheduler_tasks[] = { ... } 仿照它的格式添加
    SCHED_TASK_CLASS(mytest, &copter.test_myout, my_printf, 50, 200),  // 50hz 运行一次，200us内完成
    ```

    * step6: 添加库路径到编译环境
      打开 `ardupilot/ArduCopter/wscript` 找到 `ap_libraries`，在最后添加 `AA_my_lib`（就是你的库的文件夹的名字）

    * 烧写程序看看现象，如果方法一也做了，你会发现，方法二的函数输出了 5 遍，方法一才输出 1 遍。说明这个任务调度起作用了。
      还有连接上地面站旋转飞控，看地面站的面板会不会随着动。

## 三、分析代码

如无意外，今后都会使用第二种方法进行实现自定义代码。那么简单分析一下，为什么要这么做？
比如：

* 自定义代码一定要写成类吗
  是的，任务调度列表的格式就已经限制了传入的函数，跳进去可以看到以下定义
  `SCHED_TASK_CLASS(classname, classptr, func, _rate_hz, _max_time_micros)`
  要求的参数是: 类名，类变量（object）地址，函数地址，运行频率，最大运行时间(us)。
  所以，我们在实现自定义代码的时候，需要采用类去实现。

* 在别的文件访问底层驱动，如上面的串口输出，只能通过 `hal` 访问，但是在 `Copter.cpp` 中已经定义了，只能 `extern const AP_HAL::HAL& hal;`

## 参考

1. [《APM 飞控固件二次开发初级教程》-- 阿木实验室](https://www.bilibili.com/video/BV19Z4y1W7yD?p=9)（虽然版本和我现在用的有点不一样，代码经过大整改。但看看有个印象，看看别人怎么分析）
2. [Pixhawk之UAV控制理论、ardupilot源码框架介绍](https://blog.csdn.net/qq_21842557/article/details/50815000)
