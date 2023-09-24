# use

[toc]

```c++
VideoCapture cap("00.mp4");
cap >> frame;
imread("./hand03.jpg", IMREAD_COLOR);
resize(src, src, Size(src.cols / 5, src.rows / 5));
cvtColor(src, srcBinary, COLOR_BGR2GRAY);

erode(srcBinary, srcBinary, getStructuringElement(MORPH_RECT, Size(5, 5)));

// 找边界，画边界
findContours(srcBinary, contours, hierarchy, RETR_EXTERNAL, CHAIN_APPROX_SIMPLE);
drawContours(src, contours,border,Scalar(0,0,255), FILLED);

// 计算边界面积、长度
contourArea(contours[border]);
arcLength(contours[border], true);

// 级联分类器
CascadeClassifier cascade;
cascade.load(cascadePathName);
detectMultiScale();

// knn 分类器
// train&generate a xml file
Mat trainImg, trainLabels;// 用来保存训练图片的矩阵
//这中间需要把样本和标签，分别存放到上面的Mat中。（其中，一张图片转换成一行存到trainImg中；对应的标签存放到trainLabels中；也就是假如有1000张需要识别的图片，trainImg就有1000行，trainLabels就有1000行1列）
trainImg.convertTo(trainImg, CV_32F);// 类型转换
trainLabels.convertTo(trainLabels, CV_32F);// 类型转换
Ptr<TrainData> trainData = TrainData::create(trainImg, ROW_SAMPLE, trainLabels);// 创建训练数据
Ptr<KNearest> knnModel = KNearest::create();// 创建knn模型
//setAlgorithmType
knnModel->setDefaultK(7);
knnModel->setIsClassifier(true);
double t = 0;//计算检测所需时间
t = (double)getTickCount();
knnModel->train(trainData);// 对创建的训练数据进行训练
knnModel->save("./newKnn.xml");// 保存训练的特征
t = (double)getTickCount() - t;
printf("detection time = %g ms\n", t * 1000 / getTickFrequency());

// read&detect
Ptr<KNearest> knnModel = StatModel::load<KNearest>(knnModelPath);
Mat predictImg;// 新建一个待检测的Mat
predictImg = frame(ROI).clone();// 从一副大的图里找到ROI深拷贝到待检测的Mat，深拷贝很重要！
predictImg = frame.reshape(0, 1);// 转换成一行
predictImg.convertTo(predictImg,CV_32F);// 转换数据类型
result = knnModel->predict(predictImg.row(0));// predict的图一定要完整的，即不能frame(ROI)做参数

// 运行时间
double t = 0;//计算检测所需时间
t = (double)getTickCount();
t = (double)getTickCount() - t;
printf("detection time = %g ms\n", t * 1000 / getTickFrequency());

//当得到对象轮廓后，可用boundingRect()得到包覆此轮廓的最小正矩形，minAreaRect()得到包覆轮廓的最小斜矩形。
boundingRect()；//最小正矩形
minAreaRect();//找最小外接斜矩形

cvtColor();//函数是负责转换不同通道的Mat
convertTo();//函数负责转换数据类型不同的Mat

// 关于Mat构造函数的说明
Mat(int ndims, const int* sizes, int type);// --------构造1
// 我的定义
Mat test(10,5,CV_8UC3);//10行5列3通道，默认值205
Mat(const std::vector<int>& sizes, int type);// --------构造2
// 我的定义
vector<int> t = { 4,2 };//只能两个数，超出会invlid
Mat test1(t,CV_8UC3);//4行2列3通道，默认值205
Mat(int ndims, const int* sizes, int type, const Scalar& s);// --------构造3
// 我的定义
Mat test2(10, 2, CV_8UC3,Scalar());//10行2列3通道，值为全0

// floodFill()（可以设置不改动原图，但是输入的 mask 一定会被修改）
// mask 如果全0的话，就会对img 全部改变，floodFill算法不能越过mask中的非0像素，所以，可以通过设置一些你不想填充的区域像素值大于0，就不会被修改！
//flag参数的可选项有：FLOODFILL_MASK_ONLY（不修改原图），FLOODFILL_FIXED_RANGE（设置只与种子点比较）
// 使用
Mat mask;
Rect ccomp;
mask = Mat::zeros(img.rows+2,img.cols+2, CV_8UC1);// mask的Size()必须比要操作的图大两个像素，通道数一个
floodFill(img, mask,Point(x, y), Scalar(0, 0, 255), &ccomp,Scalar(10, 10, 10), Scalar(10, 10, 10), 4| (255 << 8));
//param3 Point(x, y)：种子点，就是从哪个点开始 floodFill
//param4 Scalar(0, 0, 255): 填涂在img上的颜色
//param5 &ccomp: 用于设置floodFill函数将要重绘区域的最小边界矩形区域
//param6 Scalar(10, 10, 10)：就是当前观察的像素和种子点的像素（邻近像素）的差值（负差，就是当前-种子=复数）
//param7 Scalar(10, 10, 10): 就是当前观察的像素和种子点的像素（邻近像素）的差值（正差，就是当前-种子=正数）
//param8 flag(4| (255 << 8))): 低八位：控制算法的连通性；中八位：填充在掩膜mask上的颜色；高八位：作用一：考虑当前像素是和种子点比较还是和邻近像素比较。作用二：改不改动原图img


// Mat 赋值 
Mat tmp;
tmp = (Mat_<uchar>(3,3) << 0,-1,0, -1,5,-1, 0,-1,0);

// 二值化
double threshold( InputArray src,OutputArray dst,double threshold,double maxval,int type );

// filter
medianBlur(src,src,5);
Laplacian(gray_src,gray_src,CV_8UC1);
GaussianBlur(gray_src, gray_src, Size(5, 5), 2);
```

## Reference

1. [openCV中convertTo的用法](https://blog.csdn.net/qq_22764813/article/details/52135686)