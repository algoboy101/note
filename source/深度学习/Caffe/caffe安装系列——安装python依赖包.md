# caffe安装系列——安装python依赖包

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
* [综述](https://blog.xuezhisd.top/%E6%B7%B1%E5%BA%A6%E5%AD%A6%E4%B9%A0/Caffe/caffe%E5%AE%89%E8%A3%85%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E7%BB%BC%E8%BF%B0.html)
* [安装GCC4.7和G++4.7并降级](https://blog.xuezhisd.top/%E6%B7%B1%E5%BA%A6%E5%AD%A6%E4%B9%A0/Caffe/caffe%E5%AE%89%E8%A3%85%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E5%AE%89%E8%A3%85GCC4.7%E5%92%8CG++4.7%E5%B9%B6%E9%99%8D%E7%BA%A7.html)
* [安装显卡驱动](https://blog.xuezhisd.top/%E6%B7%B1%E5%BA%A6%E5%AD%A6%E4%B9%A0/Caffe/caffe%E5%AE%89%E8%A3%85%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E5%AE%89%E8%A3%85NVIDIA%E6%98%BE%E5%8D%A1%E9%A9%B1%E5%8A%A8.html)
* [安装cuda和cudnn](https://blog.xuezhisd.top/%E6%B7%B1%E5%BA%A6%E5%AD%A6%E4%B9%A0/Caffe/caffe%E5%AE%89%E8%A3%85%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E5%AE%89%E8%A3%85cuda%E5%92%8Ccudnn.html)
* [安装Matlab](https://blog.xuezhisd.top/%E6%B7%B1%E5%BA%A6%E5%AD%A6%E4%B9%A0/Caffe/caffe%E5%AE%89%E8%A3%85%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E5%AE%89%E8%A3%85Matlab.html)
* [安装OpenCV](https://blog.xuezhisd.top/%E6%B7%B1%E5%BA%A6%E5%AD%A6%E4%B9%A0/Caffe/caffe%E5%AE%89%E8%A3%85%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E5%AE%89%E8%A3%85OpenCV.html)
* [安装Python依赖包](https://blog.xuezhisd.top/%E6%B7%B1%E5%BA%A6%E5%AD%A6%E4%B9%A0/Caffe/caffe%E5%AE%89%E8%A3%85%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E5%AE%89%E8%A3%85python%E4%BE%9D%E8%B5%96%E5%8C%85.html)
* [安装caffe](https://blog.xuezhisd.top/%E6%B7%B1%E5%BA%A6%E5%AD%A6%E4%B9%A0/Caffe/caffe%E5%AE%89%E8%A3%85%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E5%AE%89%E8%A3%85caffe.html)



## 安装theano依赖包
* 安装基本的依赖包
``` shell
# 安装ipython
# 安装gfortran,后面编译过程中会用到
# 安装blas,Ubuntu下对应的是libopenblas，其它操作系统可能需要安装其它版本的blas——这是个OS相关的。
# 安装lapack，Ubuntu下对应的是liblapack-dev，和OS相关。
# 安装atlas，Ubuntu下对应的是libatlas-base-dev，和OS相关。
# -y,遇到需要用户选择的项，都选y
sudo apt-get install -y ipython ipython-notebook pandoc 
sudo apt-get install -y gfortran libopenblas-dev liblapack-dev libatlas-base-dev 
# 安装pip
sudo apt-get install -y python-pip python-dev python-nose g++ git 
sudo apt-get install -y python-numpy python-scipy  
# 自己编译的原因是，防止theano出错
# 使用豆瓣的python源，下载速度快
sudo pip install numpy -i http://pypi.douban.com/simple 
sudo pip install scipy -i http://pypi.douban.com/simple 
# 查看目录/tmp/pip_build_root
sudo apt-get install -y python-matplotlib python-sklearn python-sklearn-lib 
```

* 安装boost和pyCUDA

```bash
# 安装boost和和pyCUDA。pyCUDA需要boost。
sudo apt-get install -y libboost-all-dev 
# 下载pycuda源代码
git clone --recursive http://git.tiker.net/trees/pycuda.git
cd pycuda
sudo ./configure.py --cuda-root=/usr/local/cuda --cudadrv-lib-dir=/usr/lib/x86_64-linux-gnu --boost-inc-dir=/usr/include --boost-lib-dir=/usr/lib --boost-python-libname=boost_python --boost-thread-libname=boost_thread --no-use-shipped-boost 
#多核编译
make -j 
#安装
sudo python setup.py install
```

* 安装Theano

```bash
sudo pip install theano -i http://pypi.douban.com/simple
```

* 安装pyCaffe需要的依赖

```bash
# 使用apt-get安装大多数包
sudo apt-get install -y python-numpy python-scipy python-matplotlib python-sklearn python-skimage python-h5py python-protobuf python-leveldb python-networkx python-nose python-pandas python-gflags cython ipython python-yaml 
sudo apt-get install -y protobuf-c-compiler protobuf-compile
# 因为有些包使用apt-get安装失败，所以使用pip重新安装它们，防止后面编译caffe过程中报错。
sudo pip install protobuf --upgrade -i http://pypi.douban.com/simple
sudo pip install pillow --upgrade -i http://pypi.douban.com/simple
sudo pip install six --upgrade -i http://pypi.douban.com/simple
```
至此，安装python依赖包的工作已经完成。也没有什么检查安装成功的评价标准。

