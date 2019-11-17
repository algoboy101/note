# caffe安装系列——安装caffe

## 说明
* 网上关于caffe的安装教程非常多，但是关于每一步是否操作成功，出现了什么样的错误又该如何处理没有给出说明。因为大家的操作系统的环境千差万别，按照博客中的教程一步步的安装，最后可能失败——这是很常见的哦。有的教程甚至省略了一些细节部分，让小白更不知道如何判断每一步是否操作成功，如何处理出现的错误。
* 作者花费了很长时间才成功地将caffe装完，期间遇到好多错误，多次重装操作系统。现在将经验写下来，一方面为了和大家分享，讨论；另一方面是为了记录一下下~~~

## 环境
* 操作系统： ***Ubuntu 14.04***
* GCC/G++:***4.7.x***
* OpenCV: ***2.4.11和3.0.0***
* Matlab :***R2014b(a)***
* Python:   ***2.7***

## 安装步骤
* 其它链接
* [综述](http://zhangxuezhi.com/2015/09/24/caffe%E5%AE%89%E8%A3%85%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E7%BB%BC%E8%BF%B0/)
* [安装GCC4.7和G++4.7并降级](http://zhangxuezhi.com/2015/09/22/caffe%E5%AE%89%E8%A3%85%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E5%AE%89%E8%A3%85GCC4.7%E5%92%8CG++4.7%E5%B9%B6%E9%99%8D%E7%BA%A7/)
* [安装显卡驱动](http://zhangxuezhi.com/2015/09/24/caffe%E5%AE%89%E8%A3%85%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E5%AE%89%E8%A3%85NVIDIA%E6%98%BE%E5%8D%A1%E9%A9%B1%E5%8A%A8/)
* [安装cuda和cudnn](http://zhangxuezhi.com/2015/09/22/caffe%E5%AE%89%E8%A3%85%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E5%AE%89%E8%A3%85cuda%E5%92%8Ccudnn/)
* [安装Matlab](http://zhangxuezhi.com/2015/09/23/caffe%E5%AE%89%E8%A3%85%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E5%AE%89%E8%A3%85Matlab/)
* [安装OpenCV](http://zhangxuezhi.com/2015/09/24/caffe%E5%AE%89%E8%A3%85%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E5%AE%89%E8%A3%85OpenCV/)
* [安装Python依赖包](http://zhangxuezhi.com/2015/09/24/caffe%E5%AE%89%E8%A3%85%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E5%AE%89%E8%A3%85python%E4%BE%9D%E8%B5%96%E5%8C%85/)
* [安装caffe](http://zhangxuezhi.com/2015/10/13/caffe%E5%AE%89%E8%A3%85%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E5%AE%89%E8%A3%85caffe/)


* 这已经是caffe安装过程的最后一步了。但是**行百里者，半于九十**，因此还要小心。

## 安装Google Logging Library（glog）

* 下载glog。
* [glog 下载地址](https://code.google.com/p/google-glog/)
* 安装命令如下所示
```
# 解压
tar -zxvf glog-0.3.3.tar.gz
# 切换路径
cd glog-0.3.3
sudo ./configure
sudo make –j
sudo make install
```

## 安装其它依赖
* 执行以下命令即可。

```bash
sudo apt-get install -y libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libboost-all-dev libhdf5-serial-dev 
sudo apt-get install -y libgflags-dev libgoogle-glog-dev liblmdb-dev protobuf-compiler protobuf-c-compiler python-pandas
```

## 编辑Makefile.config文件
* 操作命令如下所示。
```
unzip caffe-master.zip #本地解压caffe-master
#切换路径
cd /caffe-master 
#caffe源文件中没有Makefile.config，需要复制Makefile.config.example
cp Makefile.config.example Makefile.config
#编辑Makefile.config
vi Makefile.config 
```
* 修改Makefile.config
	* 取消第5行的注释，即将 `#USE_CUDNN=1 改为 USE_CUDNN=1`；
	* 如果使用本教程系列安装的，就不需要修改`BLAS=atlas`，如果是参考欧新宇的教程，安装了MKL，需要改成`BLAS=mkl`；
	* 启用CUDNN，加注释: `CPU_ONLY:=1 改成 # CPU_ONLY:=1`；
	* 配置路径，实现caffe对Python和Matlab接口的支持：

	```
	PYTHON_LIB := /usr/local/lib
	MATLAB_DIR := /usr/local/MATLAB/R2014a
	```

## 编辑Makefile文件
* 如果openCV版本是2.4.x，此小节可以不再阅读
* 如果openCV版本3.0，还需要修改Makefile文件，实现对OpenCV 3.x的支持。
* 在Makefile文件中查找“Derive include and lib directories”一节，修改“LIBRARIES +=”的最后一行，增加**opencv_imgcodecs**，修改之后为：
```
LIBRARIES += opencv_core opencv_highgui opencv_imgproc opencv_imgcodecs
```

## 编译caffe-master
* 依次执行下面的命令，编译caffe：
```
make all -j
make test -j
make runtest -j
```
* runtest执行结束之后，如下图所示。这样子就说明安装成功了。
![这里写图片描述](http://img.blog.csdn.net/20150924102251050)

* 编译Python和Matlab用到的caffe文件
```
make pycaffe -j
make matcaffe -j
```
* pycaffe和matcaffe编译完成后，如下图所示：
![这里写图片描述](http://img.blog.csdn.net/20150924104443215)
* 编译过程中可能会遇到错误，比如***./include/caffe/util/cudnn.hpp:8:34: fatal error: caffe/proto/caffe.pb.h: No such file or director***，这是因为protobuf和pillow没有安装，或者是通过apt-get安装的。使用pip重新安装一遍即可解决问题。删除caffe-mast（提前保存Makefile.config和Makefile），解压，解压重新编译。
```
pip install protobuf --upgrade -i http://pypi.douban.com/simple 
pip install pillow --upgrade -i http://pypi.douban.com/simple
```

## 设置Python环境变量
* 此时虽然编译完成，但是python还不能使用caffe，需要设置python的环境变量，将其caffe/python路径添加到python环境变量中。
* 操作命令如下所示：
```
sudo vi /etc/profile # 编辑profile文件
#在最后面添加以下语句，注意将path换成你的系统下的路径
export PYTHONPATH=/path/to/caffe/python:$PYTHONPATH
```
* 在caffe安装整个过程中，我么修改/etc/profile三次，如下图所示。
![这里写图片描述](http://img.blog.csdn.net/20150924102736837)

## 使用MNIST数据集进行测试
* 参考[欧新宇的教程](http://ouxinyu.github.io/Blogs/20140723001.html)即可。
* 操作命令如下所示：
```
# 1. 数据预处理
sh data/mnist/get_mnist.sh
# 2. 重建lmdb文件。Caffe支持三种数据格式输入网络，包括Image(.jpg, .png等)，leveldb，lmdb，根据自己需要选择不同输入吧。
#生成mnist-train-lmdb 和 mnist-train-lmdb文件夹，这里包含了lmdb格式的数据集
sh examples/mnist/create_mnist.sh

# 3. 训练mnist
sh examples/mnist/train_lenet.sh
```

**注意：**如果在使用过程中出现检测不到NVIDIA显卡的情况，重装显卡驱动和cuda即可。

## 总结
* 至此，ubuntu下安装caffe的工作已经结束了。如果你完全按照本教程操作，相信你一定已经成功安装caffe了，并且对caffe有了一定的了解。
* ***世上无难事只怕有坚持***，安装过程虽然很复杂，但是只要坚持，不断的Google解决它，caffe就一定能安装。
* 错误不可怕，它是成功的障碍，同时也为我们成长提供了阶梯——所谓的能力，很大一部分是通过不断解决问题来获取的。
* 下面开始学习如何使用caffe做深度学习的研究喽，祝大家学习愉快。。。
