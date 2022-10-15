# DIY your Ubuntu

---

[toc]

## 1. 在command-line模式下输入 alias 可以查看目前的命令别名
* ```alias lm = 'ls -al' ```用 lm 代替 ls -al

* 那么怎么取消呢？用unalias
`unalias lm`

* 另外`type -a xxx`也可以查询命令所在位置和执行顺序如：
![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190517012200.png)

## 2.定义一个你常去的目录【/home/hzh/code/c】
* way1:
```
work="/home/hzh/code/c"
cd $work
```
* way2：这种方法是先 cd 到你的常用目录
```
work="`pwd`"
cd $work
```
* way3：这种方法是先 cd 到你的常用目录
```
work="${pwd}"
cd $work
```
## 3. PS1：提示字符的设置
如默认是这样的![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190517012229.png)
可修改为![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190517012259.png)
```
PS1='[\u@\h \w \A #\#]\$ '
```
参数：

　　\d ：日期，格式为【weekday month date】，例如：【Mon Feb 2】 
　　
　　\H ：完整的主机名。例如：我的机器名称为：hzh.linux，则这个名称就是 hzh.linux 

　　\h ：仅取主机名在第一个小数点之前的名字，如我的主机则为 【hzh】后面则被省略 

　　\t ：显示时间为 24 小时格式【HH：MM：SS】

　　\T ：显示时间为 12 小时格式【HH：MM：SS】

　　\A ：显示时间为 24 小时格式【HH：MM 】
　　
　　\@ ： 显示时间为 12 小时格式【am/pm】

　　\u ：当前用户的账号名称 

　　\v ：BASH 的版本信息 

　　\w ：完整的工作目录名称。根目录会以～代替 

　　\W ：利用 basename 取得工作目录名称，所以只会列出最后一个目录名 

　　\\# ：执行的第几个命令 

　　\\\$ ：提示字符，如果是 root 时，提示符为：# ，普通用户则为：$
　　
## 4. 更改主机名
输入以下命令修改主机名：
```
sudo vim /etc/hostname
```

## 5. 历史命令增加时间显示
```
sudo vim /etc/profile
```
添加`export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "`
重启。

## 参考
1. PS1：https://blog.csdn.net/qq_34208467/article/details/81019467 
2. history：https://blog.csdn.net/ljunjie82/article/details/9337849



