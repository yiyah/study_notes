# CListCtrl 篇

[toc]



## 一、关联的控件

*   List Control


## 二、使用

### 2.1 关联 List Control 控件

#### 方法一：该方法返回的指针是临时性的，不能长期保存。

```c++
CListCtrl *pList = (CListCtrl *)GetDLgItem(IDC_LIST);
```

#### 方法二：该方法可以长期使用。（ListCtrl 控件关联到成员变量中以方便下次调用）

```c++
// 声明里
xxx
{
    ...
public:
    CListCtrl m_list;
    ...
    
}
// 实现里（一般在对话框初始化函数里）
BOOL xxx::OnInitDialog() 
{
	CDialog::OnInitDialog();
	m_list.SubclassDlgItem(IDC_LIST, this);
	m_list.InsertColumn(0, "number", LVCFMT_CENTER, 80);
	return TRUE;  
}
```

##### 方法汇总：(长时间保存变量)

```C++
a) CWnd::Attach: 将一个句柄嫁接到一个个 CWnd 类型变量中;// 与（b）同时使用
b) CWnd::Detach: 移除嫁接到 CWnd 变量中的句柄;// 与（a）同时使用
c) CWnd::SubclassWindow: 子类化一个窗口句柄到 CWnd 派生类变量中;
（不但要把句柄关联进入CWnd对象中,而且还要将窗口的消息映射到 CWnd 的子类中）
d) CWnd::UnsubclassWindow: 解除子类化;
e）CWnd::SubclassDlgItem: 根据窗口ID子类化对应的窗口。
```

### 2.2 操作控件

```c++
CListCtrl *pList = (CListCtrl *)GetDLgItem(IDC_LIST);
// 初始化常做操作
pList ->InsertColumn(0, "numbers", 0, 120);// 插入到第0列，名字，显示的格式（居左），宽度
pList ->InsertColumn(1, "name", 0, 120);//
pList ->SetExtendedStyle(LVS_EX_FULLROWSELECT | LVS_EX_GRIDLINES);// 设置拓展风格（这个和Resources View 里的拓展属性的风格是不一样的！），参数还有其他，自查

// 运行中常做操作
pList ->GetItemCount();// 获取列表有多少項
CString str;
str = pList ->GetItemText(0,1);// 获取列表的第0項第1列的字符串
pList ->InsertItem(2,str);// 在第 2 行位置，插入一项 str
pList ->SetItemText(2,1,str);// 在第 2 行，第 1 列，插入 str（想要对某一列设置字符串，先要插入一项！）
pList ->DeleteItem(nSel);// 删除第 nSel 个 Item；

// 获取选中哪一项
int nSel = pList ->GetSelectionMark(); //从0选择选择标记，当选择一行后就会一直选中这一行。不好用
					                 //以选中项的虚线焦点选中标志
int nCount = pList ->GetSelectedCount();// 获取选中了多少项

```



## 三、相似功能

### 3.1 获取长时间使用的 CListctrl 指针

```c++
// 声明里
xxx
{
    ...
public:
    CListCtrl m_list;
    ...
    
}
// 实现里（一般在对话框初始化函数里）
BOOL xxx::OnInitDialog() 
{
	// ...
    // 不需要开发者获取控件关联的窗口句柄。
    // 不需要开发者释放控件句柄
	m_list.SubclassDlgItem(IDC_LIST, this);// 最简单，退出时不用做任何操作
	return TRUE;  
}
// ==================等价于=========================
BOOL xxx::OnInitDialog() 
{
	// ...
    HWND hWnd = ::GetDlgItem(m_hWnd, IDC_LIST);// 参数1：父窗口句柄；参数2：控件 ID
	m_list.SubclassDlgItem(hWnd);
	return TRUE;  
}
// ==================等价于=========================
BOOL xxx::OnInitDialog() 
{
	// ...
	HWND hWnd = ::GetDlgItem(m_hWnd, IDC_LIST);// 参数1：父窗口句柄；参数2：控件 ID
    m_list.Attach(hWnd);// 在程序退出的时候必须手动Detach();
	return TRUE;  
}
// ==================等价于=========================
BOOL xxx::OnInitDialog() 
{
	// ...
	HWND hWnd = ::GetDlgItem(m_hWnd, IDC_LIST);// 参数1：父窗口指针；参数2：控件 ID
    m_list.Attach(hWnd);// 在程序退出的时候必须手动Detach();
	return TRUE;  
}
// ==================等价于=========================
BOOL xxx::OnInitDialog() 
{
	// ...
	HWND hList;
    GetDlgItem(IDC_LIST, &hList);// 参数1：控件 ID；参数2：返回的句柄
    m_list.Attach(hList);// 在程序退出的时候必须手动Detach();
	return TRUE;  
}
// 程序退出时
void xxx::OnDestroy()
{
    CDialog::OnDestroy();
    m_list.Detach();// 注意！一定要释放！
    
}

// 上面是用 Attach() 和 Dettach() 关联控件
// 下面的等价用 SubClassWindow() 和 UnsubclassWindow()
// ==================等价于=========================
BOOL xxx::OnInitDialog() 
{
	// ...
	HWND hList;
    GetDlgItem(IDC_LIST, &hList);// 参数1：控件 ID；参数2：返回的句柄
    m_list.SubClassWindow(hList);// 在程序退出的时候不用必须手动 UnsubclassWindow();
	return TRUE;  
}
// 程序退出时
void xxx::OnDestroy()
{
    CDialog::OnDestroy();
    m_list.UnsubclassWindow();// 在程序退出的时候可以手动 UnsubclassWindow();
    
}
```



### 3.2 获取当前选择的是哪一项？

```c++
int nSel = pList ->GetSelectionMark();
// 等价于（推荐下面的）
POSITION pos = pList ->GetFirstSelectedItemPosition();
int nSel = pList ->GetNextSelectedItem(pos);//执行完清空 pos 
```



