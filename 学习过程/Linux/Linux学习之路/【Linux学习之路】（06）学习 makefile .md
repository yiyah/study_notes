[TOC]

Q：Makefile 是什么？

A ：Makefile 可以理解为说明书吧。

> 一个工程中的源文件不计其数，其按类型、功能、模块分别放在若干个目录中，makefile 定义了一系列的规则来指定，哪些文件需要先编译，哪些文件需要后编译，哪些文件需要重新编译，甚至于进行更复杂的功能操作，因为 makefile 就像一个 Shell 脚本一样，其中也可以执行操作系统的命令。--- from baidu



## 一、准备

### 1. 一个简单的`cpp` 程序

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190517122251.png)

### 2. 我的目录结构（只有一个文件）

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190517122345.png)


## 二、编写 `Makefile`

```
hello:hello.o
    g++ hello.o -o hello
hello.o:1test.cpp
    g++ -c 1test.cpp -o hello.o
clean:
    rm -f *.o    
```

如图：

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190517122452.png)

* 需要注意的是：

    - 平时我们再有一个`cpp` 情况下，我们就直接`g++ xxx.cpp -o xxx` 

    - 但是我们如果分步操作的话就要注意了！

        + 什么是分步？

            比如`g++ xxx.cpp -o xxx` 此命令就直接由`.cpp`文件直接生成了可执行文件 ` xxx `

            分步就是由`.cpp`生成`.o`，再由`.o` 生成 `xxx`可执行文件。如我上图编写的`Makefile`一样

        + 注意什么？

            make 按照我目前所认知的，对于编译白框这部分
![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190517122541.png)
它是 从下往上 编译的，所以要把`.o`文件给`g++`出来，再根据`.o`文件把可执行文件`g++`出来，这个顺序就要倒转来！

## 三、make

再看一遍我当前的目录结构（有两个文件）

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190517122558.png)

然后执行`make` 命令，就已经生成了 `hello` 可执行文件了，如下图：

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190517122629.png)

会发现，`make`完之后多了一些中间生成文件`.o`

此时可以执行`make clean`清理，如下图：

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190517122648.png)

## 通配符

* makefile中的通配符是百分号`%`，相当于bash中的`*`，在描述规则的时候使用的都是`%`。makefile中也可以看到通配符`*`，这个一般是出现在命令之中，命令是要放到`shell`中运行的，所以要使用`*`作为通配符。

`%.o`：表示所用的.o文件  
`%.c`：表示所有的.c文件  
`$@`：表示目标  
`$<`：表示第1个依赖文件  
`$^`：表示所有依赖文件

```makefile
test: a.o b.o  
	gcc -o test $^  
%.o : %.c  
	gcc -c -o $@ $<
```
## makefile 的变量

* 变量的赋值
 和 `bash` 中的取值不一样，`bash` 是 `${xxx}` , `makefile` 是 `$(xxx)`
* 分为即时变量 和 延迟变量
	`:=` # 即时变量  
	`=` # 延时变量  
	`?=` # 延时变量, 如果是第1次定义才起效, 如果在前面该变量已定义则忽略这句  
	`+=` # 附加, 它是即时变量还是延时变量取决于前面的定义  
	`?=:` 如果这个变量在前面已经被定义了，这句话就会不会起效果
	
	例子
	```shell
	A := $(C)  
	B = $(C)  
	C = abc  
	#D = 100ask  
	D ?= weidongshan  
	all:  
		@echo A = $(A)  
		@echo B = $(B)  
		@echo D = $(D)  
	C += 123
	
	# 结果
	A =  
	B = abc 123  
	D = weidongshan
	
	# 分析
	分析：  
	1) A := $(C)：  
	A为即使变量，在定义时即确定，由于刚开始C的值为空，所以A的值也为空。  
	2) B = $(C)：  
	B为延时变量，只有使用到时它的值才确定，当执行make时，会解析Makefile里面的所用变量，所以先  
	解析C= abc,然后解析C += 123，此时，C = abc 123，当执行：\@echo B = $(B) B的值为 abc 123。  
	3) D ?= weidongshan：  
	D变量在前面没有定义，所以D的值为weidongshan，如果在前面添加D = 100ask，最后D的值为  
	100ask。  
	我们还可以通过命令行存入变量的值 例如：  
	执行：make D=123456 里面的 D ?= weidongshan 这句话就不起作用了。
	```


## 参考：

1.  [【AI白身境】只会用Python？g++，CMake和Makefile了解一下](<https://mp.weixin.qq.com/s?__biz=MzA3NDIyMjM1NA==&mid=2649031006&idx=1&sn=c2bbb57e95ccf651eec22fe378160095&scene=19#wechat_redirect>)__