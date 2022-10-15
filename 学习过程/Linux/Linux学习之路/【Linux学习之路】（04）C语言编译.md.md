# 编译C程序

---

[TOC]

如何在Linux下编写一个C语言程序并运行呢？
很简单。先看效果！（输出一行字符串为“Hello World!---Linux”）

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190517113155.png)

那么，究竟是怎么实现的呢？

## step1：命令行输入`vim hello.c`

## step2：vim编辑器里输入（进入编辑器后要按 *a* 或 *i* 进入 insert 模式）

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190517113210.png)

## step3：退出 insert 模式返回到命令模式（按ESC）

在命令模式下输入`:wq!`然后回车

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190517113236.png)

## step4：这时候你的文件夹下就有一个 hello.c 的文件

输入命令

```
gcc hello.c
```

就会得到一个 a.out 文件

## step5：运行

输入命令

```
./a.out
```

就会运行你的程序。



### 总的程序编写

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190517113257.png)