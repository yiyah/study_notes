
## 一直用试用期

* step1: `C:\Program Files (x86)\Source Insight 4.0` 拷到其他盘并用十六进制编辑器打开。（如我用vscode的插件hexeditor）
找到 `c800 0000 742a 83bc 2408` 这一段，修改74 为 eb。
* step2: 第一次修改不用做这一步，因为三个月后，SI又提示我过期，所以通过这一步又可以续命
`C:\ProgramData\Source Insight\4.0\si4.lic` 隐藏文件夹来的，然后改下面
```
Date="2023-04-14"  // 这个改为前一天
Expiration="2033-04-13"  // 这个就同月份少一天嘛，年份的话应该2030往后都行
```

## 快捷键

`ALT + <>` 前进后退
`SHIFT + F8` 高亮
`SHIFT +TAB` 向左缩进

## 问题

1. 老是突然卡顿，下方提示 “checking for modified files”
   可能的解决方法：
   ① optinos --> preference--> files: 取消"Reload  externally  modified  files in background" **不行**
   ③ optinos --> preference--> general: 改大一点 "Update recovery file every [] seconds" **不行，我改成60s都不行**
   ② optinos --> preference--> general: 取消”Background synchronization every [] minutes“ **好像有用wer**

## 参考

1. [Source Insight 4.0 过期方法](https://blog.csdn.net/weixin_42187898/article/details/107102974)
2. [详细：Source Insight 4.0 延长试用期方法，图文教程](https://blog.csdn.net/STCNXPARM/article/details/108720060?spm=1001.2101.3001.6650.2&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-2-108720060-blog-107102974.235%5Ev29%5Epc_relevant_default_base&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-2-108720060-blog-107102974.235%5Ev29%5Epc_relevant_default_base&utm_relevant_index=5)
