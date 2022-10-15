# cv

* cv 读取的图片是按照 BGR 存放，并且对一张图片进行操作后，存放还是 BGR，即使源图是 RGB 顺序。什么意思？

    ```python
    img = cv2.imread('test.jpg')                    # img 是 BGR 顺序
    img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)      # img 转换成 RGB 顺序
    img_hsv = cv2.cvtColor(img, cv2.COLOR_RGB2HSV)  # 转换成其他颜色空间，img_hsv 的顺序是 BGR ！！！
    # 从上面的例子可以看出，即使操作的源图是 RGB 顺序，结果保存的顺序仍是 BGR 顺序
    # 同时，怎么提取 H,S,V 通道？
    h,s,v = cv2.split(img_hsv)  # 即 HSV 通道对应的就是 BGR 的通道顺序（还有一个辅助依据就是，h 范围是[0,180]）
    ```

* 颜色空间

  * 求别的颜色空间的灰度值，和 RGB 空间不一样，如 HSV 空间，把三通道分离后， V 通道就是灰度值。

## 相关函数用法

```python
# 1.
img_gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

# 2. threshval: 阈值; maxval: 选择对应的操作后，dst=maxval
ret, shizi = cv2.threshold(img_gray, threshval, maxval, cv2.THRESH_BINARY+cv2.THRESH_OTSU)

```