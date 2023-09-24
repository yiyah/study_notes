# pixhawk 与 ROS 通信

---

Creation Date: 2020-09-10

---

[TOC]

## 环境

1. 树莓派 3B+(xenial)
2. Pixhawk2.4.8（APM 固件）

## 一、安装 ROS 和 MAVAROS

* ROS

  根据 参考1 选择自己的系统 安装 ROS 就好了。

* MAVROS

  根据 参考2 安装 MAVROS。

## 二、Connecting with ROS

### 2.1 连接前的配置

1. pixhawk 的配置

    * 连接地面站，设置参数 `SERIAL2_PROTOCOL = 2` `SERIAL2_BAUD = 921`（重启）
    * pixhawk 的 telem2(串口2) 连接到 树莓派的 TX,RX,GND（通过 usb 供电，最好一直插在电脑上，连接地面站看变化）

2. 树莓派的配置

    * `sudo raspi-config` --> 选择 `InterFacing options ...` --> 选择 `serial` --> `yes`
    * `python3 mavproxy.py --master=/dev/serial0 --baudrate 921600 --aircraft MyCopter`（文件在 `~/.local/bin/`）
    * 成功输出以下：（得有版本信息输出才算成功）

        ```shell
        $ python3 mavproxy.py --master=/dev/serial0 --baudrate 921600 --aircraft MyCopter
        Connect /dev/serial0 source_system=255
        no script MyCopter/mavinit.scr
        Log Directory: MyCopter/logs/2020-09-10/flight71
        Telemetry log: MyCopter/logs/2020-09-10/flight71/flight.tlog
        Waiting for heartbeat from /dev/serial0
        MAV> link 1 down                        # 失败会在这里卡住，没有下面的版本信息
        APM: ChibiOS: d4fce84e
        APM: fmuv3 001E002C 3435510B 30303830
        APM: RCOut: PWM:1-12
        APM: Frame: UNKNOWN
        link 1 OK
        online system 1
        STABILIZE> Mode STABILIZE
        ... 还有一些乱码数据
        ```

    * 成功后，可以试下以下命令

        ```shell
        param show ARMING_CHECK
        param set ARMING_CHECK 0
        arm throttle  # 解锁

        # 拓展
        # 输入 help 查看可以使用的命令
        mode auto           # 切换模式，manual, hold
        servo set 2 3000    # 通道 2，设置 3000 PWM 高电平，即为 3000/20000 = 15% 的 PWM
        rc all 2000         # 设置 所有通道的输入 为 2000，不会输出！！！
        ```

### 2.2 connnect

* `2.1` 通过后，方可继续！

**step1:** 打开一个终端并输入运行 `roscore`
**step2:** `roslaunch mavros apm.launch fcu_url:=/dev/serial0:921600`
    注意根据自己使用的连接方式选择 `fcu_url`，例如我用的是串口。
**step3:** 测试飞行控制器是否响应mavros命令

```shell
rosrun mavros mavsys mode -c 0  # (sets the vehicle to mode "0") 0 改成 auto hold manual 都行
rosrun mavros mavsafety arm  # (to arm the vehicle) 记得切换 Stabilize 模式; disarm 上锁

# 也可以如下
rostopic echo /mavros/rc/in  # 可以显示遥控器的值
```

## 问题

1. 卡在 `MAV> link 1 down`

    现象：运行 `python3 mavproxy.py --master=/dev/serial0 --baudrate 921600 --aircraft MyCopter` 后出现此问题
    原因：是因为 设置参数 `SERIAL2_PROTOCOL = 2` `SERIAL2_BAUD = 921` 后没有重启。或者是**供电不足**！！！
    **解决方法：** 重启 pixhawk。或者换条电源线和插头。

2. `param show ARMING_CHECK` 无法显示参数值

    原因：参数表还没读取完，等会就可以了。
    **解决方法：** Saved 923 parameters to MyCopter/logs/2020-09-11/flight9/mav.parm

3. `arm throttle` 解锁不了

    原因：看是不是出现 `APM: PreArm: check firmware or FRAME_CLASS`，这是说没有选择机架。
    **解决方法：** 在地面站选择相应的机架类型后解锁即可。

    ---

    连接 ros 前的配置问题 ↑↑↑

    ---

4. `transport error completing service call: receive_once[/mavros/cmd/arming]: DeserializationError cannot deserialize: unknown error handler name 'rosmsg'`
    原因：运行 `rosrun mavros mavsafety arm` 时出现
    **解决方法：** `sudo apt-get install ros-kinetic-genpy`（参考4）

5. `Request failed. Check mavros logs`

    原因：运行 `rosrun mavros mavsafety arm` 解锁失败，或者是 。
    **解决方没有此模式法：** 因为没有切换模式！！！ 先运行 `rosrun mavros mavsys mode -c Stabilize` 再解锁即可解决或者设置合适的名称。

6. `[ WARN] [1600134127.443976501]: TM : RTT too high for timesync: xx.xx ms.`

    原因：运行 `roslaunch mavros apm.launch fcu_url:=/dev/serial0:921600` 时的 warning。
    **解决方法：** : 在文件 `apm_config.yaml` 找到 `timesync_rate` 改为 `0.0`。（`/opt/ros/kinetic/share/mavros/launch/apm_config.yaml`）

## 参考

1. [ROS Installation Options](http://wiki.ros.org/ROS/Installation)
2. [Docs » Companion Computers » ROS » Installing ROS](https://ardupilot.org/dev/docs/ros-install.html#)
3. [Communicating with Raspberry Pi via MAVLink](https://ardupilot.org/dev/docs/raspberry-pi-via-mavlink.html#raspberry-pi-via-mavlinks)
4. [DeserializationError cannot deserialize: unknown error handler name ‘rosmsg‘](https://blog.csdn.net/WinTeRomING/article/details/108402250)
5. [RTT too High For Timesync with SITL (MAVROS)](https://discuss.ardupilot.org/t/rtt-too-high-for-timesync-with-sitl-mavros/38224)

## 更新说明

1. 2020/09/15 更新：
    * 增加 `mavproxy` 命令
    * 增加 问题说明
