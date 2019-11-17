# PCL系列——三维重构之泊松重构

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
* 如果通过泊松算法进行三维点云重构。
* 程序支持两种文件格式：`*.pcd`和`*.ply`
* 程序先读取点云文件，然后计算法向量，接着使用泊松算法进行重构，最后显示结果。


## 操作

* 在VS2010 中新建一个文件 `recon_poisson.cpp`，然后将下面的代码复制到文件中。
* 参照之前的文章，配置项目的属性。设置包含目录和库目录和附加依赖项。

``` cpp

//点的类型的头文件
#include <pcl/point_types.h>
//点云文件IO（pcd文件和ply文件）
#include <pcl/io/pcd_io.h>
#include <pcl/io/ply_io.h>
//kd树
#include <pcl/kdtree/kdtree_flann.h>
//特征提取
#include <pcl/features/normal_3d_omp.h>
#include <pcl/features/normal_3d.h>
//重构
#include <pcl/surface/gp3.h>
#include <pcl/surface/poisson.h>
//可视化
#include <pcl/visualization/pcl_visualizer.h>
//多线程
#include <boost/thread/thread.hpp>
#include <fstream>
#include <iostream>
#include <stdio.h>
#include <string.h>
#include <string>

int main(int argc, char** argv)
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

	// 计算法向量
  pcl::PointCloud<pcl::PointNormal>::Ptr cloud_with_normals(new pcl::PointCloud<pcl::PointNormal>); //法向量点云对象指针
  pcl::NormalEstimation<pcl::PointXYZ , pcl::Normal> n ;//法线估计对象
  pcl::PointCloud<pcl::Normal>::Ptr normals(new pcl::PointCloud<pcl::Normal>) ;//存储估计的法线的指针
  pcl::search::KdTree<pcl::PointXYZ>::Ptr tree(new pcl::search::KdTree<pcl::PointXYZ>) ;
  tree->setInputCloud(cloud) ;
  n.setInputCloud(cloud) ;
  n.setSearchMethod(tree) ;
  n.setKSearch(20);
	n.compute(*normals); //计算法线，结果存储在normals中

	//将点云和法线放到一起
  pcl::concatenateFields(*cloud , *normals , *cloud_with_normals) ;

	//创建搜索树
  pcl::search::KdTree<pcl::PointNormal>::Ptr tree2(new pcl::search::KdTree<pcl::PointNormal>) ;
  tree2->setInputCloud(cloud_with_normals) ;
	//创建Poisson对象，并设置参数
  pcl::Poisson<pcl::PointNormal> pn ;
	pn.setConfidence(false); //是否使用法向量的大小作为置信信息。如果false，所有法向量均归一化。
	pn.setDegree(2); //设置参数degree[1,5],值越大越精细，耗时越久。
	pn.setDepth(8); //树的最大深度，求解2^d x 2^d x 2^d立方体元。由于八叉树自适应采样密度，指定值仅为最大深度。
	pn.setIsoDivide(8); //用于提取ISO等值面的算法的深度
	pn.setManifold(false); //是否添加多边形的重心，当多边形三角化时。 设置流行标志，如果设置为true，则对多边形进行细分三角话时添加重心，设置false则不添加
	pn.setOutputPolygons(false); //是否输出多边形网格（而不是三角化移动立方体的结果）
	pn.setSamplesPerNode(3.0); //设置落入一个八叉树结点中的样本点的最小数量。无噪声，[1.0-5.0],有噪声[15.-20.]平滑
	pn.setScale(1.25); //设置用于重构的立方体直径和样本边界立方体直径的比率。
	pn.setSolverDivide(8); //设置求解线性方程组的Gauss-Seidel迭代方法的深度
	//pn.setIndices();

	//设置搜索方法和输入点云
	pn.setSearchMethod(tree2);
	pn.setInputCloud(cloud_with_normals);
	//创建多变形网格，用于存储结果
	pcl::PolygonMesh mesh ;
	//执行重构
	pn.performReconstruction(mesh);

	//保存网格图
	pcl::io::savePLYFile("result.ply", mesh);

	// 显示结果图
	boost::shared_ptr<pcl::visualization::PCLVisualizer> viewer(new pcl::visualization::PCLVisualizer("3D viewer")) ;
	viewer->setBackgroundColor(0 , 0 , 0) ;
	viewer->addPolygonMesh(mesh , "my") ;
	viewer->addCoordinateSystem (50.0);
	viewer->initCameraParameters() ;
	while (!viewer->wasStopped()){
		viewer->spinOnce(100) ;
		boost::this_thread::sleep(boost::posix_time::microseconds(100000)) ;
	}

	return 0;
}

```

* 重新生成项目。
* 到改项目的Debug目录下，按住Shift，同时点击鼠标右键，在当前窗口打开CMD窗口。
* 在命令行中输入`recon_poisson.exe bunny.points.ply`，执行程序。得到如下图所示的结果。
![泊松重构结果图](http://img.blog.csdn.net/20160401093428810)