# shell 脚本的编写

---

脚本常用于获取参数，循环遍历。

---

[toc]

## 一、变量的定义和引用

### 1.1 hello world

首先我们看一个“hello world”。

```shell
# vim hello.sh 然后输入以下内容：
#!/bin/sh
a="hello world!"
num=2
echo "a is : $a num is : ${num}nd" #
# 运行 sh hello.sh 结果: a is : hello world! num is : 2nd
# 总结：可以看出 $ 符号是用来获取变量值。
# #! 是一个约定的标记，它告诉系统这个脚本需要什么解释器来执行，即使用哪一种 Shell
# 变量名外面的花括号是可选的，加不加都行，加花括号是为了帮助解释器识别变量的边界，我们通常加花括号{}
```

### 1.2 传入参数的引用

通常运行脚本的时候，可以用$1，$2，$3 等获取多个参数。例如：

```shell
# vim get.sh 然后输入以下内容：
#!/bin/sh
x=$1
y=$2
z=$3
echo "your param is: x=$x y=$y z=$z"
echo "your param is:" $1 $2 $3
# 运行 sh get.sh 12 3 4 结果:
# your param is: x=12 y=3 z=4
# your param is: 12 3 4
# 总结：可以看看出 $1 就是取出脚本启动时传入的参数
```

## 二、循环

```shell
# vim loop.sh 然后输入以下内容：
#!/bin/sh
for i in *    # 注意 * 在这里就是访问该脚本所在的文件夹下所有内容，如果写成./* 输出就会多./
do
    echo "hello, $i"
done
count=`ls -l|grep '^-'|wc -l`  # 注意这里的命令是 Tab 键上的`不是单引号
echo "====file_count:$count===="
# 运行 sh loop.sh 结果:
# hello, 1hellworld.sh
# hello, 2get.sh
# hello, 3loop_for.s
# ====file_count:3====
# 总结：意会
```

## 三、条件判断

* 注意：在 `shell` 中 如果条件成立，返回的是 0，即 0 为真。

```shell
# if 和 fi 配套使用
if  条件 ; then
   Command1
[elif 条件 ; then
   Command3]
[else
   Command3]  #中括号表示else语句可以没有
fi            #别忘了这个结尾

# if语句忘了结尾fi,在运行时报错如下：
test.sh: line xx: syntax error: unexpected end of fi
```

### 3.1 关于 条件判断的 语句

1. `(( ))` 的用法

    * 双小括号 `(( ))` 是 Bash Shell 中专门用来进行整数运算的命令
    * 注意：`(( ))` 只能进行整数运算，不能对小数（浮点数）或者字符串进行运算。

    ```shell
    # 在 (( )) 中使用变量加不加 $ 都可以，(( )) 会自动解析变量
    read -p "input your (integer) gratude: " gratude
    if ((gratude > 89 )); then
        echo "you get A!"
    elif ((gratude > 79 && gratude < 90)); then
        echo "you get B!"
    elif ((gratude > 69 && gratude < 80)); then
        echo "you get C!"
    else
        echo "oh, you get D!"
    fi
    ```

2. `[]` 的用法

   * `[]` 等同于 命令 `test`

    ```shell
    [ "a" == "b" ]
    ```

3. `[[]]` 的用法

    * `[[]]` 比 `[]` 更好用，可直接用 `<` `>` `&&` `||`

    ```shell
    [[ "a" == "a" ]]
    [[ "a" > "b" ]]
    # 组合
    [[ "a" == "a" && "a" == "b" ]]  # 等价于 [ "a" == "a"] && [ "a" == "b" ] 等价于 [ "a" == "a" -a "a" == "b" ]
    ```

## 四、变量自增

```shell
num=0
for files in dir
do
    num=$(expr $num + 1)
    # num=`expr $num + 1`
