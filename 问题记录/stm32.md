# 关于 stm32 的问题记录

## 一、Flash Timeout.Reset the Target and try it again

* 解决方法：

  * step1: 先下载 [stlink utility](https://www.st.com/en/development-tools/stsw-link004.html)，后安装。
  * step2: 打开 stlink utility（桌面有快捷方式，搜索 stm32 st-link 要好久才搜得到）
  * step3: stlink 连接板子，在菜单栏的Target下选择connect，因为这时候Flash已经被锁住了，所以同样地也看到相应的错误提示 `Can not read memory Disable Read Out Protection and retry`
  * step4: 菜单栏target里打开Option Bytes…选项，发现在这里Read Out Protection选项是enable，这个表示无法通过swd读取STM32内部Flash的程序。改为 disable 即可。

## PWM 配置问题

```c
/* 以下的操作是想要 TIM_SetCompare1(TIM1, 200); 的时候输出20%高
但是实际并不是！而是输出20%低。经排查，原因是没有配置 互补通道，很奇怪！
不用互补通道也得配置！！！
*/
TIM_OCInitStructure.TIM_OCMode = TIM_OCMode_PWM1; //选择定时器模式:TIM脉冲宽度调制模式1
TIM_OCInitStructure.TIM_OutputState = TIM_OutputState_Enable; //比较输出使能
TIM_OCInitStructure.TIM_OutputNState = TIM_OutputNState_Disable; // 互补输出使能
TIM_OCInitStructure.TIM_Pulse = 0;
TIM_OCInitStructure.TIM_OCPolarity = TIM_OCPolarity_High;     //输出极性:TIM输出比较极性高
TIM_OCInitStructure.TIM_OCIdleState = TIM_OCIdleState_Reset;

TIM_OC1Init(TIM1, &TIM_OCInitStructure);  //根据TIM_OCInitStruct中指定的参数初始化外设TIMx
TIM_OC1PreloadConfig(TIM1, TIM_OCPreload_Enable);  //使能TIM8在CCR2上的预装载寄存器
```

参考

1. [STM32 使用st-link调试遇到写保护 Flash Timeout 问题的解决思路](https://great.blog.csdn.net/article/details/105124542?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromBaidu-2.not_use_machine_learn_pai&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromBaidu-2.not_use_machine_learn_pai)
2. [STM32 ST-LINK Utility 使用教程](https://blog.csdn.net/leonsust/article/details/96116315)
