# ssh 的总结

## 配置别名

```shell
vim .ssh/config

# 添加以下内容

Host xxx-server
  HostName 192.168.10.62
  User yiya

# 下次直接 ssh xxx-server 就可以了
```

## 配置免密码 ssh

**客户端配置：**

1. step1: `ssh-keygen -t rsa`  生成公私钥（如果是 windows 可以用powershell 生成）
2. step2: `ssh-copy-id -i id_rsa.pub jetbot@192.168.5.220`  添加公钥到服务器(`~/.ssh/authorized_keys`)
3. step3: `vim ~/.ssh/config` 添加以下内容

    ```shell
    Host jetbot
      HostName 192.168.5.220
      User jetbot
    ````

**服务器配置：**

1. step1: sudo vim /etc/ssh/sshd_config

    ```shell
    RSAAuthentication yes  # 这个可能没有
    PubkeyAuthentication yes
    PasswordAuthentication no  # （可选）禁用密码登录
    ```

2. step2:重启 ssh: `sudo service sshd restart`

* 最后，在客户端`ssh jetbot@192.168.5.220` 就可以了。如果出现`Host key verification failed`，解决方法是：`ssh-keygen -R 你要访问的IP地址`，然后重新连接就可以了。

```bash
# 确认自己有没有 ssh 服务
sudo ps -e |grep ssh  # 如果没有返回东西，或者返回的内容没有 sshd 字眼的就是没有 ssh
# 安装 ssh
sudo apt-get install openssh-server -y
# 启动 ssh 服务
sudo service ssh start
```

```bash
ssh-keygen -t rsa  # 一般在 ~/.ssh 路径下
ssh-keygen -t rsa -P '' -f ~/.ssh/my_id_rsa  # 指定密码，路径和名字生成
# 如果用第一条命令生成的话，因为没有指定文件路径和名字，你回车后，第一次返回的信息问你是生成在 .ssh/id_rsa吗？此时你可以输入路径和名字，改变生成位置。然后接下来就回车就好了，不用在设置其他。
# 参数说明
# -t 加密算法类型
# -P 指定私钥密码，一般不设置，不然你每次用公私钥连接都要求密码，注意 -P ''是单引号
# -f 生成路径
```

```bash
# ssh-copy-id -i xxx.pub 登录名@服务器的地址 -p 8022，如下
ssh-copy-id -i hzh.pub cp@192.168.1.100 -p 8022
```

```bash
# 先了解下以下命令
# ssh-add 命令 是把专用密钥添加到 ssh-agent 的高速缓存中。该命令位置在 /usr/bin/ssh-add。
ssh-add ~/.ssh/xxx  # 把私钥添加到 ssh-agent 的高速缓存中
ssh-add -l  # 查看 ssh-agent 中的密钥
# 关于更详细的 ssh-add 命令看 参考2，目前只用到这两个
```

```bash
ssh -i ~/Deskdore/xxx test@192.168.1.100  # -i 指定私钥位置
# 这种方式会遇到 密钥 的权限 too open 或者还需密码登录，这个时候就更改下权限 chmod 600 xxx
```

```bash
# 1. client 上传到 server
# 1.1 上传文件
scp local_file user@host:/home/user/pathname/to/save/file.txt
# 例如：（注意：后面的路径也要加上文件的名字和类型）
scp file.txt user@192.168.1.1:/home/user/path/to/save/file.txt

# 1.2 上传文件夹
scp -r local_folder user@host:/home/user/path/to/save
# 例如：（注意：remote_folder后加不加 / 都可以）
scp -r local_folder user@192.168.1.1:/root/remote_folder # 如果没此文件夹，会自动创建

# 2 从 server 下载到 client
# 2.1 下载文件
scp user@host: 文件名 本地目录
# 2.2 下载目录
scp -r local_folder remote_username@remote_ip:remote_folder # 用这个
```

```bash
# Termux 会弹出一个错误（忘了啥）
ssh-agent bash
```

## xshell 怎么下载上传文件

```shell
# 服务器操作,安装一个软件，该软件专门用来上下传
sudo apt-get install lrzsz
# 上传
rz
# 下载
sz filename
# 详细看 参考 1,2
```

## 参考

1. [XShell上传、下载文件](https://www.cnblogs.com/qq240115928/p/7112482.html)
2. [XShell-上传、下载文件（使用sz与rz命令）](https://www.jianshu.com/p/2d057453117f)
3. [给远程主机起别名](https://blog.csdn.net/weixin_33938733/article/details/94231732)
4. [2019 VS Code 远程开发配置（热乎的）](https://blog.csdn.net/yh0503/article/details/89851899)
5. [安装适用于 Windows Server 2019 和 Windows 10 的 OpenSSH](https://docs.microsoft.com/zh-cn/windows-server/administration/openssh/openssh_install_firstuse)
6. [vscode远程开发及公钥配置（告别密码登录）](https://blog.csdn.net/u010417914/article/details/96918562)
7. [解决Host key verification failed.(亲测有效)](https://blog.csdn.net/wd2014610/article/details/85639741)
