# samba

好像失败了

## 环境

1. Ubuntu 1804

## 步骤

```shell
sudo apt install samba
sudo smbpasswd -a yiya  # 添加 yiya 为 samba 用户

sudo vim /etc/samba/smb.conf
sudo service smbd restart
```

```shell
# 修改如下
[global]
workgroup = WORKGROUP
unix charset = UTF-8    # 新增
dos charset = cp936     # 新增

# 在文件最后添加
[share]
  path=/home/用户名/share   #需要共享的目录
  writable = yes 
  valid users = 用户名
```

## 参考

1. [win10映射Ubuntu服务器目录为本地磁盘](https://zhuanlan.zhihu.com/p/352358151)
2. [linux、ubuntu等映射磁盘或者文件夹到windows](https://blog.51cto.com/u_15316847/3219799)
3. [Ubuntu下linux映射共享盘到window下方法](https://cloud.tencent.com/developer/article/1689339)
