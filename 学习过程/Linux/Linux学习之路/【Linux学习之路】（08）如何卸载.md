

1. 在ubuntu下删除软件需要知道确切的包名,查看软件的完整包名:
```bash
#dpkg -l | grep xxx	# xxx是你想要卸载的软件名字的大概关键字
```

2. 卸载

```bash
# 第一步，常规卸载
sudo apt-get purge 软件名                  //卸载软件
# 第二步，清理一些不需要的文件
sudo apt-get autoremove               //自动清理一些程序
sudo apt-get autoclean                
# 第三步，删除不需要的配置文件
dpkg -l |grep ^rc|awk '{print $2}' |sudo xargs dpkg -P 软件名
# 第四步，更新本地缓存
sudo apt-get update               //更新本地缓存文件

# 完成
```






## 参考
1. [Ubuntu下查看已安装软件名称/卸载软件](https://blog.csdn.net/sinat_19569023/article/details/47023641?utm_source=blogxgwz4)
2. [ubuntu 彻底卸载软件及配置文件](https://blog.csdn.net/weixin_42128364/article/details/81297741)