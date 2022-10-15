#  python 头写的 ` #!/usr/bin/python` 有什么用？

---

本篇笔记是在配置 SublimeText 编写 python 程序时因为不能自动补全，然后看到 Anaconda 插件可以补全时，因配置 python 解释器时产生的。

---

[TOC]


## 一、环境

1.  Ubuntu1804_x64

## 二、

写 python 代码的时候在第一行通常加上
```python
#!/usr/bin/python
# 或者
#!/usr/bin/env python
```
这两语句是什么？又有什么用呢？

### 2.1 是什么？
这两句是告诉程序运行的时候在那里找到 python 的解释器。

### 2.2 有什么用?
比如在 Ubuntu 下，Ubuntu 会默认安装了 python 2 和 python 3 两个版本。并且安装在 `/usr/bin` 路径里。

* 运行方式一：`./xxx.py` 

  于是乎当你用`./xxx.py` 的方式去运行 python 程序的时候，程序就会根据你第一行提供的路径去寻找 python 的解释器，然后执行代码。（关于为什么可以`./xxx.py`执行程序后面会提到）

* 运行方式二：`python xxx.py`或者`python3 xxx.py`

  但是当你用`python xxx.py`运行的时候，程序默认就会用 python2 去执行（Ubuntu 中输入 python 就是执行 python2）；用`python3 xxx.py`运行的时候，程序就会用 python3 执行。所以说如果你用这种方式去运行代码的时候，xxx.py 第一行的内容就会无效。

### 2.3 那两条路径有什么区别呢？
 * `#!/usr/bin/python`
    这种就相当于直接指定用哪一个解释器去运行代码，比如这个在 Ubuntu 下就是用 python2 去运行，想要用 python3 就改为`#!/usr/bin/python3`
 * `#!/usr/bin/env python`
    这种就相当于让你系统所设置的环境去选择用哪一个解释器，比如 Ubuntu 下 python2 是默认的解释器，它就会用 python2 去执行。

OK，有了这些认知之后我们来验证一下。

## 三、验证

我们在程序中`import sys`然后`print(sys.path)`就可以查看当前使用的 python 包含的路径。

*   `#!/usr/bin/python`

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190505212614.png)

*   `#!/usr/bin/env python`

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190505213333.png)

*   `#!/usr/bin/python3`

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190505213614.png)

*   `#!/usr/bin/env python3`

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190505213816.png)

这样大家都明白第一行的作用了吧？

但是因为有的安装路径不在`/usr/bin`下，所以推荐使用`/usr/bin/env python`

## 四、问题：

有人可能就会疑惑了（当时我也是），what？`./xxx.py`这样也可以运行？？？
我从来都是`python xxx.py`或者`python3 xxx.py`去运行的啊。
之前编写 c/c++ 程序的时候，通过`g++ yyy.cpp -o yyy`来生成执行文件，然后`./yyy`就可以运行 c/c++ 代码了，怎么 xxx.py 也可以`./xxx.py`?

其实是因为 xxx.py 没有可执行的权限。我们可以用一下命令更改权限

```bash
chmod a+x xxx.py # a+x：a (表示当前用户) + (加上) x(可执行权限),最后的参数就是就哪个文件更改
```

这里对于更改权限的命令不展开细说，感兴趣可以参考下面的参考2。




## 参考
1. [Python 头部 #!/usr/bin/python 和 #!/usr/bin/env 的区别](https://www.cnblogs.com/scofi/p/4867851.html)
2. [chmod 权限 命令详细用法](https://www.cnblogs.com/lhm166/articles/6605059.html)