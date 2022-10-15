# selenum 的使用

Selenium 是一个自动化测试工具，支持各种主流浏览器，例如 Chrome、Safari、Firefox 等。

## 一、安装

```shell
# step1: 安装 selenium 库
pip3 install selenium
# step2: 下载浏览器驱动
# 看参考一的链接，下载自己对应浏览器的驱动
# 然后设置环境变量就可以了，环境变量设置到包含该驱动的文件夹就可以了
```

* 补充：（Ubuntu）在 `step2` 中，如果在终端中使用 `export PATH=XXX:$PATH` 则该环境变量对当前终端有效。用此终端运行 selenium 的程序是没啥问题，但是用别的终端不重新设置环境变量是有问题的！可以把这个路径添加到配置文件中，任何终端都永久生效。

## 二、使用

```python3
from selenium import webdriver

url = 'https://www.baidu.com'
browser = webdriver.Firefox()
# browser = webdriver.Firefox('path\to\your\geckodriver')  # 作者这样写，貌似不用设置环境变量就可以使用，但经实测，没啥用。
browser.get(url)
browser.close()
```

## 参考

1. [Selenium Python](http://www.testclass.net/selenium_python/)
