# data

[TOC]

## 一、About 神经网络 Neuro Network

### 1.1 神经网络 Neuro Network

1. [神经网络浅讲：从神经元到深度学习](https://www.cnblogs.com/subconscious/p/5058741.html)

### 1.2 卷积神经网络 CNN - Convolution Neuro Network

1. [卷积神经网络CNN总结](https://www.cnblogs.com/skyfsm/p/6790245.html)
2. [卷积神经网络(CNN)模型结构](https://www.cnblogs.com/pinard/p/6483207.html)

## 二、目标检测

**关于 YOLO 的总结：**

* darknet是框架，一种轻量型的深度学习框架，纯c+cuda；yolo是方法、模型；作者：Joseph Chet Redmon开发了一个深度学习框架——Darkent,并且设计了多种yolo系列模型，

1. [Darknet 的GitHub](https://github.com/pjreddie/darknet)
2. [AlexeyAB 优化的 darknet](https://github.com/AlexeyAB/darknet)
3. [Darknet 的注释](https://github.com/hgpvision/darknet)
4. [Yolo-v4 and Yolo-v3/v2 for Windows and Linux](https://github.com/AlexeyAB/darknet#how-to-use-on-the-command-line)（YOLOV4）
5. [用darknet框架中的YOLOv3对自己的数据集进行训练和预测](https://blog.csdn.net/qq_32761549/article/details/90020725#8_darknetcfgyolov3voccfg_183)

### 2.1 行人检测参考资料

1. [YOLOv3行人检测](https://github.com/pascal1129/yolo_person_detect)
2. [OpenCV+yolov3实现目标检测(C++,Python)](https://blog.csdn.net/guyuealian/article/details/84098461)
3. [行人检测与行人重识别结合](https://zhuanlan.zhihu.com/p/82398949)（[同文章的CSDN链接](https://blog.csdn.net/songwsx/article/details/78337457) 和 [GitHub](https://github.com/songwsx/person_search_demo)）（此链接是在 YOLO 基础上再训练，摄像头是处于高处，该模型修改为判断人，车的前还是后，车的侧面（因为没有见过此类别出现，所以我猜应该是标记车的侧面）实测没有官方的模型好，因为近处的人并不能识别，官方的远近都能识别）
4. [使用yolov3训练行人检测模型要点总结](https://zhuanlan.zhihu.com/p/36734511)
5. [超详细教程：YOLO_V3（yolov3）训练自己的数据](https://blog.csdn.net/qq_21578849/article/details/84980298?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1.nonecase&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-1.nonecase)
6. [目标检测：YOLOv3: 训练自己的数据](https://blog.csdn.net/lilai619/article/details/79695109)

### 2.2 部署参考资料

1. [用darknet框架中的YOLOv3对自己的数据集进行训练和预测](https://blog.csdn.net/qq_32761549/article/details/90020725#8_darknetcfgyolov3voccfg_183)
2. [opencv调用yolov3模型进行目标检测，以实例进行代码详解](https://blog.csdn.net/qq_32761549/article/details/90402438)

## 数据集下载

1. [此数据集是为目标检测做的数据集的网站，YOLO用的](https://pjreddie.com/projects/pascal-voc-dataset-mirror/)
2. [行人检测数据集汇总（持续更新）](https://zhuanlan.zhihu.com/p/31836357)
