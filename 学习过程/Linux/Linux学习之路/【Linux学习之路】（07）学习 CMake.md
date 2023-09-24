# 【Linux学习之路】（07）学习 CMake

---

[TOC]

Q：CMake 又是什么鬼？

A：CMake 通过编译 CMakeList 得到 Makefile

> CMake 是一个跨平台的编译 (Build) 工具，可以用简单的语句来描述所有平台的编译过程，其是在 make 基础上发展而来的，早期的 make 需要程序员写 Makefile 文件，进行编译，而现在 CMake 能够通过对 CMakeLists.txt 的编辑，轻松实现对复杂工程的组织。 --- from 言有三

* 编译过程

```shel
 .c   --->          .i       --->   .s     --->    .o     ---> a.out
源文件 ---> 预处理生成 .i 文件 ---> 转汇编 .s ---> 转机器代码 ---> 链接库生成可执行文件
```

## 一、 准备

* 一个`.cpp` 程序

![图片看不到是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190517124654.png)

* 我的目录结构

tree -L 1 只显示1层目录结构，可以看到只有一个文件，一个目录，大家也要新建这样一个目录

![图片看不到是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190517123904.png)

## 二、 编写 CMakeList.txt

* 简单使用

    ```cmake
    cmake_minimum_required(VERSION 2.8)    # 需要 cmake 对低版本 2.8
    project(hello)                         # project 名称：hello。注意不能有空格隔开
    add_executable(../hello ./1test.cpp)   # 从`./1test.cpp` 编译出`../hello`，什么意思？莫急，稍后解释
    ```

* 另一方法

    ```cmake
    # CMake 最低版本号要求
    cmake_minimum_required (VERSION 2.8)

    # 项目信息
    project (Demo2)

    # 查找当前目录下的所有源文件
    # 并将名称保存到 DIR_SRCS 变量
    aux_source_directory(. DIR_SRCS)

    # 指定生成目标
    add_executable(Demo ${DIR_SRCS})
    ```

![图片看不到是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190517124351.png)

## 三、 CMake

### 3.1 再看一下我现在的目录结构

![图片看不到是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190517124449.png)

### 3.2 然后

```shell
cd build
cmake ..        //因为 CMakeList.txt 在上级目录，所以 ..
```

此时看看 build 目录下，已经生成了 Makefile

![图片看不到是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190517124555.png)

此时再看看上一级目录

![图片看不到是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190517124612.png)

发现多了一个可执行文件`hello`

在这里解释一下，../hello 是输出，./1test.cpp 是输入，根据输入得到输出。

```cmake
add_executable(../hello ./1test.cpp)
```

因为在 buid 目录里，我想要输出文件放在和 `.cpp`一个目录，所以就要 ..

输入是根据 CMakeList.txt 的位置来决定的，因为我这里 CMakeList.txt 和`.cpp` 是同一目录，所以就`./1test.cpp`

## 四、高级使用

### 4.1 添加 `pkg-config`

Notes: `pkg-config` only find the moudle in default path.

有时候在编译的过程，需要用到 `pkg-config`, 例如在编译 opencv 的代码时

```c++
g++ main.cpp -o `pkg-config --cflags --libs opencv`
```

这种方式在工程不大的时候还可以用，但是当工程有多级目录的时候就需要 cmake 构建代码了。

#### step1: made sure where is your `xxx.pc`

Like : I want to build opencv

```shell
sudo find / -name opencv.pc
```

#### step2: add following context in your `CMakeLists.txt`

```cmake
# 设置 opencv.pc 的路径, 精确到父目录
SET(ENV{PKG_CONFIG_PATH} path/to/your/xxx.pc's/parent)
# 使用 pkg-cofig 编译
FIND_PACKAGE(PkgConfig REQUIRED)
# 添加 搜索的模块
PKG_SEARCH_MODULE(PKG_OPENCV REQUIRED opencv)
# 添加 头文件所在的文件夹
INCLUDE_DIRECTORIES(${PKG_OPENCV_INCLUDE_DIRS})

# 在最后添加链接库
TARGET_LINK_LIBRARIES(main ${PKG_OPENCV_LDFLAGS})
```

Show the intact file:

```cmake
# CMake 最低版本号要求
cmake_minimum_required (VERSION 2.8)

# 项目信息
project (MyHandTrack)

# 处理opencv库
#SET(ENV{PKG_CONFIG_PATH} /usr/lib/x86_64-linux-gnu/pkgconfig)
FIND_PACKAGE(PkgConfig REQUIRED)
# 在这里设置前缀 PKG_OPENCV
PKG_SEARCH_MODULE(PKG_OPENCV REQUIRED opencv)

# 查找当前目录下的所有源文件
# 并将名称保存到 DIR_SRCS 变量
aux_source_directory(. DIR_SRCS)

# 添加 opencv 的头文件路径，注意前缀
INCLUDE_DIRECTORIES(${PKG_OPENCV_INCLUDE_DIRS})

# 指定生成目标
add_executable(main ${DIR_SRCS})

# 为指定的bin文件添加三方链接库
TARGET_LINK_LIBRARIES(main ${PKG_OPENCV_LDFLAGS})
```

