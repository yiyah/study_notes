# ROS 服务和参数

## ROS Services

* 服务（services）是节点之间通讯的另一种方式（另一种是 topic）。服务允许节点发送请求（request） 并获得一个响应（response）

* 相关命令

    ```shell
    rosservice list  # 输出可用服务的信息
    # 查看某个 node 的 service 可以使用 rosnode info nodeName
    rosservice call [service] [args] # 调用带参数的服务
    rosservice type [service] # 查看服务类型
    rosservice type [service]|rossrv show  # 查看服务的参数
    rosservice find  # 依据类型寻找服务find services by service type
    rosservice uri   # 输出服务的ROSRPC uri
    ```

## rosparam

* `rosparam` 使得我们能够存储并操作 ROS 参数服务器（Parameter Server）上的数据。

* 相关命令

    ```shell
    rosparam list                 # 列出参数名
    rosparam set  [param_name]    # 设置参数
    rosparam get  [param_name]    # 获取参数
    rosparam get /                # 显示参数服务器上的所有内容：
    rosparam load [file_name]  # 从文件读取参数
    rosparam dump [file_name] [namespace] # 向文件中写入参数
    rosparam delete  # 删除参数
    ```
