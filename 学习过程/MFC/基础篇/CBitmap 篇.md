# CBitmap class

[toc]

## 一、使用

```c++
CBitmap bmp;//可能存在的问题，生命期不够长，需要放在成员变量
bmp.LoadBitmap(IDB_BITMAP);
//Load完之后，其他控件可以直接用了，如：
CButton *pButton = (CButton*)GetDlgItem(IDC_BUTTON);
pButton ->SetBitmap(bmp);
```



