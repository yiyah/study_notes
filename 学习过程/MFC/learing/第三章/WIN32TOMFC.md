# 创建 WIN32 application 然后转为 MFC

[TOC]


## 一、创建一个 WIN32 的 project

## 二、添加对话框资源

## 三、环境配置

1.  在  “stdafx.h”  文件里 把 `#include <windows.h>` 屏蔽
2.  在  “stdafx.h”  文件添加 `#include <afxwin.h>`
3.  在 “stdafx.h”  文件添加 `#include "resource.h"`
4.  点击 project -> settings -> use MFC in a stastic Library


## 四、建立一个 CWinApp 的派生类

```c++
//1. 在 WinMain 函数存在的那个 cpp 文件里添加，并且屏蔽掉 WinMain 函数
class CMyApp:public CWinApp
{
    BOOL InitInstance()//程序入口地址
	{
		//AfxMessageBox("123");
        CDialog dlg(IDD_MAIN_DLG);
        dlg.DoModal();
		return TRUE;
	}
};
//2. 用派生类去定义一个 object
CMyApp theApp;
```

---

以上是没有类向导的

下面建立类向导

---

## 五、菜单栏 view --- classWizard --- ok 下去，直到看到可以添加类 --- 添加一个基于 CDialog 类的派生类 CMainDlg

like:

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20200303020629.png)

## 六、修改源程序

```c++
//1.添加头文件到函数入口所在的文件
#include "MainDlg.h"
//2.修改程序
CDialog dlg(IDD_MAIN_DLG); // 修改为以下
CMainDlg dlg;
```

## 七、编译

会在新建派生类的.cpp文件出现一个不能添加 头文件的错误，删掉它，重新编译即可。

## 八、至此完成！