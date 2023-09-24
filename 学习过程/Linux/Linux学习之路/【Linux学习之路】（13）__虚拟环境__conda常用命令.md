# conda 使用

---

安装了Anaconda 后，应该更换源。--->参考1

---

[TOC]

## 一、conda 常用命令

### 1.1 环境相关命令

```bash
# 1. 创建环境
conda create -n opencv python=3.6 # opencv 是环境名字，后面是要安装的python环境
# 2. 删除环境
conda remove -n opencv --all
# 3. 列出环境
conda info -e
# 4. 切换环境
conda activate opencv
# 在树莓派上会提示 command not found，就用 source activate opencv
```

### 1.2 包管理

```shell
# 安装
conda install numpy
# 列出安装过的包
conda list
```

## 二、相关使用

### 2.1 换源

```shell
conda config --add channels https://mirrors.ustc.edu.cn/anaconda/pkgs/free/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
conda config --set show_channel_urls yes
```

## 问题

1. 如果在 anaconda 环境下，输入python并不能显示是使用Anaconda相关标记：

   解决方法：python，python3都试一下。还不行的话可能是环境变量的问题。

## 参考

1. [Anaconda介绍、安装及使用教程](https://www.jianshu.com/p/62f155eb6ac5)
2. [conda更换源](https://blog.csdn.net/sean2100/article/details/80998643)
3. [conda换源2](http://www.lqkweb.com/conda)
4. [解决 Raspbian Miniconda 无法安装最新 Python3.6](https://www.jianshu.com/p/ccad38dbb897)（树莓派3B+安装 anaconda，因为树莓派用的是arm架构，平时用的Ubuntu是 x86_x64，所以 anaconda官网的安装包用不了）
5. [jjhelmus/berryconda](https://github.com/jjhelmus/berryconda)（该仓库是上面链接用到的）
