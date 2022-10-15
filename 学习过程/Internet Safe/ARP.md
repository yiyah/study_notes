# ARP

工具：arpspoof

```shell
sudo apt-get install dsniff  # 安装
arpspoof -i 要伪装的IP -t 要欺骗的 IP # 使用
arpspoof -i 192.168.1.1 -t 192.168.1.10  # 10的主机会把我们的攻击机的地址当成 1的主机
```