# 修改 ST 电机库

---

Creation Date: 2020-09-30

---

[TOC]

## 一、环境

1. NUCLEO-G431RB（控制板） +  X-NUCLEO-IHM16M1（驱动板）
2. MC Firmware Library: `5.4.4`

## 二、修改说明

* 本修改说明旨在分析 MC Workbench 生成的代码 和 修改默认的 13 个关键引脚为其他引脚，从而实现**一块控制板 控制 两块驱动板**。

1. 13 个关键引脚

    * 打开生成的工程，查看其引脚配置，有如下 13 个关键引脚。

        ```text
        DBG_DAC_CH1      // DAC 引脚
        M1_CURR_AMPL_V   // 三相 电流
        M1_CURR_AMPL_U   // 三相 电流
        M1_CURR_AMPL_W   // 三相 电流
        M1_TEMPERATURE   // 温度
        M1_BUS_VOLTAGE   // 总线 电压

        M1_OCP           // 故障 信号
        M1_PWM_UH        // 三相 PWM 输出
        M1_PWM_VH        // 三相 PWM 输出
        M1_PWM_WH        // 三相 PWM 输出
        M1_PWM_EN_U      // 三相 PWM 输出（下面的输出是反向输出）
        M1_PWM_EN_V      // 三相 PWM 输出
        M1_PWM_EN_W      // 三相 PWM 输出
        ```

        ![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/2020-09-30_17-20-52.png)

2. cubeIDE 修改步骤

    **step1:** 配置 TIM8
      ![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/2020-09-30_17-35-45.png)

    **step2:** 配置 定时器引脚（不用做）
      ![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/2020-09-30_17-37-39.png)

    **step3:** 配置中断优先级（不用做）
      ![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/2020-09-30_17-39-03.png)

    **step4:** 配置 ADC 的触发源
      ![看不到图片是科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/2020-09-30_17-39-58.png)

    **step5:** 关闭 TIM1

      就是全部 disable 就好了。

3. 软件上的 修改步骤

    **step1:** 修改 TIM8 初始化顺序 和 TIM8 优先级

    ```c
    // main.c
    // step1: 顺序
    MX_TIM8_Init();  // 放到 MX_MotorControl_Init(); 前
    /*like:
    ...
    MX_DAC1_Init();
    MX_TIM8_Init();
    MX_USART2_UART_Init();
    MX_MotorControl_Init();
    ...
    */

    // step2: 优先级（所以那个软件上配的没用。。。）
    // 找到 static void MX_NVIC_Init(void)；并添加 如下

      /* TIM8_BRK_IRQn interrupt configuration */
      HAL_NVIC_SetPriority(TIM8_BRK_IRQn, 4, 1);
      HAL_NVIC_EnableIRQ(TIM8_BRK_IRQn);
      /* TIM8_UP_IRQn interrupt configuration */
      HAL_NVIC_SetPriority(TIM8_UP_IRQn, 0, 0);
      HAL_NVIC_EnableIRQ(TIM8_UP_IRQn);

    // step3: 删掉一些初始化（EN的引脚要有，没有需补上）
    // 在 MX_GPIO_Init() 删掉以下
    /*Configure GPIO pins : M1_PWM_UH_Pin M1_PWM_VH_Pin M1_PWM_WH_Pin */
    GPIO_InitStruct.Pin = M1_PWM_UH_Pin|M1_PWM_VH_Pin|M1_PWM_WH_Pin;
    GPIO_InitStruct.Mode = GPIO_MODE_AF_PP;
    GPIO_InitStruct.Pull = GPIO_PULLDOWN;
    GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_HIGH;
    GPIO_InitStruct.Alternate = GPIO_AF6_TIM1;
    HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);
  
    /*Configure GPIO pin : M1_OCP_Pin */
    GPIO_InitStruct.Pin = M1_OCP_Pin;
    GPIO_InitStruct.Mode = GPIO_MODE_AF_OD;
    GPIO_InitStruct.Pull = GPIO_PULLUP;
    GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_LOW;
    GPIO_InitStruct.Alternate = GPIO_AF12_TIM1_COMP1;
    HAL_GPIO_Init(M1_OCP_GPIO_Port, &GPIO_InitStruct);
    ```

    **step2:** 修改 PWM 输出引脚

    ```c
    // main.h
    #define M1_PWM_UH_Pin GPIO_PIN_8
    #define M1_PWM_UH_GPIO_Port GPIOA
    #define M1_PWM_VH_Pin GPIO_PIN_9
    #define M1_PWM_VH_GPIO_Port GPIOA
    #define M1_PWM_WH_Pin GPIO_PIN_10
    #define M1_PWM_WH_GPIO_Port GPIOA
    #define M1_OCP_Pin GPIO_PIN_11
    #define M1_OCP_GPIO_Port GPIOA

    // 改如下

    #define M1_PWM_UH_Pin GPIO_PIN_6
    #define M1_PWM_UH_GPIO_Port GPIOC
    #define M1_PWM_VH_Pin GPIO_PIN_7
    #define M1_PWM_VH_GPIO_Port GPIOC
    #define M1_PWM_WH_Pin GPIO_PIN_8
    #define M1_PWM_WH_GPIO_Port GPIOC
    #define M1_OCP_Pin GPIO_PIN_9
    #define M1_OCP_GPIO_Port GPIOC
    ```

    **step3:** 修改 电机 参数

    ```c
    // mc_parameters.c
    // 第一处：找到 R3_2_ParamsM1 里的
    .TIMx               = TIM1,  // 改为 TIM8

    // 第二处：找到 R3_2_ParamsM1 里的 .ADCConfig1 和 .ADCConfig2
    // 把 含有 LL_ADC_INJ_TRIG_EXT_TIM1_TRGO
    // 改为 LL_ADC_INJ_TRIG_EXT_TIM8_TRGO
    ```

    **step4:** 屏蔽生成的 TIM8 中断（只有在 MX 上配置了 NVIC 才会生成）

    ```c
    // stm32g4xx_it.c
    void TIM8_UP_IRQHandler(void)  // 注释掉
    void TIM8_BRK_IRQHandler(void) // 注释掉
    ```

    **step5:** 把原本的 TIM1 中断换成 TIM8 中断

    ```c
    // 第一处：stm32g4xx_mc_it.c
    /* 把 TIMx_UP_M1_IRQHandler() 和 TIMx_BRK_M1_IRQHandler()
    关于 TIM1 的都改为 TIM8
    */

    // 第二处：parameters_conversion_g4xx.h （通过 stm32g4xx_mc_it.c 的 void TIMx_UP_M1_IRQHandler(void) 跳转）
    #define TIMx_UP_M1_IRQHandler TIM1_UP_TIM16_IRQHandler
    #define TIMx_BRK_M1_IRQHandler TIM1_BRK_TIM15_IRQHandler
    // 改为如下
    #define TIMx_UP_M1_IRQHandler TIM8_UP_IRQHandler
    #define TIMx_BRK_M1_IRQHandler TIM8_BRK_IRQHandler
    ```

4. 找三个 IO 配置成 output，然后在 `main.h` 修改（如果在 mx 中关闭原本的输出，`main.h` 会删掉 关于 `EN` 的IO 口，需补上。mc_lock_pin() 还要添加下）

5. 温度的 ADC：`mc_config.c` 在 `TempSensorParamsM1` 配置 ADC 通道（需要根据原本的配置来配置）
6. 总线电压 的 ADC `mc_config.c` 在 `RealBusVoltageSensorParamsM1` 配置
7. 相电流的 ADC 在 `mc_parameters.c` 中 `ADCConfig1` 配置
