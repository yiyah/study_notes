# cmake 安装

---

本次安装只配置官网已经编译好的cmake
Create Time: 2020-06-01

---

[TOC]

## 环境与准备

1. Ubuntu1804x64
2. cmake-3.17.3-Linux-x86_64.tar.gz: [下载地址](https://cmake.org/download/)（注意在 `Binary distributions:` 下）

## 二、配置环境

### step1: 移动文件夹到你想要的地方

`mv cmake-3.17.3-Linux-x86_64 ~/.local/opt`

### step2: 创建软连接

```shell
sudo ln -s yourPath/.local/opt/cmake-3.17.3-Linux-x86_64/bin/cmake /usr/bin/cmake
sudo ln -s yourPath/.local/opt/cmake-3.17.3-Linux-x86_64/bin/cmake-gui /usr/bin/cmake-gui
```
