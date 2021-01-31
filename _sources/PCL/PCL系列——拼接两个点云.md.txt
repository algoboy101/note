# PCL系列——拼接两个点云


## PCL系列
* [PCL系列——读入PCD格式文件操作](http://zhangxuezhi.com/2016/03/30/PCL%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E8%AF%BB%E5%85%A5PCD%E6%A0%BC%E5%BC%8F%E6%96%87%E4%BB%B6/)
* [PCL系列——将点云数据写入PCD格式文件](http://zhangxuezhi.com/2016/03/30/PCL%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E5%B0%86%E7%82%B9%E4%BA%91%E6%95%B0%E6%8D%AE%E5%86%99%E5%85%A5PCD%E6%A0%BC%E5%BC%8F%E6%96%87%E4%BB%B6/)
* [PCL系列——拼接两个点云](http://zhangxuezhi.com/2016/04/20/PCL%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E6%8B%BC%E6%8E%A5%E4%B8%A4%E4%B8%AA%E7%82%B9%E4%BA%91/)
* [PCL系列——从深度图像（RangeImage）中提取NARF关键点](http://zhangxuezhi.com/2016/03/30/PCL%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E4%BB%8E%E6%B7%B1%E5%BA%A6%E5%9B%BE%E5%83%8F%EF%BC%88RangeImage%EF%BC%89%E4%B8%AD%E6%8F%90%E5%8F%96NARF%E5%85%B3%E9%94%AE%E7%82%B9/)
* [PCL系列——如何可视化深度图像](http://zhangxuezhi.com/2016/03/30/PCL%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E5%A6%82%E4%BD%95%E5%8F%AF%E8%A7%86%E5%8C%96%E6%B7%B1%E5%BA%A6%E5%9B%BE%E5%83%8F/)
* [PCL系列——如何使用迭代最近点法（ICP）配准](http://zhangxuezhi.com/2016/03/31/PCL%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E5%A6%82%E4%BD%95%E4%BD%BF%E7%94%A8%E8%BF%AD%E4%BB%A3%E6%9C%80%E8%BF%91%E7%82%B9%E6%B3%95%EF%BC%88ICP%EF%BC%89%E9%85%8D%E5%87%86/)
* [PCL系列——如何逐渐地配准一对点云](http://zhangxuezhi.com/2016/04/01/PCL%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E5%A6%82%E4%BD%95%E9%80%90%E6%B8%90%E5%9C%B0%E9%85%8D%E5%87%86%E4%B8%80%E5%AF%B9%E7%82%B9%E4%BA%91/)
* [PCL系列——三维重构之泊松重构](http://zhangxuezhi.com/2016/04/01/PCL%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E4%B8%89%E7%BB%B4%E9%87%8D%E6%9E%84%E4%B9%8B%E6%B3%8A%E6%9D%BE%E9%87%8D%E6%9E%84/)
* [PCL系列——三维重构之贪婪三角投影算法](http://zhangxuezhi.com/2016/04/01/PCL%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E4%B8%89%E7%BB%B4%E9%87%8D%E6%9E%84%E4%B9%8B%E8%B4%AA%E5%A9%AA%E4%B8%89%E8%A7%92%E6%8A%95%E5%BD%B1%E7%AE%97%E6%B3%95/)
* [PCL系列——三维重构之移动立方体算法](http://zhangxuezhi.com/2016/04/01/PCL%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E4%B8%89%E7%BB%B4%E9%87%8D%E6%9E%84%E4%B9%8B%E7%A7%BB%E5%8A%A8%E7%AB%8B%E6%96%B9%E4%BD%93%E7%AE%97%E6%B3%95/)
* [PCL系列——平面模型分割](http://zhangxuezhi.com/2016/04/20/PCL%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E5%B9%B3%E9%9D%A2%E6%A8%A1%E5%9E%8B%E5%88%86%E5%89%B2/)

## 说明
通过本教程，我们将会学会：
* 如何拼接两个不同的点云的点，约束条件是两个数据集中的域的数量和类型必须相等。* 如何拼接两个不同点云的域，约束条件是连个数据集中的点的数量必须相等。

## 操作

* 在VS2010 中新建一个文件 concatenate_clouds.cpp，然后将下面的代码复制到文件中。
* 参照之前的文章，配置项目的属性。设置包含目录和库目录和附加依赖项。

```cpp
#include <iostream> //标准输入输出流
#include <pcl/io/pcd_io.h> //PCL的PCD格式文件的输入输出头文件
#include <pcl/point_types.h> //PCL对各种格式的点的支持头文件
//比如，你的程序遇到调用栈用完了的威胁。你说，你到什么地方借内存，
//存放你的错误信息？cerr的目的，就是在你最需要它的紧急情况下，
//还能得到输出功能的支持。 缓冲区的目的，就是减少刷屏的次数

// 程序拼接A和B到C
int main (int argc, char** argv)
{
  if (argc != 2) // 需要一个参数 -f 或 -p
  {
    std::cerr << "please specify command line arg '-f' or '-p'" << std::endl;
    exit(0);
  }
	// 用于拼接不同点云的点的变量
  pcl::PointCloud<pcl::PointXYZ> cloud_a, cloud_b, cloud_c; //创建点云（不是指针），存储点坐标xyz
	// 用于拼接不同点云的域（点和法向量）的变量
  pcl::PointCloud<pcl::Normal> n_cloud_b; //创建点云，储存法向量
  pcl::PointCloud<pcl::PointNormal> p_n_cloud_c; //创建点云，储存点坐标和法向量

  //填充点云数据
  cloud_a.width  = 5; //设置宽度
  cloud_a.height = cloud_b.height = n_cloud_b.height = 1; //设置高度
  cloud_a.points.resize (cloud_a.width * cloud_a.height); //变形，无序
  if (strcmp(argv[1], "-p") == 0) //根据输入参数，设置点云
  {
    cloud_b.width  = 3; //cloud_b用于拼接不同点云的点
    cloud_b.points.resize (cloud_b.width * cloud_b.height);
  }
  else{
    n_cloud_b.width = 5; //n_cloud_b用于拼接不同点云的域
    n_cloud_b.points.resize (n_cloud_b.width * n_cloud_b.height);
  }
  for (size_t i = 0; i < cloud_a.points.size (); ++i) //设置cloud_a中点的坐标（随机数）
  {
    cloud_a.points[i].x = 1024 * rand () / (RAND_MAX + 1.0f);
    cloud_a.points[i].y = 1024 * rand () / (RAND_MAX + 1.0f);
    cloud_a.points[i].z = 1024 * rand () / (RAND_MAX + 1.0f);
  }
  if (strcmp(argv[1], "-p") == 0)
    for (size_t i = 0; i < cloud_b.points.size (); ++i) //设置cloud_b中点的坐标（随机数）
    {
      cloud_b.points[i].x = 1024 * rand () / (RAND_MAX + 1.0f);
      cloud_b.points[i].y = 1024 * rand () / (RAND_MAX + 1.0f);
      cloud_b.points[i].z = 1024 * rand () / (RAND_MAX + 1.0f);
    }
  else // -f
    for (size_t i = 0; i < n_cloud_b.points.size (); ++i) //设置n_cloud_b中点的坐标（随机数）
    {
      n_cloud_b.points[i].normal[0] = 1024 * rand () / (RAND_MAX + 1.0f);
      n_cloud_b.points[i].normal[1] = 1024 * rand () / (RAND_MAX + 1.0f);
      n_cloud_b.points[i].normal[2] = 1024 * rand () / (RAND_MAX + 1.0f);
    }

	// 打印拼接用的数据 A和B
  std::cerr << "Cloud A: " << std::endl;
  for (size_t i = 0; i < cloud_a.points.size (); ++i) //打印cloud_a的点坐标信息
    std::cerr << "    " << cloud_a.points[i].x << " " << cloud_a.points[i].y << " " << cloud_a.points[i].z << std::endl;

  std::cerr << "Cloud B: " << std::endl; //打印Cloud B
  if (strcmp(argv[1], "-p") == 0) //若输入参数是-p，打印cloud_b；
    for (size_t i = 0; i < cloud_b.points.size (); ++i)
      std::cerr << "    " << cloud_b.points[i].x << " " << cloud_b.points[i].y << " " << cloud_b.points[i].z << std::endl;
  else //若-f，打印n_cloud_b
    for (size_t i = 0; i < n_cloud_b.points.size (); ++i)
      std::cerr << "    " << n_cloud_b.points[i].normal[0] << " " << n_cloud_b.points[i].normal[1] << " " << n_cloud_b.points[i].normal[2] << std::endl;

  //复制点云中的点
  if (strcmp(argv[1], "-p") == 0)
  {
    cloud_c  = cloud_a;
    cloud_c += cloud_b; // cloud_a + cloud_b 意思是cloud_c包含了a和b中的点，c的点数 = a的点数+b的点数
    std::cerr << "Cloud C: " << std::endl; ////打印Cloud C
    for (size_t i = 0; i < cloud_c.points.size (); ++i) //打印Cloud C
      std::cerr << "    " << cloud_c.points[i].x << " " << cloud_c.points[i].y << " " << cloud_c.points[i].z << " " << std::endl;
  }
  else //若输入参数是-f
  {
    pcl::concatenateFields (cloud_a, n_cloud_b, p_n_cloud_c); //拼接（点）cloud_a和（法向量）n_cloud_b到p_n_cloud_c
    std::cerr << "Cloud C: " << std::endl;
    for (size_t i = 0; i < p_n_cloud_c.points.size (); ++i) //打印Cloud C
      std::cerr << "    " <<
        p_n_cloud_c.points[i].x << " " << p_n_cloud_c.points[i].y << " " << p_n_cloud_c.points[i].z << " " <<
        p_n_cloud_c.points[i].normal[0] << " " << p_n_cloud_c.points[i].normal[1] << " " << p_n_cloud_c.points[i].normal[2] << std::endl;
  }

  return (0);
}
```

* 重新生成项目。
* 到改项目的Debug目录下，按住Shift，同时点击鼠标右键，在当前窗口打开CMD窗口。
* 在CMD窗口中，输入命令`concatenate_clouds.exe -p`，执行**拼接不同点云的点**。结果如下图所示。
![这里写图片描述](http://img.blog.csdn.net/20160330144458704)
* 在CMD窗口中，输入命令`concatenate_clouds.exe -f`，执行**拼接不同点云的域（比如点和法向量）**。结果如下图所示。
![这里写图片描述](http://img.blog.csdn.net/20160330144432309)


## 参考
* [Concatenate the points of two Point Clouds](http://pointclouds.org/documentation/tutorials/concatenate_clouds.php#concatenate-clouds)