# urllib

## urllib.request.urlretrive

* `urlretrieve(url, filename=None, reporthook=None, data=None)` 方法直接将远程数据下载到本地。

    |参数|描述|
    |-|-|
    |filename|指定了保存本地路径（如果参数未指定，urllib会生成一个临时文件保存数据。）|
    |reporthook|回调函数`(num, data_size, totoal_size)`，当连接上服务器、以及相应的数据块传输完毕时会触发该回调，我们可以利用这个回调函数来显示当前的下载进度。|
    |data|指post导服务器的数据，该方法返回一个包含两个元素的(filename, headers) 元组，filename 表示保存到本地的路径，header表示服务器的响应头|

* 例子

    ```python
    from urllib.request import urlretrieve


    url = 'https://opencv.org/wp-content/uploads/2020/07/cropped-OpenCV_logo_white_600x.png'


    def reportPercent(num, data_size, total_size):
        """@parameter description
        num:        已经下载的数据块
        data_size:  数据块的大小
        total_size: 远程文件的大小
        """
        percent = 100.0*(num*data_size)/total_size
        if percent > 100.0:
            percent = 100.0
        print("%.2f%%\r" % percent, end='')


    urlretrieve(url, "cv.png", reportPercent)
    ```

## 参考

1. [python urllib urlretrieve函数解析](https://blog.csdn.net/u013555719/article/details/79335213?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1.channel_param&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1.channel_param)