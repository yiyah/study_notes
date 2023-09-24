# vim的使用

---
[TOC]

```shell
# 常用命令
i a o
0 $ fx G # 行首 行尾 下一个x 文件末尾
ngg nyy ndd # 跳到n行 复制n行 删除n行
p u x # 粘贴 撤销 删除单个字符
```

## 1. vim的两种模式

- 命令模式:*按a或i切换到输入模式*
  
  - i: 光标在字符前
  - a: 光标在字符后
  - 0: 光标在下一行，新起一行

- 输入模式:*按ESC切换到命令模式*

**在命令模式下如何保存：**

```shell
# 常用命令
i # 切换到输入模式，以输入字符
x # 删除当前光标所在处的字符。
: # 切换到底线命令模式，以在最底一行输入命令
# 例如：
:wq # 保存并且退出 或者 按住  shift ，连续按两次大写的  ZZ
:w  # 只保存不推出
:q  # 不保存退出  进来看了一下没改退出
:q!  # 不保存强制退出
:wq!  # 保存并强制退出
```

## 2. vim的高级使用

### 查找【/xxx】

在命令模式下，输入`/xxx`就可以查找到xxx；输入 `?xxx` 就可以向上查找。
找到后可以按 `n` 或 `N` 继续向下或向上查找

### 快速切换行【:num】

在命令模式下，输入`:num`就可以快速切换到num行

### 快速跳转行 ngg

一般模式下，输入 `ngg`（n是数字，代表第几行）

`G` 跳到文件结尾

### 快速定位某一列

`0` 光标移至当前行行首
`$` 光标移至当前行行尾
`fx` 搜索当前行中下一个出现字母 x 的地方

### 设置显示行号【:set nu】【:set nonu】

在命令模式下，输入`:set nu`，就可以显示行号
 <font color='Red'>注：</font>设置不显示行号，命令模式输入`:set nonu`
设置永久显示行号，需要修改vi的配置文件。打开vi的配置文件~/.vimrc，在其中输入`set nu`即可。

### 行删除【ndd】

命令模式下，先将光标移动到要删除的行，然后输入dd
如果要删除连续多行，譬如要删除连续的3行，使用3dd

### 行复制粘贴【nyy】【p】

* 复制：命令模式下，`nyy` （yy复制当前行，nyy复制当前行及其后的n-1行）
* 粘贴：命令模式下，p

细节，复制时要把光标放在多行的第一行，粘贴时实际粘贴到当前光标所在行的下一行。

### 【r】 替换单字母

### 替换字符串

`%s/string1/string2/gc` 加上后面的`c`就是一个个让你确认是不是要替换，去掉的话直接全部替换。

s:substitute 替换
g:global
c:confirm

### 翻页【Ctrl+｛f b u d｝】

* Ctrl+f：向下翻一页
* Ctrl+b：向上翻一页
* Ctrl+u：向上翻半页
* Ctrl+d：向下翻半页

* ## 恢复【U】
* ## 重做 【Ctrl + r】
* ## 跳到最后一行【G】
* ## 跳到第n行【nG】
* ## 移动光标【h j k l】

    * h：←
    * j： ↓
    * k：↑
    * l：→

* ## Visual Block（可视区块）
按下【Ctrl+v】进入这个功能
  * v：字符选择
  * V：行选择
  * y：复制选中的地方
  * d：删除选中的地方
  * p：粘贴复制的区块

## 3. 多文件编辑

 * 打开多个文件：
    *   法一(vim 还没有启动的时候)：vim file1 file2
    *   法二（vim启动了）：：open file3
 * `:n` 编辑下一个文件
 * `:N` 编辑上一个文件
 * `:files` 列出目前这个vim开启的所有文件

## 4. 多窗口功能
 * `:sp[filename]` 打开一个新窗口，没有filename的话表示两个窗口为同一个文件内容
 * `ctrl + w + j / ↓ ` 光标移到下方窗口
 * `crrl + w + k / ↑ ` 光标移到上方窗口
 * `ctrl + w + q ` 关闭所在窗口，等价于 `:q` `:close`

## 5. vim的关键词补全功能
<table>
    <tr>
        <th><center>组合键</center></th>
        <th><center>补齐的内容</center></th>
    </tr>
    <tr>
        <th><center>[Ctrl] + x -> [Ctrl] + n</center></th>
        <th>通过目前正在编辑的这个【文件的内容文字】作文关键词，予以补齐</th>
    </tr>
        <tr>
        <th><center>[Ctrl] + x -> [Ctrl] + f</center></th>
        <th>以当前目录内的【文件名】作为关键词，予以补齐</th>
    </tr>
    <tr>
        <th><center>[Ctrl] + x -> [Ctrl] + o</center></th>
        <th>以拓展名作为语法补充，以vim内置的关键词，予以补齐</th>
    </tr>
</table>

## vim 的配置

```shell
cp /etc/vim/vimrc ~/.vimrc
# 添加如下
"关闭兼容功能
set nocompatible 
"显示行号
set number
"编辑时 backspace 键设置为2个空格
set backspace=2
"编辑时 tab 键设置为4个空格
set tabstop=4
"设置自动对齐为4个空格
set shiftwidth=4
"搜索时不区分大小写
set ignorecase
"搜索时高亮显示
set hlsearch
```
