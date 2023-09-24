# boot

1. `3.1.0` 的 minix，首先 boot --> boot image，
在 os shutdown 后，控制权又回到 boot

    * 当然，上电后，默认会有两个 boot image。3秒给你选择。可以按 `ESC` 进到 boot 的 cmdline

2. boot 怎么找 boot image?

    * /boot/image/ 下
    * /boot/image_small 的image
    默认是 /boot/image/ 下

3. 可以改 默认 boot 的 image 名字吗？

    可以，进入 Boot
    `set` 可以查看所有环境变量 environment varibles
    `iamge = /boot/imge_big` 设置 boot 找 image 的名字为 image_big
