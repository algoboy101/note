# Ubuntu14.04安装Theano详细教程



> 因为最近需要学习深度学习，因此想要配置Theano，来开发深度学习算法。但是发现Theano安装总是出现问题。于是在这里中总结一下。

## 环境
* 操作系统：ubuntu14.04
* Python：2.7.6
* 需要联网

<!-- more -->

## 相关库简介
* ***BLAS***（Basic Linear Algebra Subprograms）是基础线性代数子程序库，里面拥有大量已经编写好的关于线性代数运算的程序;
* ***LAPACK*** （Linear Algebra PACKage）包含了求解科学与工程计算中最常见的数值线性代数问题，如求解线性方程组、线性最小二乘问题、特征值问题和奇异值问题等;
* ***ATLAS***是python下的一个线性代数库，是基于另外两个线性代数库BLAS和lapack的；
* ***NumPy***提供了一个在python中做科学计算的基础库，它重在数值计算，甚至可以说是用于多维数组处理的库；
* ***SciPy***是基于numpy，提供了一个在python中做科学计算的工具集，也就是说它是更上一个层次的库；
* ***Theano***则是基于NumPy以及SciPy的一个更高级的用于科学计算的库。


## 相关库的关系
* 要安装Theano，就需要先安装好numpy和scipy；
* 要安装numpy和scipy，就需要ATLAS；
* 要安装ATLAS，就需要安装BLAS和LAPACK;

## 相关库的安装顺序
* 安装顺序：*`BLAS → LAPACK → ATLAS → numpy → scipy → Theano`*


## 检查numpy和scipy是否通过测试
* 说明：如果你的numpy和scipy是通过`apt-get`安装的，那么它们的单元测试可能会通不过！！！（我在安装过程中没有通过测试，scipy出现了**Error**）
* 如果numpy或scipy不能通过测试，就需要卸载，然后重新按照本文介绍的顺序安装。

```bash
# 检查numpy是否通过测试
python -c "import numpy;numpy.test()"
```
* 如果numpy通过测试，会出现如下图所示的结果。注意最后一行***errors=0 failures=0***。如果没有通过测试，需要卸载并重新安装。
![numpy测试结果](http://img.blog.csdn.net/20150726185255050)

* 如果scipy通过测试，会出现如下图所示的结果。注意最后一行***errors=0 failures=0***。如果没有通过测试，需要卸载并重新安装。
![scipy通过测试](http://img.blog.csdn.net/20150726185208417)

* 注意：scipy很可能会出现测试错误，比如我安装过程中出现下图所示的错误。
![scipy测试错误](http://img.blog.csdn.net/20150726185356526)


## 卸载numpy和scipy
```bash
# 卸载numpy
sudo apt-get remove python-numpy

# 卸载scipy
sudo apt-get remove python-scipy
```

## 安装各种包
```bash
# 安装gfortran,后面编译过程中会用到
sudo apt-get install gfortran
# 安装blas,Ubuntu下对应的是libopenblas，其它操作系统可能需要安装其它版本的blas——这是个OS相关的。
sudo apt-get install libopenblas-dev
# 安装lapack，Ubuntu下对应的是liblapack-dev，和OS相关。
sudo apt-get install liblapack-dev
# 安装atlas，Ubuntu下对应的是libatlas-base-dev，和OS相关。
sudo apt-get install libatlas-base-dev
```


## 安装numpy和scipy
* 使用pip安装numpy和scipy
* 安装pip的命令：**`sudo apt-get install python-pip`**
* 注意：一定要在安装完lapack/blas之后，再安装numpy和scipy。否则，会出现错误***`no lapack/blas resources found`***
* 安装numpy和scipy的命令如下所示。
```bash
# 安装numpy
sudo pip install numpy
# 测试numpy
# 测试通过才能进行下一步～～
python -c "import numpy;numpy.test()"

# 安装scipy
sudo pip install scipy
# 测试scipy
# 测试通过才能进行下一步～～
python -c "import scipy;scipy.test()"
```
## 安装线性计算库、numPy和sciPy的编译方法（推荐）

### 编译安装OpenBlas
* 为什么安装OpenBLAS？因为OpenBLAS的速度比atlas快。速度对比请参考：[《Benchmark OpenBLAS, Intel MKL vs ATLAS》](https://github.com/tmolteno/necpp/issues/18)
* 下载OpenBLAS。[github下载地址](https://github.com/xianyi/OpenBLAS)
* 安装OpenBLAS
```bash
tar -zxvf OpenBLAS**.tar.gz
cd OpenBLAS***
make -FC gfortran #需要已经安装gfortran 
make install # 安装在/opt/OpenBLAS/目录下
```

### 安装numPy
* 下载numPy 。[github](https://github.com/numpy/numpy) [豆瓣镜像](http://pypi.douban.com/simple/numpy/)
* 解压下载包，并配置OpenBLAS。
```bash
tar -zxvf numpy***.tar.gz
cd numpy***
cp site.cfg.example site.cfg
vi site.cfg
#将以下4行去掉注释。【101行--104行】
#[openblas]
#libraries = openblas
#library_dirs = /opt/OpenBLAS/lib
#include_dirs = /opt/OpenBLAS/include
```
* 安装numPy。
```
sudo python setup.py config
sudo python setup.py build
sudo python setup.py install 
```
### 安装sciPy
* 下载sciPy 。[github](https://github.com/numpy/scipy) [豆瓣镜像](http://pypi.douban.com/simple/scipy/)
* 解压下载包，并配置OpenBLAS。
```bash
tar -zxvf scipy***.tar.gz
cd scipy***
# 将numPy**中的配置文件复制到此处
cp ../numpy**/site.cfg.example ./site.cfg
```
* 安装sciPy。
```
sudo python setup.py config
sudo python setup.py build
sudo python setup.py install 
```

## 安装其它库
* 为了安装Theano，最后还需要安装一些库，可以参考[官方教程](http://deeplearning.net/software/theano/install_ubuntu.html#install-ubuntu)
```bash
sudo apt-get install python-dev
sudo apt-get install python-pip
sudo apt-get install python-nose
sudo apt-get install g++
sudo apt-get install git 

```

## 安装Theano
* 前面的操作如果没有出现错误，就可以开始安装Theano了。命令如下所示。
```bash
# 安装Theano
sudo pip install Theano

# 测试Theano
python -c "import theano;theano.test()"
```

## 引用
* [ATLAS + NumPy + SciPy + Theano 的python科学计算环境搭建 ](http://blog.sina.com.cn/s/blog_6cb8e53d0101keak.html)
* [Compiling numpy with OpenBLAS integration](http://stackoverflow.com/questions/11443302/compiling-numpy-with-openblas-integration)
* [依赖关系](http://www.tuicool.com/articles/Ub6vqiQ)
* [官方安装教程](http://deeplearning.net/software/theano/install.html#install)
* http://stackoverflow.com/questions/7496547/does-python-scipy-need-blas
* http://www.linuxidc.com/Linux/2014-10/107503.htm
* http://www.scipy.org/scipylib/building/linux.html#installation-from-source

