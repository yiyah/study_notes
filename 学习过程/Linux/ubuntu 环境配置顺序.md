# ubuntu 环境配置顺序

1. Vmtools，配置apt源
--- backup base ---
2. pip 配置源（选择清华源较好，实测阿里源有时会出错）

    ```shell
    hzh@vcmd:~$ cat ~/.pip/pip.conf
    [global]
    index-url = https://pypi.tuna.tsinghua.edu.cn/simple
    ```

3. git
4. vscode
--- backup ---
5. anaconda 配置源
6. cmake ---编译安装 ---应提前
--- backup ---
7. 编译安装 opencv --- 一切的基础都是基于编译安装好cv
  numpy
  
  sudo apt-get install build-essential git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev python-dev libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev -y

  type pre pkg opengl  modules
  不能使用anaconda的python，不知道为啥
8. 编译安装 caffe
9. Kinect

## 工作配置

Ubuntu 实际的软件安装顺序

1. python2
2. vim
3. python3-pip and modified aliyun source
4. git
5. VScode
6. chmod o+x -R /opt (because I install anaconda in /opt, the app run need sudo)
7. Anaconda3 and modified tuna source (in /opt/anaconda3)
8. cmake (this is a offical complied binary) in /opt/cmakexxx and I move the bin(cmake, cmake-gui) to /usr/local/bin
9. python-pip
10. numpy(pip2,3)
11. move opencv and install opencv depends
12. build && install opencv
    - configure opencv python environment(vim ~/.local/lib/python2(3)/opencv.pth)
    - configure opencv C++ environment(sudo ln -s /opt/opencv/myInstall/lib/pkgconfig/opencv4.pc /usr/lib/pkgconfig/opencv.pc && )

13. Empty ~/tmp
14. conda create -n caffe python=3.6
15. caffe(both py2,3 can run)
16. driver of Kinect(OpenNI+SensorKinect+NITE)

## 个人配置

1. vim
2. python2, pip, pip3

    * `export http_proxy=http://127.0.0.1:12333` `export https_proxy=https://127.0.0.1:12333`
    * I have proxy, so if you don't, you'd better choose Tsinghua's pip source)

3. electron-ssr in ~/App
4. cmake (this is a offical complied binary) I move the bin(cmake, cmake-gui and so on) to /usr/local/bin)
5. git
6. vs code(configure something)
7. cascadia code
8. need

    * opencv
    * caffe
