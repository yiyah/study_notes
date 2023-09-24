# OS 库

---

[toc]

---

## 一、os

```python
import os
# 1. 获取当前工作目录
os.getcwd()
# 2. 切换当前工作目录,切换之后可以获取当前目录看看就知道怎么回事了
os.chdir("xxx")
```

## 二、sys

* 关于 `path`

    ```python
    import sys
    # 1. 查看python会在哪些路径里搜索模块
    sys.path()
    # 2. 添加python搜索模块的路径
    # 这样就可以添加第三方库了，不过此法是临时的。退出就没了
    sys.path.append("xxx")
    # 3. 添加python搜索模块的路径
    # 此法也是临时的，区别在于可以设置搜索优先级，0 最优先
    sys.path.insert(0, "xxx")
    ```

* 关于 命令行参数

    ```python
    sys.argv  
    # 该变量 用 list 存储了命令行的所有参数。
    # argv 至少有一个元素，因为第一个参数永远是该 .py 文件的名称
    # 如：python3 hello.py 获得的 sys.argv 就是 ['hello.py']
    # python3 hello.py 123 获得的 sys.argv 就是['hello.py', '123']
    # 与 C 语言对比，int main(int argc char *argv[]); argc 是参数个数
    ```

## 参考

1. [Python os.chdir() 方法](https://www.runoob.com/python/os-chdir.html)
2. [[python sys.path.append()和sys.path.insert()]](https://www.cnblogs.com/mtcnn/p/9411730.html)
