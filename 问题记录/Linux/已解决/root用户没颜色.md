# root 用户没颜色

```shell
# step1
vim ~/.bashrc
# step2: 找到以下一行
xterm-color) color_prompt=yes;;
# 修改成以下
xterm-color|*-256color) color_prompt=yes;;
# step3: 生效
source .bashrc
```

1. [Linux 切换到 root 用户后没有颜色](https://blog.csdn.net/weixin_43734095/article/details/105035484)（由此得到灵感）
