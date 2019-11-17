# PCL系列——如何使用迭代最近点法（ICP）配准


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

* 如何使用迭代最近点法（Iterative Closest Point）判断一个点云是否是另一个点云的刚体变换
* 使用的方法是：最小化两个点云中对应点之间的距离，并刚性变换他们。
* 代码说明：先生成输入点云（待变换的点云）和目标点云（变换参照），然后创建ICP对象，设置该对象的输入点云和目标点云，然后进行配准，并显示ICP配准信息和变换矩阵。


## 操作

* 在VS2010 中新建一个文件 iterative_closest_point.cpp，然后将下面的代码复制到文件中。
* 参照之前的文章，配置项目的属性。设置包含目录和库目录和附加依赖项。

``` cpp
#include <iostream> //标准输入/输出
#include <pcl/io/pcd_io.h> //pcd文件输入/输出
#include <pcl/point_types.h> //各种点类型
#include <pcl/registration/icp.h> //ICP(iterative closest point)配准

int main (int argc, char** argv)
{
  //创建点云指针
  pcl::PointCloud<pcl::PointXYZ>::Ptr cloud_in (new pcl::PointCloud<pcl::PointXYZ>); //创建输入点云（指针）
  pcl::PointCloud<pcl::PointXYZ>::Ptr cloud_out (new pcl::PointCloud<pcl::PointXYZ>); //创建输出/目标点云（指针）

  //生成并填充点云cloud_in
  cloud_in->width    = 5;
  cloud_in->height   = 1;
  cloud_in->is_dense = false;
  cloud_in->points.resize (cloud_in->width * cloud_in->height); //变形，无序
  for (size_t i = 0; i < cloud_in->points.size (); ++i) //随机数初始化点的坐标
  {
    cloud_in->points[i].x = 1024 * rand () / (RAND_MAX + 1.0f);
    cloud_in->points[i].y = 1024 * rand () / (RAND_MAX + 1.0f);
    cloud_in->points[i].z = 1024 * rand () / (RAND_MAX + 1.0f);
  }
  std::cout << "Saved " << cloud_in->points.size () << " data points to input:"
      << std::endl;
  //打印点云cloud_in中所有点的坐标信息
  for (size_t i = 0; i < cloud_in->points.size (); ++i) std::cout << "    " <<
      cloud_in->points[i].x << " " << cloud_in->points[i].y << " " <<
      cloud_in->points[i].z << std::endl;

  // 填充点云cloud_out
  *cloud_out = *cloud_in; //初始化cloud_out
  std::cout << "size:" << cloud_out->points.size() << std::endl;
  for (size_t i = 0; i < cloud_in->points.size (); ++i)
    cloud_out->points[i].x = cloud_in->points[i].x + 0.7f; //平移cloud_in得到cloud_out
  std::cout << "Transformed " << cloud_in->points.size () << " data points:"
      << std::endl;
  //打印点云cloud_out中所有点的坐标信息（每一行对应一个点的xyz坐标）
  for (size_t i = 0; i < cloud_out->points.size (); ++i)
    std::cout << "    " << cloud_out->points[i].x << " " <<
      cloud_out->points[i].y << " " << cloud_out->points[i].z << std::endl;
  //*********************************
  // ICP配准
  //*********************************
  pcl::IterativeClosestPoint<pcl::PointXYZ, pcl::PointXYZ> icp; //创建ICP对象，用于ICP配准
  icp.setInputCloud(cloud_in); //设置输入点云
  icp.setInputTarget(cloud_out); //设置目标点云（输入点云进行仿射变换，得到目标点云）
  pcl::PointCloud<pcl::PointXYZ> Final; //存储结果
  //进行配准，结果存储在Final中
  icp.align(Final); 
  //输出ICP配准的信息（是否收敛，拟合度）
  std::cout << "has converged:" << icp.hasConverged() << " score: " <<
  icp.getFitnessScore() << std::endl;
  //输出最终的变换矩阵（4x4）
  std::cout << icp.getFinalTransformation() << std::endl;

 return (0);
}
```

* 重新生成项目。
* 到改项目的Debug目录下，按住Shift，同时点击鼠标右键，在当前窗口打开CMD窗口。
* 在命令行中输入`iterative_closest_point.exe`，可以得到下图所示结果。
![这里写图片描述](http://img.blog.csdn.net/20160331091512850)


## 参考
* [How to use iterative closest point](http://pointclouds.org/documentation/tutorials/iterative_closest_point.php#iterative-closest-point)