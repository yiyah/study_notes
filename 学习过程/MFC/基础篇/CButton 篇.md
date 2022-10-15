# CButton Class

 [toc]

## 一、关联的控件

*   Group Box

*   Button

*   Check Box

*   Radio button 

## 二、使用

### 2.1 获取控件指针

```c++
CButton *pButton = (CButton*)GetDlgItem(IDC_BUTTON);
pButton ->SetIcon(m_hIcon);//要打开 icon   属性
pButton ->SetBitmap(m_bmp);//要打开 bitmap 属性
```

