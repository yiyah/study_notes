# 如何设置 MessageBox 的 name

即

![20200306002648698](https://raw.githubusercontent.com/yiyah/Picture_Material/master/2020-03-06_00-28-13.png)

[toc]



## 前提！！！

*   首先，得明白，这个是在哪里影响到的？答案：是在 CWinApp 基类里的 m_pszAppName 成员变量！

    <img src="https://raw.githubusercontent.com/yiyah/Picture_Material/master/Snipaste_2020-03-06_00-43-19.png" style="zoom: 67%;" />



## 法一：在构造函数里赋值

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/sp20200306_003908_943.png)

## 法二：新建 String Table 里添加 AFX_IDS_APP_TITLE 和对应内容

like:

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/Snipaste_2020-03-06_01-20-56.png)

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/Snipaste_2020-03-06_01-21-46.png)




## 法三：如果不在构造函数里初始化，也没有设置 String Table 那么就会以执行文件名作为APP名

## 总结：

1.  顺序：构造函数 > String Table > 执行文件名



