# PCL系列——读入PCD格式文件

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

## 操作
* 在VS2010 中新建一个文件read_pcd.cpp，然后将下面的代码复制到文件中。
* 参照之前的文章，配置项目的属性。设置包含目录和库目录和附加依赖项。


```cpp
#include <iostream> //标准输入输出流
#include <pcl/io/pcd_io.h> //PCL的PCD格式文件的输入输出头文件
#include <pcl/point_types.h> //PCL对各种格式的点的支持头文件

int main (int argc, char** argv)
{
  pcl::PointCloud<pcl::PointXYZ>::Ptr cloud (new pcl::PointCloud<pcl::PointXYZ>); // 创建点云（指针）

  if (pcl::io::loadPCDFile<pcl::PointXYZ> ("test_pcd.pcd", *cloud) == -1) //* 读入PCD格式的文件，如果文件不存在，返回-1
  {
    PCL_ERROR ("Couldn't read file test_pcd.pcd \n"); //文件不存在时，返回错误，终止程序。
    return (-1);
  }
  std::cout << "Loaded "
            << cloud->width * cloud->height
            << " data points from test_file.pcd with the following fields: "
            << std::endl;
  //for (size_t i = 0; i < cloud->points.size (); ++i) //显示所有的点
	for (size_t i = 0; i < 5; ++i) // 为了方便观察，只显示前5个点
    std::cout << "    " << cloud->points[i].x
              << " "    << cloud->points[i].y
              << " "    << cloud->points[i].z << std::endl;

  return (0);
}
```

* 编译运行，如下图所示。
![这里写图片描述](http://img.blog.csdn.net/20160330103906416)

## 参考
* [Reading Point Cloud data from PCD files](http://pointclouds.org/documentation/tutorials/reading_pcd.php#reading-pcd)