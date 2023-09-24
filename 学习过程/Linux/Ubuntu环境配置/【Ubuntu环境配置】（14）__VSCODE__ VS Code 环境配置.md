# Ubuntu 下 VS Code 环境配置

---

[TOC]

## 一、环境

* Ubuntu1804x64

## 二、配置 c/c++ 编译环境

### step1：用 VS Code 打开一个文件夹，并且新建一个 `.c` 文件

```c
#include<stdio.h>

int main()
{
    printf("\nass234dfdf\n\n");
    return 0;
}
```

### step2：配置`tasks.json` `launch.json`文件

* 在配置前先明白这两个文件是做什么的

  * `tasks.json`：告诉 VS Code 如何构建(编译)程序
  * `launch.json`：告诉 VS Code 怎么运行程序

2.2.1 创建 `tasks.json` 文件

* 调出命令面板 `Ctrl + Shift + P` --> 输入 `>Tasks:Run Task` --> 选择 `No configured tasks.Configure Tasks...` --> 选择 `Create tasks.json file from template` --> 选择 `Others`  --> 生成一个默认 `tasks.json` 文件
* 配置
    2.2.1.1 修改 `label` 的值为 `build`（该值是什么不重要，重要的是它和 `launch.json` 的关联）
    2.2.1.2 修改 `command` 的值为 `g++`
    2.2.1.3 添加 `args` 参数
        说明：该参数的设置就是命令行中使用 `g++`一样：如 `g++ main.c -o main`，只不过在该文件中配置用变量代替。（关于变量代表的意思可以看参考1）（-g 就是输出调试信息，如果没有该参数，会导致设了断点也没用）

    ```json
    {
        // See https://go.microsoft.com/fwlink/?LinkId=733558
        // for the documentation about the tasks.json format
        "version": "2.0.0",
        "tasks": [
            {
                "label": "build",
                "type": "shell",
                "command": "g++",
                "args": [
                    "-g",
                    "${file}",
                    "-o",
                    "${fileBasenameNoExtension}",
                  ]
            }
        ]
    }
    ```

2.2.2 创建 `launch.json` 文件

* 按 `F5` 运行 --> 选择 `C++(GDB/LLDB)` --> 选择编译器 `gcc - Build and debug active file` --> 这时候会生成一个默认的 `launch.json` 文件
* 配置
    2.2.2.1 修改 `preLaunchTask` 为 `tasks.json`文件的 `label` 的值

    ```json
    {
        "version": "0.2.0",
        "configurations": [
            {
                "name": "gcc - Build and debug active file",
                "type": "cppdbg",
                "request": "launch",
                "program": "${fileDirname}/${fileBasenameNoExtension}",
                "args": [],
                "stopAtEntry": false,
                "cwd": "${workspaceFolder}",
                "environment": [],
                "externalConsole": false,
                "MIMode": "gdb",
                "setupCommands": [
                    {
                        "description": "Enable pretty-printing for gdb",
                        "text": "-enable-pretty-printing",
                        "ignoreFailures": true
                    }
                ],
                "preLaunchTask": "build",
                "miDebuggerPath": "/usr/bin/gdb"
            }
        ]
    }
    ```

### step3：测试

#### 2.3.1 编译测试

1. 按 `Ctrl + Shift + B` 编译源文件（此时只用到了 `tasks.json` 文件）
2. `ls` 可以看到已经编译出一个可执行文件

#### 2.3.2 Debug 测试

1. 按 `F5` 程序自动执行（第一次按可能会输出奇怪的东西（其实是调试信息），再按一次就好了）

## 参考

1. [VS code 中的各种变量 \${file},${fileBasename}](https://blog.csdn.net/bailsong/article/details/77527773)
2. [[vscode] launch：program xxx does not exist](https://segmentfault.com/a/1190000020793997)
3. [Linux / Ubuntu上使用vscode编译运行和调试C/C++](https://zhuanlan.zhihu.com/p/80659895)
4. [初学c++ VS code + CMake 编译调试helloWord](https://blog.csdn.net/u014265289/article/details/78213643/)(有另一种方法可以调试。)
5. [VSCode中C/C++库文件的配置（自动提示、补全）](https://blog.csdn.net/cbc000/article/details/80670413)(参照此链接可解决VS Code 提示第三方库问题，注意需要重启软件)
