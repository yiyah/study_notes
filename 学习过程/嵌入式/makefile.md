## 通配符

看如下 Makefile

```makefile
test:main.o sub.o
    gcc -o test main.o sub.o

main.o:main.c
    gcc -c -o main.o main.c

sub.o:sub.c
    gcc -c -o sub.o sub.c

clean:
    rm -f *.o test
```

如果 xx.o 有 n 多个怎么办？要一个个去写？很麻烦啊！看下面：

```makefile
test:main.o sub.o
    gcc -o test main.o sub.o

sub.o:sub.h # 不加这个，改头文件的话就不会重新生成。加这个会把依赖合并，当修改sub.h时就会触发 %.o 的那条命令去生成 目标

%.o:%.c
    gcc -c -o $@.o $^

clean:
    rm -f *.o test
```

`%` 代表目标名
    比如当要生成test，要 sub.o 依赖时但是没有 sub.o，就会自动找 sub.o 的那行去生成。找到 `%.o` 就会匹配，把 % 换成 sub
`$@`
    表示目标文件
`$^`
    表示所有的依赖文件
`$<`
    表示第一个依赖文件
`$?`
    表示比目标还要新的依赖文件列表

## 函数

* 预备知识：make 时，会生成一些过程文件，像xxx.o，这些时看得到的，还有一些看不到的 .xxx.o.d 文件，这些是描述了 xxx.0 这个目标所依赖的一些头文件的路径

```makefile
objs := main.o sub.o
dep_files := $(foreach var, $(objs), .$(var).d)
    # 这个函数的作用就是在 objs 变量里($objs)，取出每个依赖，放到变量 var 中（var），即第一次取出了 main.o。然后这个变量加上字符变成 .main.o.d
    # 执行完后,dep_files = .main.o.d .sub.o.d
dep_files := $(wildcard $(dep_files))
    # wildcard 会判断 $(dep_files) 列出的文件是否存在，存在的话在放到 dep_files
    # dep_files 最终等于 .main.o.d .sub.o.d   

ifneq ($(dep_files),)
    include $(dep_files)  # 不为空的话，包含进来
endif
# 目的是把头文件也添加到依赖项，监测它，头文件改动了也可以重新生成
```
