# 疑问

1. 在第三章【保护模式】中，开始的代码 的疑问。

    程序写好后，cpu怎么知道从哪里开始运行呢？

    就是一开始有定义数据，后面才是程序。cpu如何知道哪些是数据哪些是程序呢？
    是 nasm 通过 LABEL_BEGIN 来区分吗？
    用 masm 还可以通过 `assume cs:code,ds:data` 来区分，但是 nasm 又是怎么区分呢？奇怪！

## 参考

1. [下载地址]( http://www.wenqujingdian.com/Public/editor/attached/file/20180428/20180428095745_17440.pdf )