#### step3: `cmake ..`

### 4.2 添加第三方库 `xxx.so`

**Notes:**
有时候编译程序需要，加上 `-l` 选项，在 cmake 中怎么实现呢？

```shell
g++ -I . *.cpp -o handTrack -lglut -lGLU -lGL `pkg-config --cflags --libs libopenni`
```

首先：需要知道 `-lxxx` 的位置（参考5，6），其原名称为：`libxxx.so` 通过 `sudo find / -name libxxx.so` 来找到该库文件的位置。

然后在 `CMakeLists.txt` 文件的 `TARGET_LINK_LIBRARIES()` 加上该路径，如下：

```cmake
TARGET_LINK_LIBRARIES(main "path/to/lib") # 可以复制该库到工程目录下再链接
```

### 4.3 多个目录，多个源文件

```cmake
# ===========================主目录==========================
# CMake 最低版本号要求
cmake_minimum_required (VERSION 2.8)

# 项目信息
project (Demo3)

# 查找当前目录下的所有源文件
# 并将名称保存到 DIR_SRCS 变量
aux_source_directory(. DIR_SRCS)

# 添加 math 子目录
add_subdirectory(math)

# 指定生成目标
add_executable(Demo main.cc)

# 添加链接库
target_link_libraries(Demo MathFunctions)

# ===========================子目录==========================
# 查找当前目录下的所有源文件
# 并将名称保存到 DIR_LIB_SRCS 变量
aux_source_directory(. DIR_LIB_SRCS)

# 生成链接库
add_library (MathFunctions ${DIR_LIB_SRCS})
```

## 五、问题

### 5.1 一些常用变量的解答

* `include_directories()` 和 `add_subdirectory()`  的区别：
`include_directories()` 用于添加 Headers 搜索路径（ `-I` 标志）， `add_subdirectory()` 在这种情况下没有区别。
* 如果使用了 `option` 选项，要注意使用 `-DTEST=ON` (默认为 `OFF`)之后，下次进行 `cmake` 而不对该选项进行赋值的时候，`TEST` 选项的值 仍然为 `ON`。所以建议每次 `cmake` 的时候进行 `rm * -rf` 然后重新配置选项，以防错误。

### 5.2 如果配置了 `test`

那么，需要注意的是，看看下面一个例子

```cmake
# 启用测试
enable_testing()

# 测试帮助信息是否可以正常提示
add_test (test_usage Demo)
set_tests_properties (test_usage
  PROPERTIES PASS_REGULAR_EXPRESSION "Usage: .* base exponent")
```

如果，输出的是 `Usage: .* base exponenta` 该测试也会通过。就是说只检测前面的字符串，前面一样就行了。

### 5.3 怎么指定选项？

* 方法一：使用 ccmake 或 cmake -i (该两条语句都是提供交互式配置界面)
* 方法二：命令行指定配置，类似如下：

    ```python
    ```

## 参考

1. [【AI白身境】只会用Python？g++，CMake和Makefile了解一下](<https://mp.weixin.qq.com/s?__biz=MzA3NDIyMjM1NA==&mid=2649031006&idx=1&sn=c2bbb57e95ccf651eec22fe378160095&scene=19#wechat_redirect>)
2. [CMake 入门实战](https://www.hahack.com/codes/cmake/)
3. [cmake工程导入pkg-config（opencv为例）,实现三方库的编译链接;OpnCV非默认安装(非ROOT)，cmake ..找不到opencv.pc?](https://blog.csdn.net/weixin_39956356/article/details/102643415)
4. [Makefile/CMake加入pkg-config，但是(非系统位置)非root?](https://blog.csdn.net/weixin_39956356/article/details/102758271)
5. [g++ -L 和-l && -I参数](https://blog.csdn.net/dingzuoer/article/details/44650941?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-3.nonecase&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-3.nonecase)
6. [gcc -I -i -L -l 参数区别 / -l(静态库/动态库)](https://blog.csdn.net/abcdu1/article/details/86083295?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1.nonecase&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1.nonecase)
7. [Cmake Practice](https://blog.csdn.net/zhuquan945/article/details/72847832/)
8. [cmake在命令行怎么指定选项？](https://bbs.pku.edu.cn/v2/post-read.php?bid=13&threadid=16311305&page=a&postid=17389396)
