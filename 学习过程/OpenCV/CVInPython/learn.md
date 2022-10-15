# OpenCV In Python

[toc]

## 一、基础

```python
# ==================！！！重要！！！========================================
# 同时，必须用按键按下，否则会卡住！可以杀进程，一般是杀python的PID。or reboot
# ============================= cv自带函数显示图片 =============================
src = cv2.imread("path") # 注意，src 类型是 numpy.ndarray(就是 np.array())
cv2.imshow("src", src)
cv2.waitKey(0)  # 没有下面两句 显示会错误！并且不能点关闭图像，要按键，否则，bash会卡住
cv2.destroyAllWindows()
# ==========================================================================
# ============================= 使用 plt 显示图片 =============================
src = cv2.imread("path")
plt.imshow(src)
plt.show()
# ==================================说明========================================
channels = cv2.split(src) # 通过分离通道，把对应的通道的像素存在 channels，类型是 list
print("channels len is ", len(channels)) # 看看 channels 的长度。(就是看图片是几通道的)


# 因为在 python 中，使用opencv读取的图片，保存的类型是 numpy.ndarray()，
# 所以操作像素值都是应该以 np 的操作为准，不再像 c++ 一样，提供 Mat 来操作数据了。

# ===================== 图像数据 ===============================
src.shape    # 获取图片的形状（行，列，通道数）（通道数为0，就不显示了）
src.dtype    # 图像数据（像素值）类型
src.size     # 图像像素数目

# ===================== 怎么生成指定大小的图像 ===================
mask = np.zeros(src.shape, np.uint8)
mask = np.zeros((300, 500, 3), np.uint8)

# ===================== 访问和操作像素 ===================
roi = src[50:100,50:100]    # 截取ROI
src[50, 100] = (0, 0, 255)  # 赋值
src[0:100,50:100,0] = (0, 0, 255)

# ===================== 访问其他通道 ===================
src[0:100,50:100,0] = 255
src[0:100,50:100,1] = 255
src[0:100,50:100,2] = 255

b,g,r = cv2.split(src)
```

## 相关  API

```python
# 1. 调整大小
dst = cv2.resize(src, dsize, fx, fy)# 指定dsize（是一个tuple），fx,fy 不起作用
"""
使用 1：
w = int(src.shape[1]/2)
h = int(src.shape[0]/2)
dst = cv2.resize(src, (w,h),interpolation = cv2.INTER_AREA)
使用 2：
dst = cv2.resize(src, None, fx = 0.5,fy=0.5)
"""
# 2. 翻转
dst = cv2.flip(src,flipCode) # flipCode = 0:flip around x axis;>0: flip around Y axis;<0:flip x y axixs 

# 3. 分离合并通道
b,g,r = cv2.split(src) # 此时，b,g,r 是一个np二维数组
bgr = cv2.merge([b,g,r])
```

## X、参考

1. [Python+OpenCV图像处理（八）—— 图像直方图](https://www.cnblogs.com/FHC1994/p/9118351.html)
