## 1. 在`~/.vimrc`下的配置

```bash
set nocompatible " 去除vi一致性，required
filetype off " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" -------------MY Plugins---------------
" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)    

Plugin 'Valloric/YouCompleteMe'
"代码折叠插件
Plugin 'tmhedberg/SimpylFold'

" -----test-----
"python语法检测
Plugin 'scrooloose/syntastic'
"添加PEP8代码风格检查
Plugin 'nvie/vim-flake8'
" -----test END-----

" All of your Plugins must be added before the following line
" -------------MY Plugins END---------------
call vundle#end() " required
filetype plugin indent on " required
             
" YCM   
" ycm 指定 ycm_extra_conf.py
let g:ycm_global_ycm_extra_conf= '~/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
" 允许自动加载.ycm_extra_conf.py，不再提示
let g:ycm_confirm_extra_conf=0
" -------------补全-------------
" 语法关键字补全
let g:ycm_seed_identifiers_with_syntax=1	
" 在注释输入中也能补全
let g:ycm_complete_in_comments=1
"在字符串输入中也能补全
let g:ycm_complete_in_strings=1
"注释和字符串中的文字也会被收入补全
let g:ycm_collect_identifiers_from_comments_and_strings=0
" 开启tags补全引擎
let g:ycm_collect_identifiers_from_tags_files=1
" 键入第一个字符时就开始列出匹配项
let g:ycm_min_num_of_chars_for_completion=1
" 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_cache_omnifunc=0	
" 在接受补全后不分裂出一个窗口显示接受的项
" set completeopt-=preview
" 让补全行为与一般的IDE一致 =longest,menu,preview
set completeopt=longest,menu
" ------------补全 END-----------------
" 输入完成后关闭预览窗口
let g:ycm_autoclose_preview_window_after_completion=1
"let g:ycm_autoclose_preview_window_after_insertion=1
" 在折叠文本中启用文档字符串预览,不知道有啥用
let g:SimpylFold_docstring_preview=1
" YCM相关快捷键，分别是gl, gf, gg
let mapleader="g"
nnoremap <leader>l :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>f :YcmCompleter GoToDefinition<CR>
nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

" -------test------------
"python代码缩进PEP8风格
au BufNewFile,BufRead *.py,*.pyw set tabstop=4
au BufNewFile,BufRead *.py,*.pyw set softtabstop=4
au BufNewFile,BufRead *.py,*.pyw set shiftwidth=4
au BufNewFile,BufRead *.py,*.pyw set textwidth=79
au BufNewFile,BufRead *.py,*.pyw set expandtab
au BufNewFile,BufRead *.py,*.pyw set autoindent
au BufNewFile,BufRead *.py,*.pyw set fileformat=unix
let python_highlight_all=1
syntax on
"auto add pyhton header --start 自动添加py文件头 
autocmd BufNewFile *.py 0r ~/.vim/vim_template/vim_python_header
autocmd BufNewFile *.py ks|call FileName()|'s
autocmd BufNewFile *.py ks|call CreatedTime()|'s

" -------test END-----------


" VIM
" -------------test-----------
"highlight syntax
syntax on
" highlight current line
" set cursorline
" auto indent
set autoindent 
" match () or []
set showmatch  
" auto indent for c?
set smartindent 
" -------------test END-----------

" Enable folding
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap <space> za
" split navigations
nnoremap <C-K> <C-W><C-J>
nnoremap <C-J> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set tabstop=4
set softtabstop=4
set shiftwidth=4
" 感觉下两句没多大用
set splitbelow
set splitright
"设置utf-8编码
set encoding=utf-8
set nu

```

## 2. 在 .ycm_extra_conf.py 中的配置
`vim ~/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py`

```bash
# These are the compilation flags that will be used in case there's no
# compilation database set (by default, one is not set).
# CHANGE THIS LIST OF FLAGS. YES, THIS IS THE DROID YOU HAVE BEEN LOOKING FOR.
flags = [
# ...
# ---------my include--------
'-isystem',
'/usr/local/include',
'-isystem',
'/usr/include/c++/7',
'-isystem',
'/usr/include/c++/7.4.0',
'-isystem',
'/usr/include/x86_64-linux-gnu/c++/7',
'-isystem',
'/usr/include/x86_64-linux-gnu/c++/7.4.0',
'-isystem',
'/home/hzh/opencv/mybuild/myInstall/include/opencv4',
'-isystem',
'/home/hzh/opencv/mybuild/myInstall/include/opencv4/opencv2/'
'-isystem',
'/usr/lib/python3/dist-packages/numpy',

]
```

自行添加的库需要用 '-isystem' 标识。比如说我想要补充 C++ 的库 iostream ，我可以先 locate iostream ，然后再添加

添加 opencv 的头文件

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190503004437.png)

效果：

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190503005012.png)

## 3. 解惑

### 3.1 输入完成后自动关闭预览窗口（关闭下图中红框的预览窗口）

```bash
# 这个是当你退出 insert 模式才会自动关闭
let g:ycm_autoclose_preview_window_after_insertion = 1
# 这个是你一输入完就关闭，如果第二条 set = 1，第一条无效
let g:ycm_autoclose_preview_window_after_completion = 1
```

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190502232501.png)

### 3.2 在折叠文本中启用文档字符串预览

```bash
let g:SimpylFold_docstring_preview=1
```

这个我也不太清楚。置 0 置 1 我感觉都没多大区别

### 3.3 跳转定义

```bash
" YCM相关快捷键，分别是gl, gf, gg
let mapleader="g"
nnoremap <leader>l :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>f :YcmCompleter GoToDefinition<CR>
nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
" ==========================================================================================
" 有的教程会像下面这样写，但是你会发现跳转不了
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
```

根据下图的说法，<leader>会被 “mapleader” 代替，而这个 “mapleader” 默认是 `\`

所以先把 “mapleader” 替换成 “g”，然后在修改<leader>后接的字母就好。

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190502234652.png)

### 3.4  代码折叠

```bash
" Enable folding
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap <space> za
```

> 第一个命令，`set foldmethod=ident` 会根据每行的缩进开启折叠。
>
> 但是这样做会出现超过你所希望的折叠数目。
>
> 但是你必须手动输入 `za` 来折叠（和取消折叠）。使用空格键会是更好的选择。
>
> 于是就有第三条命令

### 3.5  让补全行为与一般的IDE一致  

```bash
" 让补全行为与一般的IDE一致  
set completeopt=longest,menu
```

这个貌似是 按下 【CTRL + P】它就会补全，longest，就会让你可以选。

![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190503095356.png)

## 参考

1. [安装插件 YouCompleteMe 成功却无法自动补全 C++ 的解决办法](https://www.cnblogs.com/Bw98blogs/p/8455253.html)
2. [自动关闭预览窗口](<https://vi.stackexchange.com/questions/4056/is-there-an-easy-way-to-close-a-scratch-buffer-preview-window/4057>)
3. [跳转定义](<https://stackoverflow.com/questions/29573748/a-confusion-about-shortcut-key-of-youcompleteme-for-vim>)
4. [vim 相关](<https://segmentfault.com/a/1190000003962806>)
5. [vim 自动补全的问题](<https://www.douban.com/group/topic/26633511/>)
6. [YouCompleteMe 实现 vim 自动补全](https://blog.csdn.net/lyh__521/article/details/46295775) ---- 这个有提到怎么关闭语法检测

