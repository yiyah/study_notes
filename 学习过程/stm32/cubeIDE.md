# stm32 CubeIDE

[TOC]

## stm32 cube IDE

* 下载程序的话就是通过 Debug 下载代码。

1. [STM32CubeIDE属于一站式工具，本文带你体验它的强大](https://blog.csdn.net/ybhuangfugui/article/details/89702356)

2. 如何 Debug?

    * 默认使用 stlink（使用 CMSIS-DAP 看`问题1`）

    step1: 首先通过 MX 配置好相关外设，然后 生成代码。
    step2: `（菜单栏）Project --> Build All` 生成 固件。
    step3: `（菜单栏）Run --> Debug Configurations --> new launch configurations(点击第一个图标或者双击列表的 STM32 ... Application)`

3. 修改主题

    * `help --> Eclipse Marketplace`

## 问题

1. 如何使用 CMSIS-DAP Debug？ --> 参考3

    注意创建的 `cfg` 文件的 `source [find target/stm32h7x.cfg]` `stm32h7x.cfg` 改为自己的芯片型号，如我的 `stm32f1x.cfg`（可以在 cubeIED 中的 `xxx Debug.cfg` 文件中找到`source [find target/stm32f1x.cfg]` 确定自己的 `cfg`）（`xxx Debug.cfg` 在调试探头 选择 `ST_LINK(OpenOCD` 后便会自动生成）

2. 需要按下复位按键才能下载的解决

    * 解决方法：参考4

3. 没有自动补全代码功能

    * 解决方法：参考5

4. 添加自己的库路径

    右键工程 `Prorerties` 在弹出窗口的 `C/C++ General --> Paths and Symbols --> Source Location` 添加目录

## 参考

1. [STM32CubeIDE使用总结（三）——debug调试程序](https://blog.csdn.net/tuxinbang1989/article/details/100826820)
2. [【专栏】STM32CubeMX系列教程](https://mp.weixin.qq.com/s?__biz=MzI4MDI4MDE5Ng==&mid=2247486954&idx=1&sn=3e6a63921a1c42a5caf70e5fcaf16ed4&chksm=ebbba001dccc291757508f3ec0e20aa7d11631fac11921bda32dd4eed38de5f917f8af25a7ce&scene=21#wechat_redirect)
3. [在STM32CubeIDE中用OpenOCD调试STM32H750](http://www.wujique.com/2020/03/22/%e5%9c%a8stm32cubeide%e4%b8%ad%e7%94%a8openocd%e8%b0%83%e8%af%95stm32h750/)
4. [使用STM32CubeMX生成代码，需要按下复位按键才能下载的解决...](http://www.stmcu.org.cn/module/forum/thread-619171-1-2.html)
5. [给你的cubeIDE加上翅膀--添加类似keil的代码补全功能！](https://blog.csdn.net/nopear6/article/details/106255311)
6. [STM32CubeIDE使用笔记（04）：杂项记录（要点、方法、技巧等等）](https://blog.csdn.net/Naisu_kun/article/details/97439758?ops_request_misc=%257B%2522request%255Fid%2522%253A%2522160092734619195162118855%2522%252C%2522scm%2522%253A%252220140713.130102334.pc%255Fblog.%2522%257D&request_id=160092734619195162118855&biz_id=0&utm_medium=distribute.pc_search_result.none-task-blog-2~blog~first_rank_v1~rank_blog_v1-21-97439758.pc_v1_rank_blog_v1&utm_term=cube+ide&spm=1018.2118.3001.4187)
7. [[其他] STM32CubeIDE+MSYS2+OpenOCD+DAPLink调试H750VB](http://www.stmcu.org.cn/module/forum/thread-620709-1-1.html)
8. [STM32CubeMX系列教程3:基本定时器](https://www.waveshare.net/study/article-642-1.html)
9. [基于STM32CubeMX的定时器设置](https://www.cnblogs.com/wang-zefeng/p/12976193.html)
10. [STM32 Cubemx 配置定时器定时1mS](https://www.cnblogs.com/xingboy/p/9897500.html)
11. [STM32CubeMX学习笔记1——PWM配置](https://blog.csdn.net/qq_42967008/article/details/89267010)
12. [STM32Cubemx ADC配置详解](https://blog.csdn.net/qq_43225938/article/details/84098810)(这个是 ADC 独立模式、双重模式的解释和配置过程)
13. [STM32 ADC 单次模式、连续模式、扫描模式](https://blog.csdn.net/weicao1990/article/details/70846691)（可以看看这个怎么配置）
14. [对STM32 ADC单次转换模式 连续转换模式 扫描模式的理解](https://blog.csdn.net/weixin_30810583/article/details/97882785?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1.channel_param&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1.channel_param)（配合13一起看）
15. [实现功能：stm32cubeMX配置ADC多通道采集（非dma和中断方式）](https://www.eemaker.com/stm32cubemxadc.html)（这个是 cubeIDE 的ADC配置注解+过程）
16. [STM32CubeMX系列教程7:模数转换(ADC)](https://www.waveshare.net/study/article-646-1.html)(这个参考了 hal 的代码部分，比如要先等待标志位才进行 ADC 转换)
