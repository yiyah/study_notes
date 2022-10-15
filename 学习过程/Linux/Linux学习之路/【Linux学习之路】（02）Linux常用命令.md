# Linux常用命令

---

[TOC]

---

## 查看系统版本

```shell
lsb_release -a  # 该命令直接查看系统版本
cat /proc/version  # 该命令可以查看 Linux 内核版本（第一条信息）
cat /proc/device-tree/model  # 查看树莓派版本
uname -a  # 查看 cpu 架构 arm 还是 x86_64
```

## 命令的分类

* 命令分为内部命令和外部命令
  内部命令：命令解释器自带的命令
  外部命令：安装的第三方软件带的命令字

```shell
help ls # 内部命令要用help 才看的出帮助文档
man ls
```

## 1. ls（list，列表）

作用：使用列表把当前文件夹下所有文件显示出来
` ls -a ` 显示所有文件，包括隐藏文件
` ls -l ` 以详细信息显示
` ls -a -l `
` ls -l -a `
` ls -la `
` ls -al ` 四种方式都是可以的

## 2. cd（change directory，更改目录）

作用：用来切换目录
涉及到相对路径和绝对路径
`cd ..` ..代表上一层目录 .代表当前目录

## 3. pwd（print work directory，打印工作目录）

作用：打印出当前的绝对路径

## 4. mkdir（make directory，创建文件夹）

作用：创建空文件夹
`mkdir -p` 级联创建文件夹
实例：
`mkdir a`创建a文件夹
`mkdir a b` 这样就会创建两个文件夹
`mkdir -p abc/def`这样会创建abc文件夹里包含def文件夹

## 5. mv（move，移动）

作用：在目录间移动文件，重命名文件
 mv 源文件(pathname) 目的文件(pathname)
实例：假设文件夹结构目录：/root/abc/def 当前在/root/abc
`mv def/def.txt ./def.txt` 这样def文件夹的def.txt就会移到文件夹abc下
`mv abc.txt 123.txt`重命名

## 6. touch

作用：创建空文件
 touch pathname

## 7. cp（copy，复制）

作用：复制文件或文件夹
cp 源文件（pathname） 目标文件（pathname）
`cp -r` 用来复制文件夹
`cp -f` 强制复制
实际操作时，一般都是cp -f复制文件，
`cp -rf`复制文件夹

## 8. rm（remove，去除，删除）

作用：用来删除文件，文件夹
`rm 文件 pathname`
`rm -r 文件夹 pathname`

## 9. cat

作用：直接在命令行下显示文件内容，也可以用来向文件输入

```shell
cat -n 123.txt  # 显示内容时 显示行号
```

## 10. rmdir（remove directory，删除文件夹）

作用：删除空文件夹
    rmdir和rm -r的区别：rmdir只能删除空文件夹，而rm -r可以删除空文件夹和非空文件夹

## 11. ln（link，连接文件）

* 基础：windows中快捷方式，实际上快捷方式和它指向的文件是独立的两个文件，两个都占硬盘空间，只不过用户访问快捷方式时，其效果等同于访问指向的文件。
* linux中有两种连接文件：
  * 一种叫软连接（符号连接），等同于windows中快捷方式
  * 一种叫硬连接

* 软连接：
`ln -s src.c linker.c`
linker.c就是src.c的一个符号连接文件

* 硬连接：
`ln 源文件名 连接文件名`
**和copy似而不是，硬链接虽然删掉一个不影响另一个，但是它的文件在硬盘上是只有一份，而copy是两份在硬盘上。**
硬连接实际上和源文件在硬盘中是同一个东西，效果类似于硬盘上的一个文件，在文件系统上，在我们看来有好多个文件一样。每次删除一个文件时，只要他还有其他的硬连接存在，这个文件就不会被真正删除。只有等所有的连接文件都删除掉了，这个文件才会被真正从硬盘上删除。

## 12. --help

  @example:`date --help`

## 13. man

一般看 man手册的步骤：

1. 先看 NAME 部分，略看一下这个数据的意思
2. 再详细看 DESCRIPTION，这里会提到很多相关的数据与使用时机，可以学到很多小细节
3. 如果对这个命令比较熟悉，主要是查看OPTIONS的部分

进入man命令后 `man ls`

```shell
【q】退出
｛【space】/【Page Down】【Page Up】｝向上下翻页
｛【/string】【?string】｝向上下查找string，【n】查找下一个
｛【HOME】【END】｝去到第一页,最后一页
    @example: man date
```

## 14. shutdown reboot halt poweroff

`halt #系统停止，屏幕可能会保留系统已经停止的信息`
`poweroff #系统关机，没有电力提供`

## 15. 怎么以图形界面打开某些文件夹？ `nautilus`

```bash
nautilus /etc
```

## 16. 怎么删除除了某个文件

```bash
rm -rf !(file1)
rm -rf !(file1|file2)  # 除了多个文件
```

## 17. 结束进程

```shell
ps au # 查看进程 PID
kill 1000 # 1000 是某个进程对应的 PID
kill -9 10000 # kill -9 PID 码 强制结束
```

## 18. wc

* `wc` 将计算指定文件的行数、字数，以及字节数。

```shell
-l 或 --lines            只显示行数。
-w 或 --words            只显示字数。
-c 或 --bytes 或 --chars 只显示Bytes数。
```

```shell
$ cat test.txt
a and b is my!
c and d is yours!

# test1: 在默认的情况下，wc将计算指定文件的行数、字数，以及字节数。使用的命令为：
$ wc test.txt
2 10 33 test.txt  # test.txt 文件的行数为 2、单词数 10、字节数 33

# test2: 显示行数
$ wc -l test.txt
2 test.txt  # 显示行数 2
# 可以看书好像是统计了文件的行数，实际上是统计文件的newline数
```

