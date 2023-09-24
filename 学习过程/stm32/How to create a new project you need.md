# How to create a new project you need?

---

## 步骤

* **step1:** 勾选上 ① `Device` 的 `Startup` 和 ② `Device --> StdPeriph Drivers` 的 `GPIO`，然后点击下方的提示，即可构建基本的框架。（需要其他功能时，勾选相应外设功能即可）

    ![看不到图片时科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190516160543.png)

* **step2:** 新建一个 `main.c`，写个 main 函数。（记得把文件添加到工程！和在 `include Paths` 下添加头文件的路径）
* **step3:** 在 `Options for target 'xxx'` 的 `Target` 选项卡下 把编译器选择 `V5`。（此时编译没问题）
* **step4:** 把正点原子的 `system` 文件夹添加进去（1. 文件添加到工程；2. 添加头文件路径）
* **step5:** `Device --> StdPeriph Drivers` 把相应外设勾上（usart）。（此时编译没问题）
* **step6:** `STM32F10X_HD,USE_STDPERIPH_DRIVER`

    ![看不到图片时科学问题](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190516160616.png)
