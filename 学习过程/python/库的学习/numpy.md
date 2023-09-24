# 学习 numpy

[toc]

* `shape`：返回的是 `(H, W)`

## numpy 读取图片后的保存格式

* 现读取一张 `HxW = 4x5` 的图片，如下：

  ![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/2020-08-23_18-05-28.png)

  **分析：**

    1. `a.shape` 后输出 `(4, 5, 3)` 表示的是 高 4，宽 5，通道 3。
    2. 可以看到有 4 个二维列表，每个二维列表有 5 个一维列表。看列表元素，再根据图片，可以得出：**每个二维列表代表每一行；二维列表的每个一维列表代表一个像素，像素有3个通道。** 所以有 4 个二维列表，一个二维列表有 5 个一维列表，每个一维列表有 3 列。所以就是 4 行，5 列，3 通道。（一个像素代表一列，就是宽）

## np.array()

```python
a = [[1,2,3,3],[4,5,6,6],[7,8,9,9]]
a = np.array(a)
a.shape  # (H, W): (3, 4)
```

## np.reshape()

```python
x = np.arange(24)           # 生成一维数组
x = np.reshape(x, (2,3,4))  # reshape 成 2 行 3 列 4 页（通道）
# 也可以直接设置 shape
x.shape = (4, 6)
```

## np.arange()

函数说明：`arange([start,] stop[, step,], dtype=None)`

* 根据 start 与 stop 指定的范围以及 step 设定的步长，**生成一个 `ndarray`**。 dtype : dtype

* 示例

```python
# 1
>>> b = np.arange(5)
>>> b
array([0, 1, 2, 3, 4])
# 2
>>> b = np.arange(0,10,2)
>>> b
array([0, 2, 4, 6, 8])
# 3
>>> type(b)
<class 'numpy.ndarray'>
```

## np.random

### rand()

* `rand()` 函数根据给定维度生成[0,1)之间的数据，包含0，不包含1
* 指定维度的 array

```python
>>> a = np.random.rand(2)
>>> a
array([0.66196296, 0.97036988])
>>> type(a)
<class 'numpy.ndarray'>

>>> np.random.rand(2,3)
array([[0.74848182, 0.79022244, 0.2321742 ],
       [0.61205214, 0.77592718, 0.56986353]])
>>> np.random.rand(3,3)
array([[0.67917123, 0.74810943, 0.68951456],
       [0.9457367 , 0.94324234, 0.61368083],
       [0.86873606, 0.23525682, 0.11742689]])
```

### randn()

* `randn()` 函数返回一个或一组样本，具有标准正态分布。
* 返回值为指定维度的 array
* 使用方法和 `rand()` 一样，只是返回的数值不一样。

### randint()

`randint(low, high=None, size=None, dtype='l')`

* 返回随机整数，范围区间为 `[low,high)`，包含low，不包含high
* 参数：low为最小值，high为最大值，size为数组维度大小，dtype为数据类型，默认的数据类型是 `np.int`
* `high` 没有填写时，默认生成随机数的范围是 `[0，low)`

```python
>>> np.random.randint(5)
1
>>> np.random.randint(5, size=5)
array([1, 2, 2, 0, 4])
>>> np.random.randint(5, size=(2,3))
array([[2, 2, 1],
       [1, 2, 4]])
```

## np.max() 和 np.maximum()

1. `np.max(a, axis=None, out=None, keepdims=False)`
    * 作用：求序列的最值，最少接受一个参数
    * 参数解释

      * `a`: 序列
      * `axis`: 默认为 axis=0 即列向,如果 axis=1 即横向

    * 示例

      ```python
      >> np.max([-2, -1, 0, 1, 2])
      2
      ```

2. `np.maximum(X, Y, out=None)`

    * 作用：X 和 Y 逐位进行比较,选择最大值；最少接受两个参数

    * 示例

      ```python
      >>> np.maximum([-3, -2, 0, 1, 2], 0)
      array([0, 0, 0, 1, 2])
      ```

## np.power()

* 参数说明：`np.power(x1, x2)`
  
  * `x1`: 底
  * `x2`: 幂
  * 其他说明：`x1` 和 `x2` 都可以是数组

* 示例

    ```python
    >>> np.power(2,3)
    8
    >>> x1= range(5)
    >>> x2=np.array([[2,3,2,3,2],[1,2,1,2,1]])
    >>> np.power(x1,x2)  # 底有一组，幂有两组，结果是两组数据
    array([[ 0,  1,  4, 27, 16],
           [ 0,  1,  2,  9,  4]])
    ```

## np.histogram()

* 它是数据的频率分布的图形表示。 水平尺寸相等的矩形对应于类间隔，称为 bins，变量 height 对应于频率。
* `np.histogram(a, bins)` 参数解释；
  
  * `a`: 待统计的数据，一维。
  * `bins`: bin数组中的连续元素用作每个bin的边界。
  * `range`：长度为2的元组。表示统计范围的最小和最大值。默认值None，表示范围由数据的范围决定。返回的区间左右边界都取到。

