

## 一、下面对于 class 和 object 的讲解应该是通用的

用 class 去定义 object 

　　类是对对象的抽象。类是一种抽象的数据类型。它们的关系是，对象是类的实例，类是对象的模板。

对象是通过new className 产生的，用来调用类的方法;类的构造方法 



## 类的意义:

1.类是把属性和方法进行封装，同时对类的属性和方法进行访问控制。

2.类是由我们根据客观事物抽象而成，形成一类事物，然后用类去定义对象，形成这类事物的具体个体。

3.类是一个数据类型，类是抽象的，而对象是一个具体的变量，是占用内存空间的。

## 类的访问控制

　　在C++中可以对类的属性和方法定义访问级别，public修饰的属性和方法，可以在类的内部访问，也可以在类的外部进行访问。private修饰的属性和方法，只能在类的内部进行访问。



行为:所有对象公有操作即成员函数（通常习惯为public属性）属性：所有对象公有特性即数据成员（通常习惯为protected属性）

## 二、对于 python 中的 object 

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190510233448.png)



## 参考

1.  (C++ 类和对象概念以及创建类和对象)[https://jingyan.baidu.com/article/948f5924f30040d80ff5f9ca.html]

2.  (对于 python 中的 object )[https://www.liaoxuefeng.com/wiki/1016959663602400/1017496031185408]