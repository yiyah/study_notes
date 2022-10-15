# 如何在 Ubuntu 中直接调用第三方库或者自己写的库呢？


[TOC]



## 一、环境
1. Ubuntu 1804_x64

2. python 3.6

## 二、怎么做？

### 2.1 import xxx 不进来是因为 Python 不知道你的 xxx 放哪里

只需告诉 Python 你的 xxx 在哪里就可以 import 进来了。

### 2.2  那么 python 都会到哪里去找这些库路径呢？

下面我想知道 python3 的默认库路径，于是

```bash
$ python3
>>> import sys
>>> sys.path
['', '/usr/lib/python36.zip', '/usr/lib/python3.6', '/usr/lib/python3.6/lib-dynload', '/usr/local/lib/python3.6/dist-packages', '/usr/lib/python3/dist-packages']

```

如下图：

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190502075545.png)

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190502075545.png)

### 2.3 有了这些路径之后要做什么？

有了这些路径之后，我就可以到其中一个路径里，增加一个 `xxx.pth` 文件。

这个`xxx.pth`文件写着 第三方库的路径 或者 自己库的路径。

例如：（这里我以添加 OpenCV 的库路径为例）

```bash
# 我选择 /usr/local/lib/python3.6/dist-packages，因为我进去看过里面什么都没有，干净
# 1.在该目录下新建一个 opencv.pth 文件
cd /usr/local/lib/python3.6/dist-packages
sudo vim opencv.pth
# 添加以下内容，修改成你自己的路径
/home/hzh/opencv/mybuild/myInstall/lib/python3.6/dist-packages
# 2.保存退出
```

## 三、验证

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190502081921.png)

 

## 四、参考

1.[Python 设置三方库路径](https://blog.csdn.net/xieyan0811/article/details/68928291)