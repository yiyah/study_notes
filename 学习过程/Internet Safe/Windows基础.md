# Windows 基础

## 认识 系统文件夹

```shell
c:\\PerfLogs       # 日志记录 目录
c:\\Program Files  # 软件安装 目录
c:\\Windows        # 系统文件

# 关键的目录和文件
C:\\Windows\\System32\\config\\SAM  # SAM 文件是记录账号密码的文件
C:\\Windows\\System32\\drivers\\etc\\hosts  # 记录域名解析的地址
```

## 系统服务

### telnet

* telnet：windows 的远程连接功能；Linux 下是 ssh 服务。

* 打开 telnet 服务

  * 服务器
    `cmd 输入 --> services.msc --> 找到 telnet`
  * 客户机
    控制面板 --> 程序 --> 打开或关闭 Windows 功能 --> 勾选 Telnet 客户端

## SMB 服务

* SMB: 文件共享服务（就是设置共享文件夹的服务）

## 常见 DOS 命令

```cmd
ipconfig /release  # 释放 IP
ipconfig /renew    # 重新获取 IP
systeminfo         # 查看系统信息
arp -a             # 查看局域网内还有什么ip（地址解析协议）
net view           # 查看局域网内其他计算机名称

# ============================================
md aaaa\  # 创建 aaaa 目录，注意有个 \
rd aaaa  # 删除 aaaa 目录
copy con c:\123.txt  # 在 c:\ 下创建 123.txt（并输入内容，结束输入：【CTRL + Z】+ 【ENTER】）
type 123.txt   # 查看文件内容
start 123.txt  # 打开 123.txt
del 123.txt    # 删除 123.txt
copy 123.txt c:\Windows  # 复制123.txt 到 Windows 目录下

# ============================================
net use k: \\192.168.1.1\c$  # 把该 IP 的 C 盘映射到本地的 K 盘，需要输入密码。
net use k: /del  # 取消映射
net start  # 查看开启了哪些服务
net start 服务名  # 开启服务（如：net start telnet）
net stop  服务名  # 停止服务

# 用户和组相关===================================
net user  # 查看有哪些用户
net user 用户名  # 查看账户属性
net user 用户名 密码  # 改密码
net user 用户名 密码 /add  # 添加用户（需要在管理员模式的 cmd下执行）
net localgroup administrators 用户名 /add  # 添加用户到管理员组中
net user guest /active:yes  # 激活 guest 用户

# 共享相关===================================
net share          # 查看本地开启的共享
net share ipc$     # 开启 ipc$ 共享
net share ipc$ /del  # 删除 ipc$ 共享

# ===================================
netstat -a  # 查看开启了那些端口，常用 netstat -an
netstat -n  # 查看端口的网络连接情况，常用 netstat -an
netstat -v  # 查看正在进行的工作

# 计划任务相关 ===============================
at  # 查看计划任务列表
at /delete  # 停止所有计划任务，加参数 /yes 则直接确认
at id /delete  # 停止 id 的任务

attrib 文件名（目录名）  # 查看文件（目录）的属性
attrib 文件名 -A -R -S -H  # 去掉文件的 存档，只读，系统，隐藏 属性；用 + 就是 添加。
```

## 内网渗透流程

1. 先扫描端口，假设有 telnet 服务
2. 用 hydra 爆破密码
3. `net use k: \\ip\c$` 进行映射
4. `上传一个批处理文件，里面有添加用户和提升权限的程序`
5. 诱导用户点开