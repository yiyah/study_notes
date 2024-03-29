# MFC 的六大关键技术

---

六大关键技术的目的是为了提高开发效率，开发者只要在局部做简单的修改，即可处理大部分窗口事物。

---

[toc]

## 一、MFC 程序的初始化过程（启动原理）

MFC 架构组成（由 win32 转换成 MFC）

1.  CWinApp 的派生类
2.  必须在全局区定义一个派生类的对象
3.  在CWinApp 派生类内必须要有 InitInstance 虚函数的重写函数

*   今后在 MFC 软件工程就以 APP 类中的 InitInstance 函数作为主函数
*   另外，连接 MFC 的平台使用 Static Library 和 Shared DLL 都可以。

## 二、消息映射

*   无论是 WIn32 的消息处理还是 MFC 的消息映射，都是针对一个窗口的消息，没有窗口就没有消息。
*   在 win32 中通过消息回调函数截获分流消息 uMsg，然后根据传入的参数进行处理。

MFC 如何截获并处理窗口的消息呢？---> 消息映射机制 ！

1.  必须使用类向导（ClassWizard）建立一个窗口类（CWnd）的派生类。（类向导主要是统一管理MFC的派生类）
2.  必须使用派生类来定义对象，用来接受用户的界面操作消息。
    *   一个对话框对应一个派生类
    *   在窗口派生类中，每一种消息都与一个类成员函数关联。
3.  消息映射函数，必须通过类向导（Class Wizard）来建立。

## 三、运行时类型识别（RTTI）

## 四、动态创建

## 五、永久保存

## 六、消息传递

