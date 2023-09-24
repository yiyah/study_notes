# OpenWRT 使用

## 注意事项

1. 不要改 lan 口的静态地址！！！！
    所有接入 lan 口的设备，都会由该口的 DHCP 服务器分期配地址。
2. 目前最好的方案是：AP选择桥接，这样接入到AP的设备都会和 软路由 的一样了

## DHCP/DNS

在这里可以配置 静态地址，对特定IP分配特定地址

## 防火墙

登录您的OpenWrt路由器后台，在菜单里找到网络，接着在下拉菜单里找到防火墙，单击打开,自定义规则 ，然后添加一条这样的记录：

`iptables -I FORWARD  -m mac --mac-source XX:XX:XX:XX:XX:XX -j DROP`

## 主机名

在这里可以给自己的设备命名

## Vmware 安装 openwrt

1. 操作系统 选 “其他 Linux 4.x 或更高版本内核 64 bit”
2. 内存选 512M
3. 选 桥接网络 （即现在设置 第一块网卡，是 wan 口的）
4. 硬件 里留下 内存，处理器，网络适配器，显示器
   * 新增一个 网络适配器，自定义 为其他的，如： VMnet17
     这块网卡是用于给局域网内其他的设备连接的

未完待续

## cmd

1. `passwd` 改密码
2. `df -h` 查看磁盘空间

## 网络配置

/etc/config/network

某字段默认配置如下

```shell
config interface 'lan'
    option proto 'static'
    option ifname 'eth0'
    option ipaddr '192.168.5.1'
    option netmask '255.255.255.0'

config interface 'wan'
    option _orig_ifname 'eth1'
    option _orig_bridge 'true'
    option ifname 'eth1'
    option proto 'pppoe'
    option username '15768128621'   # 拨号账号
    option password '128621'        # 拨号密码
    option ipv6 'auto'
    option keepalive '0'
```

## Referenct

1. [萌新入门の如何在桌面环境(VMware,Virtualbox)安装尝试软路由系统，桌面环境(VMware,Virtualbox)配置虚拟子网，上手尝试OpenWrt路由系统](https://www.youtube.com/watch?v=UbbZphew_o4&list=PLQXiKqDZ8qAMlLpOJcBUBmNXCBadPY8tD&index=5&ab_channel=eSirPlayGround)
2. [萌新入门之如何给软路由物理机安装OpenWrt系统？如何快捷的更换掉KoolShare固件，如何使用DD命令，如何使用写盘工具Rufus制作U盘上的OpenWrt？](https://www.youtube.com/watch?v=7TAUlkAnoIo&list=PLQXiKqDZ8qAMlLpOJcBUBmNXCBadPY8tD&index=6&ab_channel=eSirPlayGround)
3. [(续)萌新入门之物理机安装OpenWrt系统，手把手教你用DD命令刷OpenWrt固件，全程实操，帮你轻松过渡到Lean大OpenWrt](https://www.youtube.com/watch?v=6varcHt1t1o&list=RDCMUCOhkliOps3IS48ly-MgPC2A&index=17&ab_channel=eSirPlayGround) (实操)
4. [DNS地址查询](https://www.ip.cn/dns.html)
