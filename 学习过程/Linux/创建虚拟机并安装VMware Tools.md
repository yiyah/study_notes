# 创建虚拟机并安装VMware Tools

---

配置：

1. VMware Workstation 14 Pro（14.1.2 build-8497320）
2. ubuntu-18.04-desktop-amd64.iso

VMware 配置（开发用）：

1. 修改内存为：4g；
2. 处理器数量：2，每个处理器的内核数量：2。

安装：
1.
![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190516230347.png)
2.
![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190516230537.png)
3.
![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190516231514.png)
4.
![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190516231536.png)
5.
![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190516231603.png)
6.
![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190516231645.png)
7.
![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190516231744.png)
8.
![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190516231842.png)
9.
![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190516231901.png)
10.
![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190516231934.png)
11.
![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190516231952.png)
12.
![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190516232156.png)
13.
![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190516232213.png)
14.
![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190516232232.png)
15.
![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190516232259.png)
16.
![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190516232310.png)
17.
![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190516232321.png)
18.
![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190516232424.png)
19.
![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190516232437.png)
20.重启之后安装VMware Tools
![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190516232450.png)
21.此时Ubuntu系统已加载
![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190516232530.png)
22.双击打开把所有文件复制到自己新建的一个文件夹里。如：
![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190516232606.png)
23.
![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190516232627.png)
24.
    先输入  ls 命令查看当前目录下的文件，看到红色的文件名字（.gz结尾）就是我们要解压的文件
    再输入  tar zxf XXX（XXX对应自己的红色文件名)
    输入后会看到多了一个文件夹
![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190516232640.png)
25.进入该文件夹后看到一个 .pl 结尾的文件，运行它（注意要用管理权限sudo，并且输入密码，密码输入是看不见的）
![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190516232657.png)

![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190516232709.png)
26.安装的时候遇到【no】就输入yes，其他都可以按回车。
![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190516232736.png)
27.完成
![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190516232826.png)

## 参考

1. [VMware Tools安装方法及共享文件夹设置方法](https://www.cnblogs.com/huangjianxin/p/6343881.html)
