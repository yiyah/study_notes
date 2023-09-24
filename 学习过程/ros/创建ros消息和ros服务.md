# 创建 ros 消息 和 ros 服务

## 概念

* 消息(msg): msg 文件就是一个描述 ROS 中所使用消息类型的简单文本。它们会被用来生成不同语言的源代码。

* 服务(srv): 一个 srv 文件描述一项服务。它包含两个部分：请求和响应。

msg 文件存放在 package 的 msg 目录下，srv 文件则存放在 srv 目录下。

msg 文件实际上就是每行声明一个数据类型和变量名

* 下面是一个msg文件的样例，它使用了Header，string，和其他另外两个消息类型。

    在ROS中有一个特殊的数据类型：Header，它含有时间戳和坐标系信息。在msg文件的第    一行经常可以看到Header header的声明.

    ```msg
    Header header
    string child_frame_id
    geometry_msgs/PoseWithCovariance pose
    geometry_msgs/TwistWithCovariance twist
    ```

* srv文件分为请求和响应两部分，由 '---' 分隔。下面是srv的一个样例：

    ```srv
    int64 A
    int64 B
    ---
    int64 Sum
    ```

    其中 A 和 B 是请求, 而Sum 是响应。

## 创建 msg 的过程

1. 创建 srv

    ```shell
    cd ~/xxx_ws/src/package_name
    mkdir msg
    echo "int64 num" > msg/num.msg
    ```

2. 确保 msg 文件被转换成 c++, python 和其他语言的源代码

    1. 在 `package.xml` 添加

        ```xml
        <build_depend>message_generation</build_depend>
        <exec_depend>message_runtime</exec_depend>
        ```

    2. 在 `CMakeLists.txt` 中添加

       * `find_package()`

        ```CMakeLists
        find_package(catkin REQUIRED COMPONENTS roscpp rospy std_msgs ... message_generation)
        ```

       * `catkin_package()`

        ```CMakeLists
        catkin_package(
        ...
        CATKIN_DEPENDS message_runtime ...
        ...)
        ```

       * `add_message_files()`

        ```CMakeLists
        add_message_files(
        FILES
        your_MSG.msg
        )
        ```

       * `generate_messages()`

        ```CMakeLists
        # 确保添加了以下代码
        generate_message()
        ```

    3. 验证

        ```shell
        rosmsg show [message type]
        # rosmsg show package_name/xx_msg
        # rosmsg show xx_msg
        ```

## 创建 srv 的过程

1. 创建 srv

    ```shell
    mkdir srv
    ```

2. 确保 srv文件被转换成C++，Python和其他语言的源代码。

    在 `CMakeLists.txt` 中

    * `find_package()`

        ```shell
        find_package(catkin REQUIRED COMPONENTS
        roscpp
        rospy
        std_msgs
        ...
        message_generation)  # 主要是添加这句，这句对 msg 和 srv 都起作用
        ```

    * `add_service_files()`

        ```shell
        add_service_files(
        FILES
        your_srv.srv)
        ```

3. 验证

    ```shell
    rossrv show <service type>
    # rossrv show package_name/xxx_srv
    ```

## msg和srv都需要的步骤

接下来，在 `CMakeLists.txt` 中找到如下部分:

```CMakeLists
generate_messages(
  DEPENDENCIES
  std_msgs
)
```

```shell
catkin_make
```
