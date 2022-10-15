# CMake b编译 OpenCV 的时候出现 OpenCV does not recognize MSVC_VERSION "****"

---

一般来说，出现这个问题是因为 VS 版本过高，和当前要安装的 OpenCV 版本年头有点差距。

---

[toc]

## 一、环境

1. OpenCV 3.3.1
2. Win10x64
3. VS2019

## 二、解决方法

<img src="https://raw.githubusercontent.com/yiyah/Picture_Material/master/20200404100253.jpg" style="zoom:200%;" />

### step1:首先定位到提示的文件的路径，

* 文件名：OpenCVDetectCXXCompiler.cmake
* 路径：yourPath\opencv-3.3.1\cmake
* 找到提示错误的第120行

### step3：添加以下内容，保存后继续 configure

```c++
  elseif(MSVC_VERSION MATCHES "^192[0-9]$")
    set(OpenCV_RUNTIME vc16)
```

就是告诉CMake，如果用户的 VS 使用的C++ complier 版本号是1920到1929 就`set(OpenCV_RUNTIME vc16)`

## 三、参考

1. [opencv的x64库的版本和vs的版本的对应关系](https://www.cnblogs.com/hustdc/p/6619141.html)

2. [CMake Error at cmake/OpenCVDetectCXXCompiler.cmake:85 (list)](https://blog.csdn.net/u010003609/article/details/100086911)

3. OpenCV4.2.0的OpenCVDetectCXXCompiler.cmake

   ![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20200404101745.jpg)

