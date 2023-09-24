## 1.  安装`oh my zsh`

用 [oh-my-zsh 官网](https://link.jianshu.com?t=http://ohmyz.sh/)的一键安装脚本
    
```bash
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"` 
```
安装会报错 zsh not installed
之后发现 [termux-ohmyzsh](https://link.jianshu.com?t=https://github.com/Cabbagec/termux-ohmyzsh) 的脚本

```bash
sh -c "$(curl -fsSL https://github.com/Cabbagec/termux-ohmyzsh/raw/master/install.sh)" 
```

一步到位，很赞。

## 2. 获取 su / root 

### 2.1 手机没有 root
利用 proot 工具模拟某些需要 root 的环境
```bash
pkg install proot 
# 输入以下即可模拟 root 环境，输入 exit 即可回到 普通用户
termux-chroot
```

### 2.2 手机已经 root
安装tsu,这是一个su的termux版本,用来在termux上替代su
```bash
pkg install tsu
# 然后在 termux 输入以下切换 root，输入 exit 即可回到 普通用户
tsu
```

## 3. 申请读写权限
```bash
termux-setup-storage
```





## 参考

1. [Termux 安装 oh-my-zsh](<https://www.jianshu.com/p/16f4e1e85e50>)
2. [Termux高级终端安装使用配置教程](https://m.sohu.com/a/230807930_354899)