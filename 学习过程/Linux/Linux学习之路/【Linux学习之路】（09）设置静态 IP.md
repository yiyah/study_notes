# 设置静态地址 IP

## 环境

ubuntu 1804

## 步骤

* step1: 确认自己的网卡名称 `ifconfig` or `ip addr`
* step2: 修改配置文件

    ```shell
    sudo vim /etc/netplan/01-network-manager-all.yaml  # 先备份

    # 照着添加下面的内容就好了
    yiya@boom:/etc/netplan$ cat 01-network-manager-all.yaml
    # Let NetworkManager manage all devices on this system
    network:
    version: 2
    renderer: NetworkManager
    ethernets:
        ens33: # 配置的网卡名称,使用ifconfig -a查看得到
        dhcp4: no # dhcp4关闭
        addresses: [192.168.10.18/24] # 设置本机IP及掩码
        gateway4: 192.168.10.1 # 设置网关
        nameservers:
            addresses: [192.168.10.1] # 设置DNS
    ```

* step3: 使生效 `sudo netplan apply`

* others

   动态 IP 配置文件

    ```cmd
    # Let NetworkManager manage all devices on this system
    network:
    version: 2
    renderer: NetworkManager
    ethernets:
        enp3s0: #配置的网卡名称,使用ifconfig -a查看得到
        dhcp4: true #dhcp4开启
        addresses: [] #设置本机IP及掩码，空
        optional: true
    ```

## 之前失败的方法

<details>
<summary><code>之前失败的配置</code></summary>

（这里做个记录，我自己按照这个方法是用不了的，哈哈，我一开机就是 DHCP 分配好的 IP 和宿主机同一网段，但我还是自己按照别人的步骤试了一遍，然后以下方法在我这里是不行的，仅供参考）

接下来就是设置静态 IP 的方法了：

```bash
# 编辑网络配置文件
sudo vim /etc/network/interfaces
# 输入以下内容
auto xxx # xxx 是你 ifconfig 后看到的网卡名称
iface xxx inet static 
address 192.168.nnn.mmm # nnn 是根据宿主机的网段设置的，mmm 是你自己设置的，规则百度下好像是不超255
gateway 192.168.nnn.1 
netmask 255.255.255.0 
dns-nameservers qqq.qqq.qqq.qqq # 这个也是根据宿主机的 dns 地址设置的，有两个就写两行
```

我的宿主机网络参数如下：

![看不到图是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190509034612.png)

虚拟机配置如下：

![看不到图是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190509034750.png)

* 然后重启 Ubuntu

    我试过以下些重启网络的命令，但都没用，重启Ubuntu才行。

    ```bash
    sudo /etc/init.d/networking restart
    # or
    service network-manager restart
    ```

  ![看不到图是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190509035623.png)

* 然后 ping 宿主机测试一下结果不行，应该是 dns 没有设置到。
  ![看不到图是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190509035935.png)

网上也有教怎么设置 DNS的，要注意的是，如果是修改 /etc/resolv.conf 文件去设置 DNS，重启后会被重置

我们修改`/etc/systemd/resolved.conf`这个文件。

第一次打开会看到下面这样的

![看不到图是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190517110944.png)

修改成下图的样子，保存（同时去把刚才`/etc/network/interfaces` 的最后两行的dns配置删掉）。

![看不到图是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190517111134.png)

</details>

## 参考

1. [Ubuntu Desktop 18.04 设置静态 IP 方法（超详细）](https://blog.csdn.net/qq_36937342/article/details/80876385) （没用）
2. [ubuntu18.04配置静态ip和动态ip](https://blog.csdn.net/u014454538/article/details/88646689)