done
#  补充说明（参考4）：expr命令是一个手工命令行计数器
# expr 功能 表达式
# expr length "123" # 输出 3
# expr index "123" 2 # 输出 2（1为基准）
```

## 五、命令

### 5.1 命令执行

```shell
# 按照以往，如果想要在 shell 脚本里面执行 ls，会使用以下语句
echo "`ls`"
# 现在可以用以下语句实现
echo "$(ls)"
# 所以 $(ls) 等同于 `ls` 都是先执行其中的命令后，获得其输出然后放回原来的命令中！
```

### 5.2 read 从键盘获取输入

```shell
read num
echo "$num"
# 参数：
# -p “”: 输出提示
# -t 3: 等待多少秒
# -n 3: 接收多少个字符。（注意，有该参数的话，一输入到满足的长度，不用按回车 程序马上继续运行！）
# -s: 不显示输入的字符（这个类似于输入密码）
```

### 5.3 test 的用法

* test 的三个基本作用是判断文件、判断字符串、判断整数。
* 参数 看 参考1、7。
* test 中可用的比较运算符只有`==`和`!=`，两者都是用于字符串比较的，不可用于整数比较!（如果想要使用`>` `<`，就用`\<` `\>`，并且只能用在字符串比较）

```shell
# -a: and
# -o: or
# !:  非

# 1. 文件测试
test -e xxx.md # 判断文件是否存在，存在返回 0

# 2. 字符串测试
test "asdf" == "asdfd" # 判断是否相等
test "asdf" != "asdfd" # 判断是否不等
test "a" \< "b" # 返回 0，为真，a < b
test "a" \> "b" # 返回 1，为假，a < b
test -z "" # 是否为空  为空则为真
test -a "" # 是否不空

# 3. 数值测试
test 122 -eq 123 # 测试两个整数是否相等
# -ne 测试两个整数是否不等
# -gt 测试一个数是否大于另一个数
# -lt 测试一个数是否小于另一个数
# -ge 大于或等于
# -le 小于或等于

# 4. 组合
test "a" == "a" -a "a" == "b" # 返回 1
test "a" == "a" -o "a" == "b" # 返回 0
echo $? # 返回上一条命令输出的结果
```

## x、程序参考

### x.1 遍历目录下的文件，并只取出名字（不取目录）

程序一：

```shell
#!/bin/sh
for files in test1/*
do
        if test -f $files
        then
                fnp=$(echo ${files%%.*})
                echo ${fnp#*/}
        fi
done
# 解释：因为 for 循环会将遍历的目录带上 in 后面写的路径，例如：files内容是 test1/he.c
# 所以需要进行两次裁剪(参考4)，第一次 %%.* ：把
后缀删除
# 第二次 #*/　：把路径删除
```

程序二：遍历目录下的文件，全部！

```shell
# /usr/bin/sh

# the path you want to search
DIR=./

for files in `ls ${DIR_TRAIN}`
do
        echo $files
done
```

### x.2 合并两个文件夹下的内容到另外一个文件夹

```shell
#!/bin/sh

mkdir cute  # 创建合并后存放的条件
photonum=0
for files in dongman/* # 遍历 dongman 下的所有文件
do
        suffix=${files#*.}  # 保存文件后缀
        cp $files ./cute/cute_${photonum}.$suffix # 复制
        photonum=$(expr $photonum + 1)  # 文件数量加一
done

for files in erciyuan/*
do
        suffix=${files#*.}
        cp $files ./cute/cute_${photonum}.$suffix
        photonum=$(expr $photonum + 1)
done
echo "there are $photonum photos"  # 输出总文件数量

```

## 参考

1. [shell条件测试test](https://www.cnblogs.com/liyuanhong/p/5698953.html)
2. [linux 每个if都要搭配一个fi吗](https://zhidao.baidu.com/question/1690482520226070908.html)
3. [Linux 的字符串截取很有用。有八种方法。](https://www.cnblogs.com/shizhijie/p/8297840.html)
4. [Linux expr命令](https://www.runoob.com/linux/linux-comm-expr.html)
5. [关于 read 的用法](https://www.cnblogs.com/lottu/p/3962921.html)
6. [Shell (())：对整数进行数学运算](http://c.biancheng.net/view/2480.html)
7. [shell中if语句的使用](https://www.cnblogs.com/aaronLinux/p/7074725.html)
8. [shell中if条件字符串、数字比对，[[ ]]和[ ]区别](https://www.cnblogs.com/include/archive/2011/12/09/2307905.html)
