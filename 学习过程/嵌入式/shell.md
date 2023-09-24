# shell

Q: 在命令行中输入命令，是谁帮我们执行呢？
A: 是shell。shell根据我们的输入（回车键判断结束输入），找程序run。

Q: shell 在哪里帮我们找到执行程序？
A: 在 PATH 变量中。当然可以使用相对路径、绝对路径来执行程序。

Q: 如何设置 PATH 变量?
A: 三种方法

    ① 临时设置 `export PATH=$PATH:/your/path`（只对当前终端有效）
    ② 永久设置之只对当前用户有效
        把 ① 的命令保存在 `~/.bashrc`（生效方式：source或重新打开终端）
    ③ 永久设置之对所有用户有效
        把 路径添加 保存在 `/etc/environment`（生效方式：source或重新登录）