* 简单使用

    ```python
    import numpy as np

    a = np.array([0,0,1,1,1,2,3,4,5,5])  # 待统计的数据
    hist,bins = np.histogram(a, bins=[0,1,2,3,4,5,6])  # 返回频数和区间

    print(hist)  # [2 3 1 1 1 2]
    print(bins)  # [0 1 2 3 4 5 6]

    # hist,bins = np.histogram(a, bins=np.arange(0,7))   # bins 的另一种表示
    # hist,bins = np.histogram(a, bins=6, range=(0,6))  # 返回频数和区间,注意这个range参数左右边界都取到,所以不必再加1

    # 如何确定 bins?
    # 方法一：bins=np.arange(最小的数，最大的数加2)
    # 方法二：bins=类数(=最大的数-最小的数+1), range=(最小的数，最大的数加1)
    # 如：a = np.array([-2,-2,0,0,1,1,1,2,3,4,5,5, 8,8,8,8,8,8])
    # hist,bins = np.histogram(a, bins=np.arange(-2,10))  # 返回频数和区间
    # hist,bins = np.histogram(a, bins=11, range=(-2,9))  # 返回频数和区间，如果不指定 bins，就会均分 range() 指定的范围
    ```

  * 小结

    * `np.hist()` 统计的是区间，当用 `plt.plot()` 画图像通道的时候，画的是点，注意 x 坐标范围是变小了。比如统计 `[0,1,2]` 三个数的频数，统计的是区间 `[0,1),[1,2),[2,3)`，要达到 3，`np.histogram()` 的 `bins=np.arange(2+1+1)`；但是画图画的是点，`plt.plot()` 的 x 范围是 `[0,1,2]` 达到 2 只需要 `np.arange(2+1)`；所以 范围不一样。

## np.transpose()

`np.transpose()` 有人说相当于转置，欧陆翻译的结果是 变换顺序。至于怎么理解，看个人。

* 参数解释
  * **参数是 `tuple`**。默认是反过来的索引编号。如2维，np.transpose((1,0))；3维，np.transpose((2,1,0))
  * 返回的是源数据的**视图**

* 需要深刻理解参数 **索引编号** 的意义，我理解为 0 轴，1轴，2轴 对应 Height, Width, Channel（用图像的思维，img.shape 返回(H,W,C)）

```PYTHON
import numpy as np

data = np.arange(24).reshape(2,3,4)  # shape = (2,3,4)
# 进行轴对换
data1 = data.transpose((0,2,1))  # shape = (2, 4, 3)
# data1[0,0,0] = 10  # 此操作会同时改变 data 的数据，这叫返回源数据的视图 view
'''
data 的数据是
[[[ 0  1  2  3]
  [ 4  5  6  7]
  [ 8  9 10 11]]

 [[12 13 14 15]
  [16 17 18 19]
  [20 21 22 23]]]
=====================
data1 的数据是
[[[ 0  4  8]
  [ 1  5  9]
  [ 2  6 10]
  [ 3  7 11]]

 [[12 16 20]
  [13 17 21]
  [14 18 22]
  [15 19 23]]]
'''
```

* 形象理解

  以上直接上代码可能比较难理解，下面结合几幅图理解
  
  * 首先，我们来个简单的，二维矩阵的转置

    ```python
    # 代码实现
    data = np.arange(6).reshape(2,3)
    data1 = data.transpose()  # 参数默认是(1,0)
    ```

  ![看不到图是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/2020-09-05_00-22-59.png)

  * 解释：没错，这和矩阵上的转置是完全一样的，二维比较简单，但树立起什么是 0轴 1轴的概念很重要！同时图片上转置后的数组标记的 0轴 和 1轴 只是为了方便看到这是转换后的结果才这样标记的。实际访问的时候还是垂直向下为 0轴，水平向右为 1轴。
  
  * 再来三维的，这里我要实现的是把 (2,3,4) 转置成 (2,4,3)

    ```python
    # 代码实现
    data = np.arange(24).reshape(2,3,4)
    data1 = data.transpose((0,2,1))

    '''
    或者说一下，为什么我要这样做？
    实际上是，我遇到需要把 3个 二位数组 组成一张图片，
    即给我三个通道 [r,g,b]，我要把它还原成图片，
    使用 cv2.merge() 就可以做到，但不甘心啊！哈哈
    直接用 np.array([r,g,b]) 返回的 shape 是(3, H, W)，而显示图片需要 (H,W,3)
    所以也就是为啥 我要把 0轴对应 Height，也是为了方便理解
    '''
    ```

    ![看不到图是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/2020-09-05_01-11-10.png)

    * 解释：三维数组 调换轴顺序，只要按照 图上说的步骤即可，每一次只调换两个轴构成的平面，向另一轴方向推进 转置即可完成！
    * 怎么验证自己的想法或者思路对不对呢？只要交换轴顺序后，写出一个 坐标 输出看看 对应的 数值 是不是自己想要得到的就好了。

      ```python
      # 例如：我每次输出 11
      data = np.arange(24).reshape(2,3,4)
      print(data[0,2,3])  # 11

      data1 = data.transpose((0,2,1))  # 0轴 不变
      print(data1[0,3,2])  # 11

      data2 = data.transpose([1,0,2])  # 2轴 不变
      print(data2[2,0,3])  # 11

      data3 = data.transpose([2,1,0])  # 1轴 不变
      print(data3[3,2,0])  # 11
      ```

    * 上面的三维都是假设 其中一轴不交换，那三轴两两交换呢？

      * 说多一句，`transpose()` 是参数是 新的轴顺序 对吧？`data.transpose([0,2,1])` 意思就是 新生成数组的 0轴 就是原来数组的 0轴，1轴就是原来的 2轴，2轴就是原来的 1轴。（**理解好这句话，就通用了！**）

    ```python
    # 比如
    data = np.arange(24).reshape(2,3,4)
    print(data[0,2,3])  # 11

    data4 = data.transpose([1,2,0])  # 三轴两两交换
    print(data4[2,3,0])  # 11

    data5 = data.transpose([2,0,1]) # 三轴两两交换
    print(data5[3,0,2])  # 11
    ```

