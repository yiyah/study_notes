# 使用 caffe 的 caffe.io.load_image()出错

---

[toc]

---



## 一、问题

```python
# 我用 jupyter notebook 调试 caffe 的 bolb 的时候，第一步就有问题了。
# 运行语句如下：
src = caffe.io.load_image('cat.jpg')
# 报错如下：
# TypeError      Traceback (most recent call last)
# ... 中间一长串 的代码追踪...
# TypeError: _open() got an unexpected keyword argument 'as_grey'

最后一句，错误源头就给出来了，未知类型。然后就是往回分析错误，发现：

~/app/caffe/python/caffe/io.py in load_image(filename, color)
    300         of size (H x W x 1) in grayscale.
    301     """
--> 302     img = skimage.img_as_float(skimage.io.imread(filename, as_grey=not color)).astype(np.float32)
    303     if img.ndim == 2:
    304         img = img[:, :, np.newaxis]
    
原来是这句的 as_grey=not color 写错了，大概是 grey 和 gray 都是灰色的意思？
找到问题就对症下药！
```



## 二、解决方法

```python
1. 找到 caffe/python/caffe/io.py
2. 找到第 302 行，修改 as_grey 为 as_gray 
3. 问题解决！
```

