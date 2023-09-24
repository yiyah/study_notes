# pip 的使用

```shell
sudo apt-get install python3-pip

# 1. --user
pip3 install --user numpy  
# 这样会将Python 程序包安装到 $HOME/.local 路径下，其中包含三个字文件夹：bin，lib 和 share
# export PATH=$HOME/.local/bin:$PATH 才可以使用

# 2. -U(--upgrade)
pip3 install -U numpy
# 升级 numpy

# 3. --ignore-installed
pip3 install --ignore-installed numpy
# 忽略已经安装的包，重新安装
```

## 安装本地包

1. 有时候，在线下载很慢

    ```shell
    # 如，下载下面链接的包很慢
    pip install --ignore-installed --upgrade https://storage.googleapis.com/tensorflow/raspberrypi/tensorflow-2.1.0-cp35-none-linux_armv7l.whl
    
    # 解决方法是：手动下载到本地，再安装。
    cd xxx
    pip3 install tensorflow-2.1.0-cp35-none-linux_armv7l.whl
    ```

2. 有时候，安装某个包的时候，安装其他依赖很慢，然后404

    ```shell
    # 如，本地安装这个包，但是需要安装依赖
    pip install tensorflow-2.1.0-cp37-none-linux_armv7l.whl
    # 提示以下错误
    # Downloading grpcio-1.31.0.tar.gz (20.0 MB)
    #|█████████▉                      | 6.2 MB 12 kB/s eta 0:18:47ERROR: Exception:
    # ...
    # raise ReadTimeoutError(self._pool, None, "Read timed out.")

    # 解决方法是：
    # step1: 手动下载
    #   在 https://pypi.org/project 搜索要下载的包，
    #   然后选择列表结果进去后，选择【Download Files】，
    #   根据提示的信息 grpcio-1.31.0.tar.gz (20.0 MB)，在网页找到符合这个的包下载
    # step2: 安装
    pip install grpcio-1.31.0.tar.gz
    # --target=path/to/save 指定安装路径，前提：未安装过此包，否则需要卸载再安装
    ```

## 参考

1. [pip --user参数](https://www.cnblogs.com/i-shu/p/11487612.html)
