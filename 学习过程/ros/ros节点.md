# ROS 节点

[TOC]

## 图概念概述

* `Nodes`: 节点,一个节点即为一个可执行文件，它可以通过 ROS 与其它节点进行通信。
* `Messages`: 消息，消息是一种 ROS 数据类型，用于订阅或发布到一个话题。
* `Topics`: 话题,节点可以发布消息到话题，也可以订阅话题以接收消息。
* `Master`: 节点管理器，ROS 名称服务 (比如帮助节点找到彼此)。
* `rosout`: ROS 中相当于 stdout/stderr。
* `roscore`: 主机 + rosout + 参数服务器 (参数服务器会在后面介绍)。

## 相关命令 -- node

```shell
roscore  # roscore 是运行所有ROS程序前首先要运行的命令。
rosnode list # 显示当前运行的ROS节点信息。rosnode list 指令列出活跃的节点
rosnode info xxx_node #  返回的是关于一个特定节点的信息。
rosrun [package_name] [node_name]  # rosrun 允许你使用包名直接运行一个包内的节点(而不需要知道这个包的路径)。
rosrun turtlesim turtlesim_node __name:=my_turtle  # 后面的参数改变节点名字，即 rosnode list
rosnode ping xxx_node
```

## 相关命令 -- topic

* 先介绍一款可视化工具，该工具可以可视化 节点之间 通过 哪些话题 来通信！

    ```shell
    rosrun rqt_graph rqt_graph
    ```

* 再介绍一款将数据可视化的工具

    ```shell
    rosrun rqt_plot rqt_plot
    ```

```shell
rostopic list -v  # 列出所有当前订阅和发布的话题。-v 列出详细信息。
rostopic hz [topic]  # 可以用来查看数据发布的频率。
rostopic echo [topic]  # 显示在某个话题上发布的数据。看不到输出 是因为 没有数据发布到该 topic 上！
rostopic type [topic]  # 查看所发布话题的消息类型。
rostopic pub [topic] [msg_type] [args]  # 把数据发布到当前某个正在广播的话题上
  # 例如: rostopic pub -1 /turtle1/cmd_vel geometry_msgs/Twist -- '[2.0, 0.0, 0.0]' '[0.0, 0.0, 1.8]'
  # rostopic pub /turtle1/cmd_vel geometry_msgs/Twist -r 1 -- '[2.0, 0.0, 0.0]' '[0.0, 0.0, 1.8]'
  # 参数解释：
  # -1:（单个破折号）这个参数选项使 rostopic 发布一条消息后马上退出。(我改其他数字会报错)
  # --:（双破折号）这会告诉命令选项解析器接下来的参数部分都不是命令选项。这在参数里面包含有破折号-（比如负号）时是必须要添加的。
  # -r: 以 xx Hz 发送数据到 topic
```

## 相关命令 -- message

```shell
rostopic type [topic]  # 查看所发布话题的消息类型。把这个输出放到下面的输入
rosmsg show [message]  # 查看消息的详细情况
```
