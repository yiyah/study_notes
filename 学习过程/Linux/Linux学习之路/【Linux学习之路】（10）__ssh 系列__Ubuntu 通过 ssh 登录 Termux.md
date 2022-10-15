# Ubuntu 通过 ssh 登录手机 Termux

我的手机安装了 termux，然后在本篇文章中相当于一台服务器。

[TOC]

先说下大概步骤，有空再补充：

其实是有两种方式连接的，一开始我不知道，我就奇怪，我没有把公钥放到服务器上，也可以连接，随着不断地搞来搞去，终于明白。

* 方式一：密码登录。当你用 ssh 去连接，但是你又没有把公钥给服务器的时候，就会要求你输入密码。
* 方式二：证书（公私钥配对）连接。当你生成了公私钥对，把公钥给了服务器，用 ssh 连接的时候，客户端系统会根据 /etc/ssh/sshd_config 的配置（里面有一个参数 `AuthorizedKeysFile` 设置了私钥 的位置，默认是 `.ssh/authorized_keys .ssh/authorized_keys2`）去 `.ssh/ authorized_keys` 去和 服务器上的`.ssh/authorized_keys`去配对验证。
    ![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190507105929.png)

## 一、环境

Ubuntu 安装 ssh

```bash
sudo apt-get install openssh-server -y
```

## 二、开始

### 1.  Ubuntu 下生成公钥私钥对（默认名字是`id_rsa.pub id_rsa`）

```bash
ssh-keygen -t rsa  # 一般在 ~/.ssh 路径下
ssh-keygen -t rsa -P '' -f ~/.ssh/my_id_rsa  # 指定密码，路径和名字生成
# 如果用第一条命令生成的话，因为没有指定文件路径和名字，你回车后，第一次返回的信息问你是生成在 .ssh/id_rsa吗？此时你可以输入路径和名字，改变生成位置。然后接下来就回车就好了，不用在设置其他。
# 参数说明
# -t 加密算法类型
# -P 指定私钥密码，一般不设置，不然你每次用公私钥连接都要求密码，注意 -P ''是单引号
# -f 生成路径
```

### 2. 把公钥（xxx.pub）的内容拷贝到服务器上的`.ssh/authorized_keys`

就是把公钥放到授权的 keys 中，这样每次连接客户端都会用私钥去验证服务器上的公钥。。。我也不太懂，讲不清楚。就是去验证。
两种方法：

#### 2.1 方法一（这种方法会自动把公钥添加到服务器的 authorized_keys）

```bash
# ssh-copy-id -i xxx.pub 登录名@服务器的地址 -p 8022，如下
ssh-copy-id -i hzh.pub cp@192.168.1.100 -p 8022
```

#### 2.2 方法二（手动）

* 把 客户端（我这就是 Ubuntu）生成的 xxx.pub ，复制到服务器上，然后

```bash
cat xxx.pub >> .ssh/authorized_keys  # 根据自己的路径修改,>>追加内容，>新建内容
```

### 3. 这个时候已经配置好公私钥了。下一步就是连接

注意此时我的 私钥 xxx 和公钥 xxx.pub 是放在 `.ssh/`下的。

```bash
# 先了解下以下命令
# ssh-add 命令 是把专用密钥添加到 ssh-agent 的高速缓存中。该命令位置在 /usr/bin/ssh-add。
ssh-add ~/.ssh/xxx  # 把私钥添加到 ssh-agent 的高速缓存中
ssh-add -l  # 查看 ssh-agent 中的密钥
# 关于更详细的 ssh-add 命令看 参考2，目前只用到这两个
```

* 先看看自己的私钥有没有在 ssh-agent 中 `ssh-add -l`
    如果返回`The agent has no identities.`说明私钥没有添加到缓存。
    然后就通过`ssh-add ~/.ssh/xxx`（根据自己的路径和私钥名称修改）把私钥添加到缓存。
    如果没有把私钥添加到 ssh-agent 中然后去连接，会报错如下：
    `sign_and_send_pubkey singing failed:agent refused operation`

* 输入`ssh test@192.168.1.100 -p 8022` 此时就会登录上服务器了，

    如果生成 公私钥对 设了密码的话是要输入密码连接的，否则是不用密码。
    有个注意的地方是，我看别人有些加上 -T 参数，含义是分配一个伪终端给你。为什么？因为假如你的服务器的界面和你客户端的界面一样，你登上之后没有别的提示的话，你就不能直观的知道自己有没有登上。（我的理解，详情看 参考3）

* 但是如果我不想把我的私钥放在 `.ssh/` 怎么连接呢？

```bash
ssh -i ~/Deskdore/xxx test@192.168.1.100   # -i 指定私钥位置
# 这种方式会遇到 密钥 的权限 too open 或者还需密码登录，这个时候就更改下权限 chmod 600 xxx
```

## 三、优化

OK，到了这里，相信大家已经可以登上服务器了。但是每次都打这么一长串的东西，怎么简化呢？
这个时候我建议大家看一下 参考 4 的回答，很精辟，透彻，看完了就知道怎么配置和为什么要这么配置。

```bash
vim ~/.ssh/configure
# 按照以下格式添加以下内容
Host xxx
   User xxx
   Hostname xxx.xxx.xxx.xxx
   Port xxx
   preferredauthentications publickey
   IdentityFile ~/xxx/xxx
# xxx 是要修改的地方，大家根据自己的环境配置以下，比如我的
##################
# myPhone_termux #
##################
Host myPhone
   User hzh_ubuntu
   Hostname 192.168.1.100
   Port 8022
   preferredauthentications publickey
   IdentityFile ~/.ssh/hzh
```

然后每次连接我的手机，我只需要 `ssh myPhone` ，就可以连上。

![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190507142505.png)

## 四、远程拷贝命令 scp

```bash
# client 上传到 server
# 上传文件
scp 本地文件 user@host: 路径 /
# 上传文件夹
scp -r 本机目录 user@host: 路径 /
# 从 server 下载到 client
# 下载文件
scp user@host: 文件名 本地目录
# 下载目录
scp -r user@host: 目录名 本地目录
```

![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190507175707.png)

## 五、总结

1. client sign in servers
  servers 的 /etc/ssh/ssh_host_ecdsa_key.pub 会被添加到 client 的 .ssh/known_hosts。
  servers 的 authorized_keys 要添加公钥。
2. 若要查看 sshd 的日志，`logcat -s 'syslog:*'`

## 参考

1. [关于公钥私钥的解释](https://zhidao.baidu.com/question/287003276.html)
2. [ssh-add 命令](https://www.jianshu.com/p/0c6719f33fb9)
3. [linux - ssh 中的 -T 参数是干嘛的？](https://segmentfault.com/q/1010000007607194)
4. [关于 ssh-add](<https://segmentfault.com/q/1010000000835302/a-1020000000883441>)
5. [CentOS7.4 配置 SSH 登录密码与密钥身份验证踩坑](https://www.cnblogs.com/Leroscox/p/9627809.html)
6. [使用 Termux 把 Android 手机变成 SSH 服务器](<https://blog.csdn.net/weixin_43223076/article/details/86772646>)
7. [SSH 远程登录和 SSH 免密码登录](https://blog.csdn.net/m0_37822234/article/details/82494556)
8. [配置 ssh 公钥后依然需要输入密码](<https://blog.csdn.net/xingtanzjr/article/details/56873769>)
