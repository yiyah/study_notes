# 升级 python

```shell
# step1: 下载
# 打开 https://www.python.org/ftp/python/ 选择合适的版本下载。
# 貌似选这个 Python-x.x.x.tgz 都行，树莓派装这个，其他文章的不是树莓派也装这个
tar zxvf Python-3.6.1.tgz
cd Python-3.6.1
# step2: 安装依赖
sudo apt-get update -y && sudo  apt-get  upgrade -y
sudo apt-get install build-essential libsqlite3-dev sqlite3 bzip2 libbz2-dev
# step3:
sudo ./configure && sudo make && sudo make install # 比较漫长
# 安装在 /usr/local/bin/

# step4:
# 可以创建软连接
```

1. [树莓派升级（安装）Python3.6](https://blog.csdn.net/panwen1111/article/details/88363771)
2. [pip升级后Import Error:cannot import name main解决方案](https://blog.csdn.net/zong596568821xp/article/details/80410416)（升级后pip出问题，看此链接）
3. [ubuntu 中pip 安装软件报错：“Command 'lsb_release -a' returned non-zero exit status 1.”](https://www.jianshu.com/p/3a2877edebe8)升级后pip出问题，看此链接）
