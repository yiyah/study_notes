## 一、环境

1.  win10
2.  一加 6T ，Android 9

## 二、准备

1.  手机安装 Termux
2.  Termux 安装 openssh `pkg install openssh`
3.  win 上下载 Xshell

## 三、开始

1.  一开始的步骤参照 参考 1 就好，直到 “5.连接”
2.  这里我要说的是参考一不足的地方，连接部分 看我

*   首先现在 termux 输入 `ifconfig` ，找到`inet addr:xxx.xxx.x.x`这个就是你的 ip 地址，记住它。（一般在后几行就找到）。
*   termux 输入 `sshd`开启 ssh 服务。
*   然后打开 Xshell，文件 —> 新建，根据下图输入。

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190506082738.png)

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190506083421.png)



## 四、参考

1.  [详细 termux 开启ssh](<https://blog.csdn.net/qq_35425070/article/details/84789078>)
2.  [使用Termux把Android手机变成SSH服务器](http://blog.lujun9972.win/blog/2018/01/24/%E4%BD%BF%E7%94%A8termux%E6%8A%8Aandroid%E6%89%8B%E6%9C%BA%E5%8F%98%E6%88%90ssh%E6%9C%8D%E5%8A%A1%E5%99%A8/)

