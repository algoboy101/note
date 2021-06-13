# PCL系列——三维重构之贪婪三角投影算法


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

* 如果通过贪婪三角投影算法进行三维点云重构。
* 程序支持两种文件格式：`*.pcd`和`*.ply`。
* 程序先读取点云文件；然后计算法向量，并将法向量和点云坐标放在一起；接着使用贪婪三角投影算法进行重构，最后显示结果。


## 操作

* 在VS2010 中新建一个文件 `recon_greedyProjection.cpp`，然后将下面的代码复制到文件中。
* 参照之前的文章，配置项目的属性。设置包含目录和库目录和附加依赖项。

``` cpp
/*
* GreedyProjection是根据点云进行三角化，而 poisson 则是对water-tight的模型进行重建，
* 所以形成了封闭mesh和很多冗余信息，需要对poisson的重建进行修剪才能得到相对正确的模型
*
*/

#include <pcl/point_types.h>
#include <pcl/io/pcd_io.h>
#include <pcl/io/ply_io.h>
#include <pcl/kdtree/kdtree_flann.h>
#include <pcl/features/normal_3d.h>
#include <pcl/surface/gp3.h>
#include <pcl/visualization/pcl_visualizer.h>
#include <boost/thread/thread.hpp>
#include <fstream>
#include <iostream>
#include <stdio.h>
#include <string.h>
#include <string>

int main (int argc, char** argv)
{
	// 确定文件格式
	char tmpStr[100];
	strcpy(tmpStr,argv[1]);
	char* pext = strrchr(tmpStr, '.');
	std::string extply("ply");
	std::string extpcd("pcd");
	if(pext){
		*pext='\0';
		pext++;
	}
	std::string ext(pext);
	//如果不支持文件格式，退出程序
	if (!((ext == extply)||(ext == extpcd))){
		std::cout << "文件格式不支持!" << std::endl;
		std::cout << "支持文件格式：*.pcd和*.ply！" << std::endl;
		return(-1);
	}

	//根据文件格式选择输入方式
  pcl::PointCloud<pcl::PointXYZ>::Ptr cloud(new pcl::PointCloud<pcl::PointXYZ>) ; //创建点云对象指针，用于存储输入
	if (ext == extply){
		if (pcl::io::loadPLYFile(argv[1] , *cloud) == -1){
			PCL_ERROR("Could not read ply file!\n") ;
			return -1;
		}
	}
	else{
		if (pcl::io::loadPCDFile(argv[1] , *cloud) == -1){
			PCL_ERROR("Could not read pcd file!\n") ;
			return -1;
		}
	}

  // 估计法向量
  pcl::NormalEstimation<pcl::PointXYZ, pcl::Normal> n;
  pcl::PointCloud<pcl::Normal>::Ptr normals (new pcl::PointCloud<pcl::Normal>);
  pcl::search::KdTree<pcl::PointXYZ>::Ptr tree (new pcl::search::KdTree<pcl::PointXYZ>);
  tree->setInputCloud (cloud);
  n.setInputCloud (cloud);
  n.setSearchMethod (tree);
  n.setKSearch (20);
  n.compute (*normals); //计算法线，结果存储在normals中
  //* normals 不能同时包含点的法向量和表面的曲率

  //将点云和法线放到一起
  pcl::PointCloud<pcl::PointNormal>::Ptr cloud_with_normals (new pcl::PointCloud<pcl::PointNormal>);
  pcl::concatenateFields (*cloud, *normals, *cloud_with_normals);
  //* cloud_with_normals = cloud + normals
	
  //创建搜索树
  pcl::search::KdTree<pcl::PointNormal>::Ptr tree2 (new pcl::search::KdTree<pcl::PointNormal>);
  tree2->setInputCloud (cloud_with_normals);

  //初始化GreedyProjectionTriangulation对象，并设置参数
  pcl::GreedyProjectionTriangulation<pcl::PointNormal> gp3;
	//创建多变形网格，用于存储结果
  pcl::PolygonMesh triangles;

  //设置GreedyProjectionTriangulation对象的参数
	//第一个参数影响很大
  gp3.setSearchRadius (1.5f); //设置连接点之间的最大距离（最大边长）用于确定k近邻的球半径【默认值 0】
  gp3.setMu (2.5f); //设置最近邻距离的乘子，以得到每个点的最终搜索半径【默认值 0】
  gp3.setMaximumNearestNeighbors (100); //设置搜索的最近邻点的最大数量
  gp3.setMaximumSurfaceAngle(M_PI/4); // 45 degrees（pi）最大平面角
  gp3.setMinimumAngle(M_PI/18); // 10 degrees 每个三角的最小角度
  gp3.setMaximumAngle(2*M_PI/3); // 120 degrees 每个三角的最大角度
  gp3.setNormalConsistency(false); //如果法向量一致，设置为true

  //设置搜索方法和输入点云
  gp3.setInputCloud(cloud_with_normals);
  gp3.setSearchMethod(tree2);

	//执行重构，结果保存在triangles中
  gp3.reconstruct (triangles);
	
	//保存网格图
	pcl::io::savePLYFile("result.ply", triangles);

  // Additional vertex information
  //std::vector<int> parts = gp3.getPartIDs();
  //std::vector<int> states = gp3.getPointStates();

	// 显示结果图
  boost::shared_ptr<pcl::visualization::PCLVisualizer> viewer (new pcl::visualization::PCLVisualizer ("3D Viewer"));
  viewer->setBackgroundColor (0, 0, 0); //设置背景
  viewer->addPolygonMesh(triangles,"my"); //设置显示的网格
  viewer->addCoordinateSystem (1.0); //设置坐标系
  viewer->initCameraParameters ();
  while (!viewer->wasStopped ()){
    viewer->spinOnce (100);
    boost::this_thread::sleep (boost::posix_time::microseconds (100000));
  }
	
  return (0);
}

```

* 重新生成项目。
* 到改项目的Debug目录下，按住Shift，同时点击鼠标右键，在当前窗口打开CMD窗口。
* 在命令行中输入`recon_greedyProjection.exe bunny.points.ply`，执行程序。得到如下图所示的结果。

![这里写图片描述](http://img.blog.csdn.net/20160401094420876)

