# 学习 matplotlib

[toc]

## 一些通用的参数设置

```python
plt.title("time-speed")  # 设置标题

plt.xlabel('time')       # 设置 x 坐标标签
plt.ylabel('speed')      # 设置 y 坐标标签

# 同时设置图形 x,y 坐
plt.axis([x_low,x_height,y_low,y_height])标范围  # 其他用法 print(plt.axis())
# 单独设置坐标范围
plt.xlim([x_low,x_height])
plt.ylim([y_low,y_height])

plt.axis('off')  # 去掉坐标轴
plt.xticks([])   # 去掉刻度
plt.yticks([])

plt.legend(loc=1)  # 显示图例，loc指定位置（用这个函数，plt.plot(x,y,label="sin(x)")）(一定要加上label)
plt.figure(figsize=(12,6))  # 设置画布大小

plt.imshow(img, cmap='gray') # 这个是改变显示风格的，比如，灰度图 plt 默认显示不是黑白的
```

## 一、显示图片

### plt 显示图片

```python
from matplotlib import pyplot as plt

img = plt.imread('./orange.jpg')
plt.imshow(img)
plt.show()
```

### 结合 OpenCV 显示

```python
import cv2
from matplotlib import pyplot as plt

imgPath = './orange.jpg'
img = cv2.imread(imgPath)
# 因为 plt 显示图片是按照 r, g, b 来显示的
# 但是 OpenCV 是按 b, g, r 读取
b, g, r = cv2.split(img)  # 所以，要进行通道分离
img = cv2.merge([r, g, b])  # 再按照 rgb 的顺序合并
plt.imshow(img)
plt.show()

# way 2: 分离通道的另一方法
b = img[:, :, 0]
g = img[:, :, 1]
r = img[:, :, 2]

# 合并图像的另一方法
img = np.array([r,g,b])
img = img.transpose((1,2,0))
```

## 二、直方图 hist

* `hist(x, bins=None)` 参数说明：

  * `x`: 待统计的数据
  * `bins`: 待统计的数据 的区间。（网上很多都解释为总共有几条条状图，但是我觉得不怎么合适，个人理解为待统计的数据是怎么分组（即怎么设置区间）较为合适，看下面例子就知道为什么我这么说了）
  * `edgecolor`: 长条形边界的颜色。
  * `facecolor`：长条形颜色
  * `alpha`: 代表透明度

* 简单的使用

  * `bins = np.arange(最小的数，最大的数+2)`

    ```python
    from matplotlib import pyplot as plt
    import numpy as np

    x = [0,0,1,2,3,4,4,4,5,5]
    bins = np.arange(0,7,1)  # 返回的是 [0,1,...,6]
    plt.hist(x, bins=bins, edgecolor='white')  # 长条形的左下角的x坐标就是该条状的数据，y坐标就是频数
    plt.show()

    # 因为我们的数据范围是 0~5，总共由 6 类数，共 10 个数
    # 所以分 6 个组，分别是[0,1),[1,2)...[5,6)；[0,1)统计的是0，[1,2)统计的是1，左下角的x坐标
    # 如果用网上的解释，直接设 bins=6 # plt.hist(x, bins=6, edgecolor='white')
    # 你会发现横坐标很乱，而且怎么解释 它可以被 np.arange() 赋值呢？
    # 用我的理解，bins 表示带统计数据 的分区，那就可以理解为：
    # 只要看 待统计的数据 有多少类，一般直接找数据中最小和最大数，多少类=最大-最小+1
    # 比如 [-2,-2, 0, 5,5,5, 20]，有多少类？答案是23类，千万不要觉得有 4 类！
    # 因为要考虑坐标轴，没有写出来的数是被悄悄隐藏起来了
    # 所以 这个数据的统计代码表达是 plt.hist(x, bins=np.arange(-2,22,1))
    # 那 bins=np.arange(start, stop, step) 怎么确定？
    # start 是最小的数，stop 就是最大的数+2, step 为 1 就好了
    # 为什么 stop 是最大的数+2 ? 因为要返回最后的区间是 [最大的数, 最大的数+1)
    # 但是 np.arange(start, stop, step)，返回 start, 不返回 stop
    # 所以，stop = 最大的数+1+1 = 最大的数+2
    ```

* 统计图片直方图

    ```python
    from matplotlib import pyplot as plt
    import numpy as np
    import cv2

    img = cv2.imread("test.png")
    # img = plt.imread("test.png")  # 注意用 plt 读取的图片范围是 0~1
    plt.hist(img.ravel(), bins=np.arange(0,257))
    plt.show()
    ```

## 三、画线

### 直线图

```python
from matplotlib import pyplot as plt

x = [0,10]  # 代表 x 轴 0~10
y = [0,10]  # 代表 y 轴 0~10
y1 = [2,8]  # 代表 y 轴 2~8

plt.plot(x,y)  # 画 线1
plt.plot(x, y1, color='g')  # plot 多一个就可以画多一条线
plt.show()  # 显示
```