## 19. tr

Linux tr 命令用于转换或删除文件中的字符。

```shell
tr a-z A-Z # 表示把 小写变大写（左转换右）
tr "." "\n" # 表示 所有的 . 转换成 换行
cat hello.c |tr a-z A-Z
```

## 20. 测试命令

```shell
test   参数    测试内容
test  -e   文件名 # (测试文件是否存在)
[ -e  文件名 ]    # 测试文件是否存在，注意中括号两边的空格
test -f   文件名  # 判断是否为普通文件
test -d   文件名  # 判断是否为目录
test -b   文件名  # 判断是否为块设备文件
test -c   文件名  # 判断是否为字符设备文件
```

## 21. 压缩与解压缩

### tar

```shell
# 解压
tar -zxvf xxx.tar.gz -C path
# 打包
tar -cvf test.tar test.sh # 仅打包，不压缩！（tar -cvf 文件名.tar 要打包的文件名）
tar -czvf 4.tar.gz 4tar.sh # 打包后，以 gzip 压缩 （tar -czvf 文件名.tar.gz 要打包的文件名）
# ============================================
-c 打包文件。建立一个压缩文件的参数指令(create 的意思)
-x 解压文件
# --------------------------------------------
-C <需要解压到的路径>
-t 查看压缩的文件
-v 或--verbose 显示指令执行过程。
-z 是否同时具有 gzip 的属性？亦即是否需要用 gzip 压缩？
-j 是否同时具有 bzip2 的属性？亦即是否需要用 bzip2 压缩？
-f 使用文件名，请留意，在 f 之后要立即接文件名喔！不要再加参数！（一定放最后，如：-xzf）

# =============其他使用===========
tar -tvf file # 在不解压的前提下，查看包里有啥

# 小结
# 1. 压缩用 -c；解压用 -x。
# 2. gz 用 -z；bz2 用 -j。
# 3. 最后的参数一定是 -f 接文件名
```

### gzip --- .gz

不能压目录，只能压单个文件（**小文件**）

```shell
# 压缩（可以加参数 -9 显示高压缩比）
gzip file.txt file.txt.gz  # 压缩后原文件没有了
gzip -k file.txt  # 保留file.txt文件，并生成 file.txt.gz

# 解压
gzip -d file.txt.gz
gunzip file.gz

# 选项
gzip -lkd name.gz
-l(list)  列出压缩文件的内容，可查看压缩比例
-k(keep)  压缩或解压后，保留源文件
-d(decompress) 解压
```

### bzip2 --- .bz2

不能压目录，只能压单个文件（**大文件**）

```shell
# 参数和gzip同
# 压缩（可以加参数 -9 显示高压缩比）
bzip2 file.txt file.txt.bz2  # 压缩后原文件没有了

# 解压
bzip2 -d file.txt.bz2
bunzip2 file.bz2
```

## 22. 硬盘大小，内存大小，cpu 型号

```shell
# 硬盘
df -h
fdisk -l
# 内存
cat /proc/meminfo
# cpu
cat /proc/cpuinfo
```

## 23. 查看文件夹大小

```shell
ls -hl # 这是查看文件大小
du -sh path # 查看文件（夹）大小（统计）
```

## 24. 关于 apt

```shell
# 1. 删除软件
dpkg --list # 查看安装的软件
sudo apt-get remove 包名 # 仅卸载软件
sudo apt-get --purge remove 包名 # 软件及其配置文件一并删除

# 2. 查找软件
# 在不确定软件包的名字的时候，可以用下面这个命令看看
sudo apt-cache search xxx
# 用以下命令可以查看源上的软件包的版本信息等
sudo apt-cache show xxx
```

## 25. 关于 pip3

```shell
pip3 list  # 查看安装过的模块
pip3 show xxx  # 可以查看模块的详细信息，如：安装路径
```

## 26. 关于查看文件的命令

```shell
cat  file
head file  # 看头几行
tail file  # 看后头几行
tac  file  # 反向查看
nl   file  # 带行号查看
more file  # 一页一页显示
less file  # 类似 more，可往前翻
```

## 27. 清楚屏幕

```shell
clear   # 还可以查看之前的命令
reset
```

## 28. find 命令，查找文件

find 目录 选项 “查找条件”

```shell
find . -name "test.txt" # 查找文件
find . -name "aaa"      # 查找 aaa 目录
```

## 29. grep 查找字符串

grep [选项] [查找模式] [文件名]

```shell
grep -rn "字符串" 文件名  # r:recursive 递归查找；n:number 行号
grep -n "123" aaa.txt
grep -rn "234" *          # * 代表查找当前目录下的所有文件和目录
# 加入 w 全字匹配
```

## 30. which 和 whereis

都是查找文件的位置

which pwd
whereis pwd # 详细点，把 man 手册也找出来

## 参考

1. [情景linux--wc -l是用来统计文件行数的吗？](https://www.jianshu.com/p/19d97bd9f9d5)
2. [Linux tr命令](https://www.runoob.com/linux/linux-comm-tr.html)
3. [tar命令的详细解释](https://blog.csdn.net/eroswang/article/details/5555415)
4. [ubuntu：查看ubuntu系统的版本信息](https://blog.csdn.net/whbing1471/article/details/52074390)
5. [如何检查树莓派的硬件版本号和型号](https://www.cnblogs.com/cloudrivers/p/11443280.html)
