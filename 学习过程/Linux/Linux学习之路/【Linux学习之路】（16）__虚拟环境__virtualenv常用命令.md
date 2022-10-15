# virtualenv 的使用

1. 安装

    ```shell
    sudo pip3 install -U virtualenv
    ```

2. 环境相关命令

    * 因为没有像 `conda info -e` 一样的列出所有环境的命令，所以最好，新建一个文件夹`virenv`，在这个文件夹保存所有环境！

    ```shell
    # 1. 创建环境
    virtualenv --system-site-packages -p python3 work  # 在 ./ 创建了一个 work 文件夹
    # 环境名：work
    # -–system-site-packages: 让该虚拟环境包含系统站点包，给虚拟环境访问系统site-packages目录的权限
    # -p: 指定python版本，可以是 /usr/bin/python3

    # 2. 激活环境
    source parh/to/work/bin/activate

    # 3. 退出环境
    deactivate

    # 4. 删除虚拟环境
    rm -r path/to/work/
    ```

## 参考

1. [Mac中python3虚拟环境管理（创建、激活、退出、删除）](https://blog.csdn.net/paopao10060341/article/details/98039736)