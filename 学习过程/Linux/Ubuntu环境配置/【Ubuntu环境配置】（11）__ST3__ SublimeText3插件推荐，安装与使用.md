[TOC]

## 一、安装相关

看参考 ---> 安装

## 二、配置相关

### 2.1.1 配置python的编译环境

* 如果想要用别的解释器：tool --- Build System --- New Build System;

```json
// 1. 输入以下：是的,Ubuntu也是cmd
{
    // 下面的就是选择哪一个python编译，修改前面的就好了。
	"cmd": ["/home/hzh/app/anaconda3/envs/caffe/bin/python3","-u","$file"]
}
// 保存的时候以自己的用途命名，如 Python_caffe

// 2. 启用自己的编译环境
tools --- build system --- 选择刚刚保存的
```

### 2.1.2 配置TAB自动补全

* 安装 Anaconda 插件

```json
// anaconda 的配置
{
	python_interpreter": "/home/hzh/app/anaconda3/envs/caffe/bin/python3",

    /*
        Set those as true if you don't want Sublime Text regular completions
    */
    "suppress_word_completions": true,
    "suppress_explicit_completions": true,
	"complete_parameters": true,
	"anaconda_linting":false,
}
```

### 2.2 配置 Markdown 环境
1. 主要是安装MD的加强的编辑插件、预览插件和设置一下关联键。（看参考）
2. 关于MarkdownEditing这个插件的配置，需要在"Markdown GFM Settings"里设置
```json
{
    "color_scheme": "Packages/MarkdownEditing/MarkdownEditor-Dark.tmTheme",
    "line_numbers": true, //显然这个是显示行号的。
}

```

## 三、插件总结
```txt
// 1. 软件功能相关
1.1 SideBarEnhancements // 扩展侧边栏功能，就是原本的侧边栏很少选项。
1.2 syncedSideBar // 点击文件，定位到左侧目录
1.3 SideBarFolders // 在菜单栏中增加一个选项，记录打开过的文件夹(这个要去github clone)
1.4 PackageResourceViewer // 编辑Package源文件的插件，
//用来修改主题的一些信息，如标题，侧边栏的字体大小

// 2. 主题相关
2.1 Material Theme // 还行吧,使用的话，直接调出控制面板输入"theme"---"select theme"就可以看到安装的主题了。
2.2 Freesia Theme // 可以先到github看看

// 3. 代码相关
3.1 anaconda // 代码补全
3.2 autofilename           //补全路径

// 4. Markdown 相关
4.1 MarkdownEditing // 提高Sublime中Markdown编辑特性的插件
4.2 MarkdownPreview // Markdown转HTML，提供在浏览器中的预览功能
4.3 LiveReload // 一个提供md/html等文档的实时刷新预览的的插件(我用chrome才行)

```


```c
1.  ConvertToUTF8  		//支持中文显示
2.  WorldCount    			//统计world
3.  Terminal				//支持在终端打开到该路径 
4.  Alignment				//自动对齐
5.  DocBlockr				//自动生成大块的注释
6.  AllAutocomplete		//对打开的所有文件的变量名进行提示
7.  Ctags					//跳转定义
8.  CScope					//

11. BracketHighlighter		//显示成对的括号
12. TrailingSpaces			//高亮显示多余的空格

14. 
15. Search Stack Overflow	//就是不想动鼠标，直接在 Sublime 中打开浏览器搜索 Stackoverflow
18. AutoPep8				//调整 Python 代码，使其符合 PEP8 的要求
```


## 参考
1. [Package Control](https://packagecontrol.io/)(专门的插件网站)
### 安装：

1. [Linux Ubuntu 安装 Sublime Text (无法使用 wget 命令，使用安装包下载)](https://blog.csdn.net/ustckang/article/details/79836052)
2. [激活教程](https://allwpt.com/1035.html)
3. [最新Sublime Text 3 (3211)许可密钥 (mac可用)](https://bbs.mallol.cn/thread-1502.htm)

### 配置python环境

1. [ubuntu下Sublime Text 3 python环境配置](https://blog.csdn.net/qq_20768851/article/details/81292727)

#### 配置 Morkdown 环境
1. [Sublime Text3 的 Markdown 实时预览全面总结](https://blog.csdn.net/qq_20011607/article/details/81370236)
2. [sublime text3中，markdownedting插件主题切换失效](https://blog.csdn.net/u011410529/article/details/46635083)

### 插件：

1.  [Sublime 插件：增强篇](<https://www.jianshu.com/p/5905f927d01b>)
2.  [Sublime 插件：C 语言篇](<https://www.jianshu.com/p/595975a2a5f3>)
3.  [Ctags的安装](<https://github.com/SublimeText/CTags>)
4.  [Ubuntu 安装 Cscope 和 Ctags](<https://www.linuxidc.com/Linux/2012-05/60727.htm>)
5.  [使用 Sublime Text3+Ctags+Cscope 替代 Source Insight](<https://www.zybuluo.com/lanxinyuchs/note/33551>)
6.  [谈谈 Sublime Text 3 与 Soda Theme](<https://blog.csdn.net/yanln/article/details/84832503>)
7.  [Sublime Text 的插件官方网站](<https://packagecontrol.io/>)
8.  <span id = "cankao8">[Sublime Text 3 修改 Side Bar（侧边栏）字体大小](<http://www.jyguagua.com/?p=3842>)</span>
9.  [Sublime Text 3 配置 python 开发环境](https://blog.csdn.net/woay2008/article/details/80786650)

