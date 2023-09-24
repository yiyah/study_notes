# vim的环境配置之插件Vundle的安装与使用

---

[TOC]

## 1. 准备环境
先确保已经安装了 vim 和 git
## 2. 下载 Vundle
```cmd
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
## 3. 配置Vundle
### 3.1 创建 ~/.vimrc 文件，以通知 Vim 使用新的插件管理器。安装、更新、配置和移除插件需要这个文件。
```
vim ~/.vimrc
```
### 3.2 加入以下若干行（这些东西必须放在最最最前面，也就是第一行开始）
```basic
set nocompatible " required
filetype off " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)



" All of your Plugins must be added before the following line

call vundle#end() " required
filetype plugin indent on " required
```

```
set nocompatible " be iMproved, required
filetype off " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}
" All of your Plugins must be added before the following line
call vundle#end() " required
filetype plugin indent on " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList - lists configured plugins
" :PluginInstall - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
```
### 3.3 打开 vim
```
vim
```
输入以下以下命令就会安装插件
```
:PluginInstall
```
### 3.4 安装后，输入以下命令删除高速缓存区缓存并关闭窗口
```
:bdelete
```

## 4. 如何安装插件呢？
**一旦安装插件后都要 `:bdelete` 来删除Vundle缓存**
### 4.1 方法一
在 ```~/.vimrc``` 加上 ```Plugin '你想要的插件名字'```
然后在 vim 中输入```PluginInstall``` 就安装完毕

### 4.2 方法二
#### 4.21 利用 ```PluginSearch vim-dasm``` 搜索你想要的插件名字
![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190517012808.png)

#### 4.22弹出下面的界面，然后按 `i` 安装
![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190517012826.png)
#### 4.23 一旦安装成功，使用下列命令 `:bdelete` 删除 Vundle 缓存：
#### 4.24 现在，插件已经安装完成。为了让插件正确的自动加载，我们需要在 `.vimrc` 文件中添加安装好的插件名。
```
Plugin 'vim-dasm'
```
## 5. 如何卸载插件呢？
### 5.1 首先，列出所有已安装的插件
```
PluginList
```
### 5.2 然后在想要的卸载的插件的行上按下 ```SHIFT+D```（其实我觉得有没有这一步都可以）
![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190517013834.png)

### 5.3 在 ```~/.vimrc``` 删掉 ```Plugin '你想要的插件名字'```所在的文件行
### 5.4 然后在 vim 中输入```:PluginClean``` 就卸载完毕
### 5.5 把安装的插件List出来```PluginList```，看一看是否卸载了。

## 6. 更新插件 `PluginUpdate`
## 7. 重新安装所有插件 `PluginInstall!`
## 8. 卸载插件 `PluginClean`
## 9. 查询帮助文档，获取更多细节 `:h vundle`
## 10. 搜索插件 `PluginSearch`

## 参考：
1. [技术 | 如何在 Linux 上使用 Vundle 管理 Vim 插件](https://linux.cn/article-9416-1.html)
2. [vim 中的杀手级插件: vundle (vim 插件管理器) ](https://blog.csdn.net/freeking101/article/details/78539750)