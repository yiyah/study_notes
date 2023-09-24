# cube MX 配置 PWM

[TOC]

## cube MX 配置

$ Fpwm = 72M / ((arr+1)*(psc+1))(单位：Hz) $

* 72M：芯片主频
* arr: 自动重装载值
* psc: 预分频系数（还有一个时钟分割，也是分频用的，不过始终分割系数只能是2的倍数）

## 程序上修改

* cube MX 生成的代码下载后，还不能直接输出 PWM，还要做一下修改

    ```c
    HAL_TIM_PWM_Start(&htim1, TIM_CHANNEL_1);  // 开启 PWM 输出
    // HAL_TIMEx_PWMN_Start(&htim1, TIM_CHANNEL_2);  // 开启互补 PWM 输出
    __HAL_TIM_SetCompare(&htim1, TIM_CHANNEL_1, 8000);  // 设置占空比
    ```

## 参考

1. [电容充放电——PWM输出波形不是方波的解释](https://blog.csdn.net/qq_45507796/article/details/102869540)
2. [stm32-利用cubemx创建互补pwm---基于HAL库](https://blog.csdn.net/apple_2333/article/details/88722084)