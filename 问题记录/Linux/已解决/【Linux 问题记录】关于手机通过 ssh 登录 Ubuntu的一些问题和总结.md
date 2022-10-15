# 【Linux 问题记录】（3）关于手机 Termux 通过 ssh 登录 Ubuntu 遇到的问题与总结

[TOC]


## 1.   执行 ssh-add 时出现 Could not open a connection to your authentication agent
```bash
# 执行以下命令即可
ssh-agent bash
```

## 2.  关于各设备之间 ping 的问题
* 宿主机（win）可以 ping 通虚拟机（Ubuntu）和手机。
* 虚拟机（Ubuntu）可以 ping 通宿主机（win）和手机。
* 但是手机 ping 不通宿主机（win）和虚拟机（Ubuntu。

其实是 win 的防火墙没有关闭。关闭就好。此时。手机 ping 宿主机（win）是没问题的。
但是要注意的是如果虚拟机和手机不在同一个网段，手机和虚拟机也 ping 不通的。

## 3. Ubuntu 输入 ifconfig 找不到 IP 地址，只有 lo 出现的问题

这个我不知道自己做了什么就出现这个问题，挺严重的，即使按照 参考 2 ，的方法做了，重启之后系统还是找不到我的网卡。唯有快照恢复。





## 参考
1. [执行 ssh-add 时出现 Could not open a connection to your authentication agent](https://www.cnblogs.com/sheldonxu/archive/2012/09/17/2688281.html)
2. [Ubuntu 输入 ifconfig 找不到 IP 地址，只有 lo 问题](<https://blog.csdn.net/weixin_42116341/article/details/81410805>)