### 图片的直方折线图

```python
from matplotlib import pyplot as plt
import numpy as np
import cv2

img = cv2.imread("test2.jpg")
b_hist, b_bins = np.histogram(img[:,:,0], bins=np.arange(257))
g_hist, g_bins = np.histogram(img[:,:,1], bins=np.arange(257))
r_hist, r_bins = np.histogram(img[:,:,2], bins=np.arange(257))

plt.plot(np.arange(256), b_hist, color='b')
plt.plot(np.arange(256), g_hist, color='g')
plt.plot(np.arange(256), r_hist, color='r')
plt.show()
```

## 多图

首先，来个简单的（`plt.plot()`方法，复杂的就是`add_subplot()`面向对象）

```python
import numpy as np
from matplotlib import pyplot as plt
import cv2

img_path = 'shizi.jpg'
img = cv2.imread(img_path)  # 读取图片

img_hsv = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)
plt.subplot(1,2,1)  # 创建子图（也可理解为创建坐标系），1行2列个图，现在这个图在索引是1的图上
plt.axis('off')     # 关闭坐标轴显示
plt.imshow(cv2.cvtColor(img_hsv, cv2.COLOR_BGR2RGB))  # 显示图

img_lab = cv2.cvtColor(img, cv2.COLOR_BGR2LAB)
plt.subplot(1,2,2)  # 创建子图（也可理解为创建坐标系），1行2列个图，现在这个图在索引是2的图上
plt.axis('off')
plt.imshow(cv2.cvtColor(img_lab, cv2.COLOR_BGR2RGB))

plt.show()
```

再来个复杂的（面向对象）

```python
from matplotlib import pyplot as plt

figure = plt.figure()  # 创建一个画布
figure.suptitle('phto')  # 添加总标题，注意和子图标题区别

# 第一行的图
ax11 = figure.add_subplot(2,2,1)  # 创建一个 子图对象，并且将画布分为2行2列，return 索引为1的子图对象
ax12 = figure.add_subplot(2,2,2)  # 创建一个 子图对象，并且将画布分为2行2列，return 索引为2的子图对象
ax11.set_title('1hsv')  # 设置子图标题，也可理解为设置坐标轴标题
ax12.set_title('2lab')
ax11.imshow(cv2.cvtColor(img_hsv, cv2.COLOR_BGR2RGB))  # 子图显示图片
ax12.imshow(cv2.cvtColor(img_lab, cv2.COLOR_BGR2RGB))

# 第二行的图
ax21 = figure.add_subplot(2,2,3)
ax22 = figure.add_subplot(2,2,4)
ax21.set_title('3hsv')
ax22.set_title('4lab')
ax21.imshow(cv2.cvtColor(img_hsv, cv2.COLOR_BGR2RGB))
ax22.imshow(cv2.cvtColor(img_lab, cv2.COLOR_BGR2RGB))

ax11.axis('off')
ax12.axis('off')
ax21.axis('off')
ax22.axis('off')

plt.show()
```

```python
# 创建多个坐标系的用法
from matplotlib imort pyplot as plt
figure = plt.figure() # 创建一个画布
axes1 = figure.add_subplot(1,3,1) # 创建坐标系1
axes1 = figure.add_subplot(1,3,2) # 创建坐标系2
axes1 = figure.add_subplot(1,3,3) # 创建坐标系3
axes1.plot([],[]) # 根据情况带入 X 坐标的数值，y 坐标的数值
axes2.plot([],[])
axes3.plot([],[])
figure.show()
# add_subplot()参数说明：
# 前两个参数代表总共的坐标系有多少，像我写的就是：总共1x3=3个坐标系；怎么分布？1行3列分布。
# 最后一个参数：坐标系的索引，比如1，就是第一个坐标系。
# axes3 = add_subplot(8,8,3) 就是总共64个坐标系，axes3 在第三个进行绘图。

# 流程：
# figure() --- title() --- 【x/ylabel() --- x/ylim()】 --- plot() --- legend() --- show()
# 详细：就是创建画布（可以指定大小，标题） --- （创建子图） --- 命名子图 --- 设置坐标轴（命名+上下限）--- 画东西（plot()或hist()） --- 标注图例 --- 显示出来
# 简略：创建画布（可以指定大小，标题） --- （创建子图）--- 画东西（plot()或hist()） --- 显示出来
```

## 参考

1. [matplotlib绘图的核心原理讲解](https://baijiahao.baidu.com/s?id=1659039367066798557&wfr=spider&for=pc)
2. [matplotlib中plt.legend等的使用方法](https://www.cnblogs.com/lfri/p/12248629.html)
3. [NumPy Matplotlib](https://www.runoob.com/numpy/numpy-matplotlib.html)
4. [[问答\]](https://bbs.pinggu.org/forum.php?mod=forumdisplay&fid=436&filter=typeid&typeid=2606)
5. [matplotlib包中，ax.set_title和plt.title是否等价？](https://bbs.pinggu.org/thread-6860580-1-1.html)
