# 单程序关闭提示“你要允许来自未知发布者的此应用对你的设备进行更改吗”

## way 1

注意：该教程原理是强制软件 [以普通用户身份运行] 以取消 UAC 提示！

step1: `regedit`
step2: 在注册表编辑器路径中，输入 `计算机\HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers`，右键——新建字符串值，名称重命名为程序的全路径，数据修改为`RunAsInvoker`。而且可以用","使用多个设置，比如“XP SP3”兼容等，重启电脑即可。
  ![看不到图是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20210819202334.png)

注意：如果你打算添加新字符串值时，发现该注册表已存在了，那么说明你设置过该软件的 兼容性（右键 - 属性 - 兼容性 选项卡），遇到这种情况，你只需追加到最后就行了。
例如注册表已存在的数值数据为：~ WIN7RTM
那么就改成：~ WIN7RTM RUNASINVOKER

## way 2

该方法时通过创建计划任务，把程序添加到 UAC 白名单

看参考3

## 参考

1. [单程序关闭提示“你要允许来自未知发布者的此应用对你的设备进行更改吗”](https://www.pianshen.com/article/41091682680/)
2. [「技巧」UAC 提示很烦但又不想完全关闭？教你如何单独关闭软件的 UAC 提示！](https://zhuanlan.zhihu.com/p/84591808)（这是方法一）
3. [「技巧」添加 UAC 白名单，让软件运行不再提示 UAC！](https://zhuanlan.zhihu.com/p/113767050)（用这个）
4. [XIU2/UACWhitelistTool](https://github.com/XIU2/UACWhitelistTool)
