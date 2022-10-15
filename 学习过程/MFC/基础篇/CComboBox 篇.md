# CComboBox 篇

---

一般，style （1）选择 DropList：只有下拉。不能编辑。（2）取消排序

---

[toc]

## 一、关联的控件

*   Combo Box

## 二、使用

### 2.1 获取控件指针

```c++
CComboBox *pComb = (CComboBox *)GetDlgItem(IDC_COMB);
```

### 2.2 操作控件

```C++
CComboBox *pComb = (CComboBox *)GetDlgItem(IDC_COMB);
// 初始化常做操作
pComb ->AddString("hello"); // 添加数据
pComb ->AddString("world"); // 添加数据
pComb ->SetCurSel(0); // 默认显示哪个数据

// 运行
int nSel = pComb ->GetCurSel();// 获取当前选中的項
CString str;
pComb ->GetLBText(nSel, str);//  获取第 nSel 个的字符串到 str。
```



## 三、相似功能

```c++
// 获取当前 CombBox 显示的文字。
CComboBox *pComb = (CComboBox *)GetDlgItem(IDC_COMB);
pComb ->GetWindowText(str);
// ========等价于======
GetDlgItemText(IDC_COMB, str);
// ========等价于======
pComb ->GetWindowText(str);


```