### 小结

1. 只要理解成 新生成数组的 0轴 就是原来数组的 x轴，1轴就是原来的 xx轴，2轴就是原来的 xxx轴 即可解决任何 三维转置问题！

    ![看不到图是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/2020-09-05_02-02-18.png)

## 把高维数组展成一维 np.ravel() 和 np.flatten()

* `np.ravel()` 和 `np.flatten()` 都可以做到，区别是：

  * `flatten()` 会请求分配内存来保存结果，而 `ravel()` 返回数组的一个视图(view)。（就是说修改了视图就会把源数据也改了）

```python
import numpy as np

x = np.arange(6).reshape((2,3))

a = x.flatten()
b = x.ravel()

# x = [[0 1 2]
#      [3 4 5]]
# a = [0 1 2 3 4 5]
# b = [0 1 2 3 4 5]
```

## 一个神奇的用法

```python
>>> a
[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
>>> arr = np.array(a)
>>> arr
array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
>>> arr[arr<5]=0            # 注意这个用法！！！ list 用不了
>>> arr
array([0, 0, 0, 0, 0, 5, 6, 7, 8, 9])
```

## 一、numpy 的使用

```python
"""
# --------------------------------- 二维 ---------------------------------
>>>a = np.array([[1,2,3],[2,3,4]])
>>>a.shape
(2, 3)
>>>a
array([[1, 2, 3],
       [2, 3, 4]])

# --------------------------------- 三维 ---------------------------------
>>>b = np.array([[[1,2,3],[11,22,33]],[[4,5,6],[44,55,66]]])
>>> b.shape
(2, 2, 3)  # 2 页 2 行 3 列
>>> b
array([[[ 1,  2,  3],
        [11, 22, 33]],  # 我理解为第 1 页

       [[ 4,  5,  6],
        [44, 55, 66]]]) # 我理解为第 2 页
# --------------------------------- 三维（不同页数） ---------------------------------
>>> b = np.array([[[1,2,3],[11,22,33]],[[4,5,6],[44,55,66]],[[7,8,9],[77,88,99]]])
>>> b.shape
(3, 2, 3) # 3 页 2 行 3 列
>>> b
array([[[ 1,  2,  3],
        [11, 22, 33]],  # 我理解为第 1 页

       [[ 4,  5,  6],
        [44, 55, 66]],  # 我理解为第 2 页

       [[ 7,  8,  9],
        [77, 88, 99]]]) # 我理解为第 3 页
"""

```

如图的测试：（plt 的直方图统计和numpy 的统计）

![看不到图是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20200416231911.png)

## 参考

1. [Numpy的常见ufunc函数：sum、bincount、histogram、mean和average](https://blog.csdn.net/bqw18744018044/article/details/81150760)
2. [Python 中的range(),arange()函数](https://blog.csdn.net/qianwenhong/article/details/41414809)
3. [为什么你用不好Numpy的random函数？](https://www.jianshu.com/p/214798dd8f93)
4. [NumPy - 使用 Matplotlib 绘制直方图](https://wizardforcel.gitbooks.io/ts-numpy-tut/content/24.html)（该网站还有一些关于 numpy 的教程，值得一看！）
5. [numpy之转置（transpose）和轴对换](https://www.cnblogs.com/sunshinewang/p/6893503.html)
6. [python之numpy.power()数组元素求n次方](https://blog.csdn.net/lql0716/article/details/52910812)
7. [numpy中np.max和np.maximum](https://www.cnblogs.com/logo-88/p/9265015.html)
