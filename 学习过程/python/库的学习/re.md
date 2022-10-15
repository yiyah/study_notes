# re

[TOC]

## 关于分组

|匹配对象方法|描述|
|-|-|
|group(num=0)|匹配的整个表达式的字符串，group() 可以一次输入多个组号，在这种情况下它将返回一个包含那些组所对应值的元组。
|groups()|返回一个包含所有小组字符串的元组，从 1 到 所含的小组号。|

* 在 `pattern` （正则中的模式字符串）中，如果没用 `( )` 作分组。

    ```python
    str = "Cats are smarter than dogs"
    matchObj = re.search(r'.* Are.*than', str, re.I)  # re.I 忽略大小写
    print(matchObj.group())  # return Cats are smarter than
    print(matchObj.groups())  # return ()
    ```

* 在 `pattern` （正则中的模式字符串）中，如果有用 `( )` 作分组。

    ```python
    str = "Cats are smarter than dogs"
    matchObj = re.search(r'(.*) Are(.*)than', str, re.I)

    print(matchObj.group())   # Cats are smarter than
    print(matchObj.group(1))  # Cats
    print(matchObj.group(2))  #  smarter (注意这个结果前后各有一个空格)
    print(matchObj.groups())  # ('Cats', ' smarter ')
    ```

* 总结

    1. `groups()` 返回一个元组，包含所有小组。（但是从1开始，也就是不包含整串模式字符串）
    2. `groups()` 是 `pattern` 里含有 `()` 才有用。
    3. `group()` 返回 `pattern` 中匹配到的字符串。

## 一、match(pattern, string, flags=0)

* `re.match()` 方法从字符串的**起始位置**开始匹配，成功返回一个匹配的对象。失败返回`none`。

* 参数说明

    |参数|描述|
    |-|-|
    |pattern|匹配的正则表达式|
    |string|要匹配的字符串|
    |flags|标志位，用于控制正则表达式的匹配方式，如：是否区分大小写，多行匹配等等|

* 例子

    ```python
    str = "www.runoob.com"
    matchObj1 = re.match('www', str).span()  # return (0, 3)

    matchObj2 = re.match('com', str)  # return None
    ```

## 二、search(pattern, string, flags=0)

* `re.search()`扫描整个字符串并返回第一个成功的匹配。

    ```python
    re.search('www', 'www.runoob.com').span()  # return (0, 3)
    re.search('com', 'www.runoob.com').span()  # return (11, 14)
    ```

## 三、sub(pattern, repl, string, count=0, flags=0)

* `sub()` 用于替换字符串中的匹配项。返回替换后的字符串。
* 参数

    |参数|描述|
    |-|-|
    |pattern|匹配的正则表达式|
    |repl|替换的字符串，也可为一个函数。|
    |string|要匹配的字符串|
    |count|模式匹配后替换的最大次数，默认 0 表示替换所有的匹配。|
    |flags|标志位，用于控制正则表达式的匹配方式，如：是否区分大小写，多行匹配等等|

* 例子

  * `repl` 是一个字符串

    ```python
    phone = "_2004-959-559 # 这是一个国外电话号码"

    # 删除字符串中的 Python注释
    num = re.sub(r'#.*$', "", phone)
    print("电话号码是: ", num)  # 电话号码是:  2004-959-559

    # 删除非数字(-)的字符串
    num = re.sub(r'\D', "", phone)
    print("电话号码是 : ", num)  # 电话号码是 :  2004959559
    ```

  * `repl` 是一个函数

    ```python
    # 还没
    ```

## 四、findall()

* 在字符串中找到正则表达式所匹配的所有子串，并返回一个列表，如果没有找到匹配的，则返回空列表。
* 注意：`match()` 和 `search()` 是匹配一次, `findall()` 匹配所有。

* 例子

    ```python
    str1 = "abs 123 ehw 456"
    str2 = "abs123asdf456asdf789"
    print(re.findall(r'\d+', str1))  # ['123', '456']
    print(re.findall(r'\d+', str2))  # ['123', '456', '789']
    ```

## 参考

1. [Python 正则表达式](https://www.runoob.com/python/python-reg-expressions.html)
2. [re模块详解](https://www.cnblogs.com/chengege/p/11190782.html)
