# pwm 输出

---

Creation Date: 2020-09-03

---

[TOC]

## 一、环境

1. 硬件：Pixhawk 2.4.8
2. Ubuntu 1804x64(Vmware)
3. ardupilot 源代码（`master`）

## pwm 输出代码解释

* 本文是在 `ardupilot/libraries/AP_HAL/examples/RCOutput/RCOutput.cpp/` 基础上进行的。
  例程的 PWM 频率是 50 Hz，且只有 `MAIN OUT` 1~8 和 `AUX OUT` 1~4 通道有 PWM 输出。
  把其中一个通道固定输出 `1500` 在示波器上看到对应的占空比是 7.5%，周期是20ms，故推算出脉冲周期是 20ms 对应的数字是 20000。
* 以下是修改频率的方法

    ```c++
    #include <AP_HAL/AP_HAL.h>

    // we need a boardconfig created so that the io processor's enable
    // parameter is available
    #if CONFIG_HAL_BOARD == HAL_BOARD_CHIBIOS
    #include <AP_BoardConfig/AP_BoardConfig.h>
    #include <AP_IOMCU/AP_IOMCU.h>
    AP_BoardConfig BoardConfig;
    #endif

    void setup();
    void loop();

    const AP_HAL::HAL& hal = AP_HAL::get_HAL();

    void setup (void)
    {
        hal.console->printf("Starting AP_HAL::RCOutput test\n");

    #if CONFIG_HAL_BOARD == HAL_BOARD_CHIBIOS
        BoardConfig.init();  // 该函数是会执行的
    #endif
        hal.rcout ->set_freq(0xfff, 100);  // 设置 PWM 频率为 100 Hz。
        // 注意：0xfff 设置了 Main 1~8, AUX 设置了 1~4
        // 0x01 只有 MAIN_OUT 的 1、2 通道设置到
        // 0x08 只有 MAIN_OUT 的 3、4 通道设置到
        // 根据规律，一位十六进制数控制 4 个通道，而每两个通道是一起设置的
        for (uint8_t i = 0; i< 14; i++) {
            hal.rcout->enable_ch(i);  // 这个 enable_ch() 只是 enable 了 AUX 的通道
            // 屏蔽它，MAIN 通道还是可以输出 PWM, AUX 输出不了。
        }
    }

    static uint16_t pwm = 1500;
    static int8_t delta = 1;

    void loop (void)
    {
        hal.rcout->write(0, 1500);

        for (uint8_t i=1; i < 14; i++) {
            hal.rcout->write(i, pwm);
            pwm += delta;
            if (delta > 0 && pwm >= 2000) {
                delta = -1;
                hal.console->printf("decreasing\r\n");
            } else if (delta < 0 && pwm <= 1000) {
                delta = 1;
                hal.console->printf("increasing\r\n");
            }
        }
        hal.scheduler->delay(5);
    }

    AP_HAL_MAIN();
    ```

## 总结

1. `set_freq()` 参数修改的通道最少是两个
