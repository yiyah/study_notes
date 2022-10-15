# static 和 const 修饰的变量和函数

[TOC]

## static

1. 普通使用

    * 在使用 `static` 关键字修饰变量时，我们称此变量为**静态变量**。
    * 示例

    ```cpp
    static int a = 9;  // 生命期 到 程序结束
    ```

2. 在类中使用

    2.1 静态成员变量

    * 使用 `static` 关键字来把 类成员变量 定义为静态的。成为**静态成员变量**。
    * 当我们声明 类的成员变量 为静态时，这意味着无论创建多少个类的对象，静态成员变量 都只有一个副本。
    * 静态成员变量 在类的所有对象中是共享的。
    * 如果不存在其他的初始化语句，在创建第一个对象时，所有的 静态成员变量 都会被初始化为 **零**。
    * 我们不能把 静态成员变量 的初始化放置在 类的定义 中，但是可以在 类的外部 通过使用 范围解析运算符 `::` 来重新声明 静态变量 从而对它进行初始化，

    ```cpp
    #include <iostream>
    using namespace std;

    class Box
    {
    public:
        static int objectCount;  // 不能再类定义中 初始化！
          // 构造函数定义
        Box(double l=2.0, double b=2.0, double h=2.0)
        {
            length = l;
            breadth = b;
            height = h;
            // 每次创建对象时增加 1
            objectCount++;
        }
        double Volume()
        {
            return length * breadth * height;
        }
    private:
        double length;     // 长度
        double breadth;    // 宽度
        double height;     // 高度
    };

    // 初始化类 Box 的静态成员
    int Box::objectCount = 0;

    int main(void)
    {
        Box Box1(3.3, 1.2, 1.5);    // 声明 box1
        Box Box2(8.5, 6.0, 2.0);    // 声明 box2

        // 输出对象的总数
        cout << "Total objects: " << Box::objectCount << endl;  // Total objects: 2

        return 0;
    }
    ```

    2.2 静态成员函数

    * 如果把函数成员声明为静态的，就可以把函数与类的任何特定对象独立开来。
    * 静态成员函数即使在类对象不存在的情况下也能被调用，静态函数只要使用类名加范围解析运算符 `::` 就可以访问。
    * 静态成员函数 只能访问 静态成员数据、其他静态成员函数和类外部的其他函数。
    * 静态成员函数有一个类范围，他们不能访问类的 this 指针。您可以使用静态成员函数来判断类的某些对象是否已被创建。
    * 静态成员函数与普通成员函数的区别：

        ① 静态成员函数没有 this 指针，只能访问静态成员（包括静态成员变量和静态成员函数）。
        ② 普通成员函数有 this 指针，可以访问类中的任意成员；而静态成员函数没有 this 指针。

    * 示例

    ```cpp
    #include <iostream>
    using namespace std;

    class Box
    {
    public:
        static int objectCount;
        // 构造函数定义
        Box(double l=2.0, double b=2.0, double h=2.0)
        {
            length = l;
            breadth = b;
            height = h;
            // 每次创建对象时增加 1
            objectCount++;
        }
        double Volume()
        {
            return length * breadth * height;
        }
        static int getCount()
        {
            // Volume();        // 不可以 访问 非静态成员函数
            // length = 2;      // 不可以 访问 非静态成员变量
            return objectCount; // 可以  访问 静态成员变量
        }
    private:
        double length;     // 长度
        double breadth;    // 宽度
        double height;     // 高度
    };
    ```

## const

1. 普通用法

   * 作用：采用const修饰变量，功能是对变量声明为只读特性，并保护变量值以防被修改
   * 定义变量的同时，必须初始化。
   * 示例

    ```cpp
    const int i = 9;  // 只读；修改会报错！
    ```

2. 在类中使用

    2.1 const 成员变量（常成员变量）

    * const 成员变量的用法和普通 const 变量的用法相似，只需要在声明时加上 const 关键字。
    * 初始化 const 成员变量只有一种方法，就是通过 **构造函数的初始化列表**

    * 示例

    ```cpp
    class CDog
    {
    private:
        const char sort = 'd';              // 常成员变量，不能被修改！
    public:
        CDog();
        CDog(char s):sort(s){}              // 构造函数，初始化列表
        // void setSort(char s){sort = s;}  // 注意！不能修改！
        char getSort(){return sort;}
    };

    CDog::CDog(){}

    int main()
    {
        CDog d;
        cout << d.getSort() << endl;

        CDog dd('a');  // 通过 初始化列表 来 初始化 常成员变量
        cout << dd.getSort() << endl;
        return 0;
    }
    ```

    2.2 const 成员函数（常成员函数）

    * const 成员函数可以使用类中的所有成员变量，但是不能修改它们的值，这种措施主要还是为了**保护数据**而设置的。
    * 定义格式：`void fun() const { }`
    * 需要强调的是，必须在成员函数的声明和定义处同时加上 const 关键字。`void fun() const` 和 `void fun()` 是两个不同的函数原型！
    * 示例

    ```cpp
    class CDog
    {
    private:
        char sort = 'd';    // 普通成员变量
    public:
        CDog();
        // char getSort() const {sort = 'a'; return sort;}  // 试图修改成员变量，出错！
    };
    ```

3. 区分一下 const 的位置：（函数）

* 函数开头的 const 用来修饰函数的返回值，表示返回值是 const 类型，也就是不能被修改，例如`const char * getname()`。
* 函数头部的结尾加上 const 表示常成员函数，这种函数只能读取成员变量的值，而不能修改成员变量的值，例如 `char * getname() const`。

## 总结

1. 静态成员变量在类中仅仅是声明，没有定义，所以要在类的外面定义，实际上是给静态成员变量分配内存。如果不加定义就会报错，初始化是赋一个初始值，而定义是分配内存。
2. 静态成员函数 只能访问 静态成员数据、其他静态成员函数和类外部的其他函数。
3. 常成员变量 的初始化 只能通过 从初始化列表。
4. 常成员函数可以使用类中的所有成员变量，但是不能修改它们的值。

## 参考

1. [static变量及其作用，C语言static变量详解](http://c.biancheng.net/view/301.html)
2. [C++ 类的静态成员](https://www.runoob.com/cplusplus/cpp-static-members.html)
