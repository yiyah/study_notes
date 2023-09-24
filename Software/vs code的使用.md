# vs code

[TOC]

## something 使用

* 快捷键

    `CTRL + ALT + -` 后退
    `CTRL + SHIFT + -` 前进
    `CTRL + \` 分屏
    `CTRL + 1 2 3` 切换分屏，也可以新建分屏
    `CTRL + w` 关闭文件，当分屏只有一个文件，就关闭分屏
    `CTRL + -/+` 可以放大缩小 vscode 的界面

* 安装命令 `sudo dpkg -i xxx.deb`

`settings.json` 默认路径：~/.config/Code/User/settings.json
或者是 workspace 下的 ./vscode/settings.json

## 一、markdown 插件

1. Markdown all in one

2. markdown preview enhanced

   * 使用说明：
     * 若要导出pdf，使用 `markdown preview enhanced` 的 `chrome` 导出就好了，就是除了导出的代码块前面可能会有一大段空白之外没啥大问题。

## 二、代码补全

搜索prevent，取消此项的勾选（`controls whether an active snippet prevents quick suggestions`）

1. 配置 `c++` 代码补全

    * STEP1. 首先安装 `C/C++` 的官方插件（新建一个 `cpp` 时软件会提示安装）
    * STEP2. 配置软件搜索路径

      * `Ctrl + Shift + P` --> 输入 “edit” --> 选择 `C/C++: edit configurations`
      * step2: 在“includePath”的属性中添加 库路径 就行了

    * 其他问题

        如果补全不了 结构体成员 可以试试这个（上面的方法也没用）

        ```json
            "C_Cpp.intelliSenseEngine": "Tag Parser",
        ```

2. python 补全

    * 以 opencv 为例，把编译后的 `.so`（`path/to/cvBuild/myInstall/lib/python3.6/site-packages/cv2/python-3.6/cv2.cpython-36m-x86_64-linux-gnu.so`） 文件放到 `~/.local/lib/python3.6/site-packages/` 下就可以了。

## 三、远程开发

* 通过安装 ssh 插件，连接远程服务器开发。（需要服务器安装了ssh）

```shell
# 安装ssh服务器
sudo apt install openssh-server
# 安装ssh客户端
sudo apt install openssh-client
```

下面讲的是免密码登录方法（其实就是配置 ssh 免密码登录的方法）

### windows

* windows 的难点就是要装 OpenSSH（参考4、5安装后，在 win 上生成公钥放到服务器就可以了）
* 如果不想折腾，可以在服务器上生成公私钥后，把私钥放到客户机，这样也可以。（**不过此操作存在安全隐患**）

然后参考下一步把 客户端的公钥 放到 服务器的私钥 就好了。

### Ubuntu(vs code) 访问 Ubuntu

Linux 直接生成放公钥到服务器就可以使用。

```shell
ssh-keygen -t rsa  # ~/.ssh/ 一直回车就好
# -t type:指定要生成的密钥类型，有rsa1(SSH1),dsa(SSH2),ecdsa(SSH2),rsa(SSH2)等类型，较为常用的是rsa类型

# -C comment：提供一个新的注释

# -b bits：指定要生成的密钥长度 (单位:bit)，对于RSA类型的密钥，最小长度768bits,默认长度为2048bits。DSA密钥必须是1024bits

# -f filename:指定生成的密钥文件名字
```

* step1: 客户端把生成的 公钥 `~/.ssh/id_rsa.pub` 拷贝到 服务器的 `~/.ssh/authorized_keys` （可能需要在服务器 `chmod 700 .ssh` 和 `chmod 600 authorized_keys`）（22/06/07: win访ubuntu 我只做完这个就可以了）

* step2: 服务器开启 密钥 登陆

  ```shell
  sudo vim /etc/ssh/sshd_config

  # 修改以下3行
  RSAAuthentication yes   # 这个可能没有，需要手动添加
  PubkeyAuthentication yes
  AuthorizedKeysFile .ssh/authorized_keys
  # PasswordAuthentication no 这个是禁止 密码 登陆
  ```

* step3: 服务器重启 ssh `sudo service sshd restart`

## 字体

用这个 [cascadia-code](https://github.com/microsoft/cascadia-code)，下载 zip，解压拿到 ttf 文件。只安装 `CascadiaCode.ttf` 即可。

PL: Powerline Ligature 应该是这个缩写

> Cascadia Code和 Cascadia mono是两种等宽字体，都是由 Microsoft 推出的。它们的主要区别是，Cascadia Code 支持编程连字，而 Cascadia mono 不支持。编程连字是一种将多个字符自动组合成一个符号的功能，有些开发者认为这样可以提高代码的可读性1。例如，=> 可以变成 ⇒，!= 可以变成 ≠，等等。如果你喜欢使用编程连字，你可以选择 Cascadia Code；如果你不喜欢或不需要，你可以选择 Cascadia mono。 ---from Bing GPT-4

`Crtl + Shift + P` 后输入 `settings.json` 打开 settings.json（看清有一个是默认的 json 我们可以参考）

配置如下：

```json
{
    // 字体大小
    "editor.fontSize": 18,
    // 下面这个可能是字体顺序
    "editor.fontFamily": "'Cascadia Code', Consolas, 'Courier New', monospace",
    // 连字
    "editor.fontLigatures": true,

    // tab 键补全多少空格，注意下面两行一起
    // 否则有些文件 补全不会用空格
    "editor.detectIndentation": false,
    "editor.tabSize": 4,

    // 选中相同内容高亮
    "workbench.colorCustomizations": {
        "editor.selectionHighlightBackground": "#9b8b17",
        "editor.selectionHighlightBorder": "#ecd9d9",
    },
    
}
```

## 其他配置

```json
    // 取消 ENTER 补全
    "editor.acceptSuggestionOnEnter": "off",

    // 设置菜单栏字体大小，默认0，1是放大20%（-1是缩小）
    "window.zoomLevel": 0.2,
```

## 参考

1. [VSCode中MarkDown输出PDF无法包含LaTeX公式的解决](https://blog.csdn.net/weixin_43318626/article/details/104334609)
2. [解决vscode没有代码提示](https://blog.csdn.net/qq_37162688/article/details/90517963)
3. [VSCode中C/C++库文件的配置（自动提示、补全](https://blog.csdn.net/cbc000/article/details/80670413)
4. [2019 VS Code 远程开发配置（热乎的）](https://blog.csdn.net/yh0503/article/details/89851899)
5. [安装适用于 Windows Server 2019 和 Windows 10 的 OpenSSH](https://docs.microsoft.com/zh-cn/windows-server/administration/openssh/openssh_install_firstuse)
6. [vscode远程开发及公钥配置（告别密码登录）](https://blog.csdn.net/u010417914/article/details/96918562)
