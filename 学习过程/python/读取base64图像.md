# 从base64中读取图片

## 如何把图片转换成 base64

* 如下面的一段代码，把图片从二进制格式转成 base64

    ```python3
    import base64
    with open('hh.jpg', 'rb') as f:
        img_data = f.read()  # 读取到的 img_data 是 bytes 类型
    img_base64 = base64.b64encode(img_data)
    with open('imgbase64.txt', 'w') as f:
        f.write(str(img_base64, encoding='utf-8'))
    ```

    以下的 base64 就是一张图片。

    ```base64
    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
    ```

## 如何把 base64 转换成图片

* 基础

    首先，通过 base64 读取到图片的步骤是：
    1. 解码成原本的二进制数据
    2. 通过 `io.BytesIO()` 读取二进制数据加载到内存
    3. 通过 `PIL.Image.open()` 读取这个二进制数据
    4. 最后显示

    ```python3
    import base64
    from PIL import Image
    import io


    with open('b.txt', 'r') as f:  # 把以上的 base64 字符串保存到 b.txt
        b64 = f.read()  # 读取的是字符串

    img_bin = base64.b64decode(bytes(b64, encoding='utf-8'))  # 需要先把 str 转 换到 bytes，然后再解码 base64。此时 img_bin 就是图片的二进制数据
    img = io.BytesIO(img_bin)
    img = Image.open(img)
    img.show()
    ```

* 用 plt 显示（只是第四步换了一种方式）

    ```python3
    import base64
    from PIL import Image
    import io
    from matplotlib import pyplot as plt
    # import numpy as np  # 此库可不用

    with open('b.txt', 'r') as f:  # 把以上的 base64 字符串保存到 b.txt
        b64 = f.read()  # 读取的是字符串

    img_bin = base64.b64decode(bytes(b64, encoding='utf-8'))  # 需要先把 str 转 换到 bytes，然后再解码 base64。此时 img_bin 就是图片的二进制数据
    img = io.BytesIO(img_bin)
    img = Image.open(img)
    img = np.array(img)  # 没有这个也行，这里给出是为了说明怎么转换成 np.array()
    plt.imshow(img)
    plt.show()
    ```

## 参考

1. [StringIO和BytesIO](https://www.liaoxuefeng.com/wiki/1016959663602400/1017609424203904)
2. [Python图像二进制与Base64编码的转换,python,图片,base64,之间](https://www.pythonf.cn/read/72349)
