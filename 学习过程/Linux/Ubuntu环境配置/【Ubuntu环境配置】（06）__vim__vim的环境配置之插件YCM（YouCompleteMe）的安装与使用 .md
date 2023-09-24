# vim的环境配置之插件YCM（YouCompleteMe）的安装与使用

---

[TOC]

## 1. 准备环境
### 1.1 确保安装 vim 版本至少是7.4.273，并且支持 python2 脚本；
### 1.2 操作系统字符编码必须设置为 UTF-8
查询语系命令：`locale` 
### 1.3 安装类 cmake  `sudo apt-get install cmake`
### 1.4 确保 python 头文件已安装：`sudo apt-get install python-dev`

## 2. 下载最新版的 libclang。
Clang 是一个开源编译器，能够编译 C/C++/Objective-C/Objective-C++。Clang 提供的 libclang 库是用于驱动 YCM 对这些语言的语义补全支持。YCM 需要版本至少为 3.6 的 libclang，但是理论上 3.2 + 版本也行。也可以使用系统 libclang，如果确定是 3.3 版本或者更高。
```sudo apt-get install libclang-dev```

## 3、编译 YCM 需要的 ycm_support_libs 库。
YCM 的 C++ 引擎通过这些库来获取更快的补全速度。需要 cmake，如果未安装，安装之：
```sudo apt-get install build-essential cmake```（也可以下载安装 http://www.cmake.org/cmake/resources/software.html）。

## 4、手动安装 YouCompleteMe。
切换至 `~/.vim/bundle` 手动下载 YouCompleteMe
输入如下命令：`git clone https://github.com/Valloric/YouCompleteMe.git`
 手动下载完后检查仓库的完整性，切换到 YouCompleteMe 目录下，
输入如下命令：`git submodule update --init --recursive`

## 5、编译 YCM
如果需要对 C-family 的语义支持：

```bash
cd ~/.vim/bundle/YouCompleteMe
./install.sh --clang-completer
```

如果不需要对 C-family 的语义支持：
```
cd ~/.vim/bundle/YouCompleteMe
./install.sh 
```
如果需要支持 C#，添加 `--omnisharp-complete`
如果需要支持 Go `添加 --gocode-completer`
编译 clang+llvm 时内存要大于 1.5G，否则会报错： g++: internal compiler error: Killed (program cc1plus) Please submit a full bug report
主要原因大体上是因为内存不足，临时使用交换分区来解决：
```
sudo dd if=/dev/zero of=/swapfile bs=64M count=16    # 64 * 16 = 1024 创建 1 g 的内存分区
sudo mkswap /swapfile
sudo swapon /swapfile
#free -m    #可以查看内存
```
编译完成后释放交换空间：
```
sudo swapoff /swapfile
sudo rm /swapfile
```
## 6. 接着再次打开 ~/.vimrc 配置 YCM，添加内容如下：（就是添加`Plugin 'Valloric/YouCompleteMe'`）
```
call vundle#begin()
...
Plugin 'Valloric/YouCompleteMe'
...
call vundle#end() " required
...
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_complete_in_comments=1
let g:ycm_collect_identifiers_from_comments_and_strings = 0
let g:ycm_min_num_of_chars_for_completion=2
let g:ycm_complete_in_strings = 1
let g:ycm_seed_identifiers_with_syntax=1
```
如图：
![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190517083203.png)


更详细的的配置信息：
```
set ts=4
set expandtab
set shiftwidth=4
set softtabstop=4
set number
"vundle"
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'davidhalter/jedi-vim'
call vundle#end()
filetype plugin indent on
"youcompleteme"
"默认配置文件路径"
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py' "配置全局路径
"log"
"let g:ycm_server_keep_logfiles=1
"let g:ycm_sever_log_level='debug'
"打开vim时不再询问是否加载ycm_extra_conf.py配置"
"let g:ycm_confirm_extra_conf=0
"set completeopt=longest,menu
"python解释器路径"
let g:ycm_path_to_python_interpreter='/home/wdh/anaconda3/bin/python3'
"let g:ycm_python_binary_path = '/home/wdh/anaconda3/bin/python3' "python 环境
"是否开启语义补全"
let g:ycm_seed_identifiers_with_syntax=1
"是否在注释中也开启补全"
let g:ycm_complete_in_comments=1
let g:ycm_collect_identifiers_from_comments_and_strings = 0
"开始补全的字符数"
let g:ycm_min_num_of_chars_for_completion=2
"补全后自动关机预览窗口"
"let g:ycm_autoclose_preview_window_after_completion=1
" 禁止缓存匹配项,每次都重新生成匹配项"
let g:ycm_cache_omnifunc=0
"字符串中也开启补全"
let g:ycm_complete_in_strings = 1
let g:ycm_seed_identifiers_with_syntax=1 "补全关键字 
"离开插入模式后自动关闭预览窗口"
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"回车即选中当前项"
"inoremap <expr> <CR> pumvisible() ? '<C-y>' : '\<CR>'     
"上下左右键行为"
"inoremap <expr> <Down> pumvisible() ? '\<C-n>' : '\<Down>'
"inoremap <expr> <Up> pumvisible() ? '\<C-p>' : '\<Up>'
"inoremap <expr> <PageDown> pumvisible() ? '\<PageDown>\<C-p>\<C-n>' : '\<PageDown>'
"inoremap <expr> <PageUp> pumvisible() ? '\<PageUp>\<C-p>\<C-n>' : '\<PageUp>'\
```
## 7. 为了补全，我们还需要在 .ycm_extra_conf.py 文件中进行配置，
`vim ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py`
添加信息如下：
```
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
```
实际上以上是 vim 自动补全时搜索路径，如果自动补全的内容位于 /usr/local/include 里面，则添加以下信息：
```
'-isystem',
'/usr/local/include',
```
根据实际的 /usr/include/c++/ 中的文件夹名称 (即 C++ 版本号) 修改：
```
'-isystem',
'/usr/include/c++/4.8.4',
'-isystem',
'/usr/include/c++/4.9.2',
```
添加结果如下：
![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190517083241.png)


</br>

## 问题
### Q1：我是按照这个路径去 vim 的`vim ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py`
出现该问题的意思是在别的路径找到这个文件了。
这个时候应该记住这个路径，并且在该路径下打开 `.ycm_extra_conf.py`
![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190517083312.png)
（上面这个图不知道为什么和我编辑的路径一样（可能当时我编辑过多遍，他当时提示的是在`/home/hzh/.vim/bundle/YouCompleteMe/third_party/ycmd`），不过相信我，这个路径肯定有问题，因为我在提示的路径已经找到了编译时生成的 `.ycm_extra_conf.py`，已经有部分的基础配置）
所以这个时候就要退出当前编辑界面（不保存），然后 cd 到提示的目录，再 `vim .ycm_extra_conf.py`
如下：（箭头标的是添加的头文件放的地方）
![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190517083408.png)

## 效果
编写 C++
![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190517083538.png)
![](https://raw.githubusercontent.com/yiyah/Picture_Material/master/20190517083559.png)




## 参考
1. https://www.cnblogs.com/alinh/p/6699789.html
2. https://blog.csdn.net/u011529752/article/details/78462125