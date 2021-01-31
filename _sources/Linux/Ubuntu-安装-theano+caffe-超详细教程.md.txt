# Ubuntu-安装-theano+caffe-超详细教程

## 一、说明
* 本文是继[《Ubuntu-安装-cuda7.0-单显卡-超详细教程》 ](http://blog.csdn.net/xuezhisdc/article/details/47075401)之后的续篇。theano和caffe是深度学习库，对运算能力需求很大，最好使用cuda进行加速。所以，请先阅读《Ubuntu-安装-cuda7.0-单显卡-超详细教程》，成功安装cuda之后，再来安装theano和caffe。

<!-- more -->

## 二、安装Theano

### 1. 安装各种包
* 安装gfortran, numpy, scipy, sklearn, blas, atlas等包
	```bash
	# 安装gfortran,后面编译过程中会用到
	sudo apt-get install gfortran
	
	# 安装blas,Ubuntu下对应的是libopenblas，其它操作系统可能需要安装其它版本的blas——这是个OS相关的。
	sudo apt-get install libopenblas-dev
	
	# 安装lapack，Ubuntu下对应的是liblapack-dev，和OS相关。
	sudo apt-get install liblapack-dev
	
	# 安装atlas，Ubuntu下对应的是libatlas-base-dev，和OS相关。
	sudo apt-get install libatlas-base-dev
	
	# 安装pip
	sudo apt-get install python-pip
	sudo apt-get install python-dev
	sudo apt-get install python-nose
	sudo apt-get install g++
	sudo apt-get install git 
	```
### 2. 安装numpy和scipy
* 安装这两个python库有点问题，如果使用apt-get安装，后面的test不能通过。如果使用pip安装，有得考虑各种依赖关系。

* 所以，先使用apt-get安装，然后再卸载，最后再使用pip安装。这样，既能不考虑依赖关系，又能通过后面的test()测试。

	```bash
	#安装numpy和scipy
	sudo apt-get install python-numpy
	sudo apt-get install python-scipy
	sudo apt-get install python-sklearn
	#卸载numpy和scipy
	sudo apt-get remove python-numpy
	sudo apt-get remove python-scipy
	# 安装numpy
	sudo pip install numpy
	# 测试numpy
	# 如果没有安装python-nose，测试会出错！
	python -c "import numpy;numpy.test()"
	# 安装scipy
	sudo pip install scipy
	# 测试scipy
	python -c "import scipy;scipy.test()"
	```
### 3. 安装Theano
* 前面的操作如果没有出现错误，就可以开始安装Theano了。命令如下所示。

	```bash
	# 安装Theano
	sudo pip install Theano
	# 测试Theano
	python -c "import theano;theano.test()"
	```
### 4. 安装pyCUDA
* 测试Theano时，提示PyCUDA import错误，因此需要安装pyCUDA。而PyCUDA需要以Boost为基础，所以应该先安装Boost。
* 使用pip安装pyCUDA。

	```bash
	#安装boost
	sudo apt-get install libboost-all-dev
	```

* 如果使用pip安装pyCUDA出错，使用下面安装方式。[参考文章：《Ubuntu Theano CUDA》](http://seraphli.insecterswar.com/archives/771)

	```bash
	git clone --recursive http://git.tiker.net/trees/pycuda.git
	cd pycuda
	sudo ./configure.py --cuda-root=/usr/local/cuda --cudadrv-lib-dir=/usr/lib/x86_64-linux-gnu --boost-inc-dir=/usr/include --boost-lib-dir=/usr/lib --boost-python-libname=boost_python --boost-thread-libname=boost_thread --no-use-shipped-boost
	make -j 4 #电脑核数
	sudo python setup.py install
	```
### 5. 解决cuda_ndarray.cu错误
* 如果出现错误：***ERROR (theano.sandbox.cuda): Failed to compile cuda_ndarray.cu: libcublas.so.6.5 cannot open shared object file: No such file or directory***，需要运行以下命令：

	```bash
	sudo ldconfig /usr/local/cuda-7.0/lib64
	```


### 6. 配置Theano
* 在主目录下新建.theanorc文件

	```bash
	cd ~
	vi .theanorc
	```
* 在.theanorc中输入下面的内容

	```
	[cuda]
	root=/usr/local/cuda/bin/
	[global]
	floatX = float32
	device = gpu0
	[nvcc]
	fastmath = True
	```

### 7. 测试Theano是否在使用GPU
* 将下列python代码复制到useGPU.py，并运行。

	```python
	from theano import function, config, shared, sandbox
	import theano.tensor as T
	import numpy
	import time
	
	vlen = 10 * 30 * 768  # 10 x #cores x # threads per core
	iters = 1000
	
	rng = numpy.random.RandomState(22)
	x = shared(numpy.asarray(rng.rand(vlen), config.floatX))
	f = function([], T.exp(x))
	print f.maker.fgraph.toposort()
	t0 = time.time()
	for i in xrange(iters):
	    r = f()
	t1 = time.time()
	print 'Looping %d times took' % iters, t1 - t0, 'seconds'
	print 'Result is', r
	if numpy.any([isinstance(x.op, T.Elemwise) for x in f.maker.fgraph.toposort()]):
	    print 'Used the cpu'
	else:
	    print 'Used the gpu'
	```
* 假定上面已经设置文件`.theanorc`，运行命令如下所示：

	```bash
	python useGPU.py
	```
* 如果出现下面的错误信息，请运行命令`sudo ldconfig /usr/local/cuda-7.0/lib64`[参考](http://seraphli.insecterswar.com/archives/category/dev/code) 

	```
	#错误信息
	ERROR (theano.sandbox.cuda): Failed to compile cuda_ndarray.cu: libcublas.so.7.0: cannot open shared object file: No such file or directory
	```
### Theano相关资料
* 参考：[Using the GPU](http://deeplearning.net/software/theano/tutorial/using_gpu.html) & [THEANO_FLAGS](http://deeplearning.net/software/theano/library/config.html#envvar-THEANO_FLAGS) & [THEANORC](http://deeplearning.net/software/theano/library/config.html#envvar-THEANORC)
* CUDA Toolkit默认安装在`/usr/local/cuda/`，含有bin, lib, include等子文件夹。`/usr/local/cuda/bin/`文件夹称为cuda root文件夹。 
* 使用Theano时，必须告诉它CUDA root文件夹，有3种方法：
	* 定义$CUDA_ROOT环境变量。例如， `CUDA_ROOT=/usr/local/cuda/bin/`
	* 在THEANO_FLAGS中添加cuda.root标识。例如，`THEANO_FLAGS='cuda.root=/usr/local/cuda/bin/'`
	* 在.theanorc文件夹中添加[cuda]

			[cuda]
			root=/usr/local/cuda/bin/

* 还需要更改设备选项(*gpu* or *gpu0* or *gpu1*)，设置默认的浮点计算类型(float32)
	* 方法一：
    THEANO_FLAGS='cuda.root=/usr/local/cuda/bin/,device=gpu,floatX=float32'
	* 方法二：
    设置`.theanorc`文件的[global]选项:

			[cuda]
			root=/usr/local/cuda/bin/
			[global]
			device = gpu
			floatX = float32
* 注意：
	* 如果电脑有多个GPU，而配置是‘device=gpu’，驱动会选择其中一个使用（一般是 `gpu0`）。可以使用 nvida-smi 改变这一规则。
	* 可以通过指定 ‘device=gpuX’来选择一个特定的GPU。
	* 默认使用GPU计算。如果GPU有问题，Theano会退回使用CPU。可以通过设置标识‘force_device=True’，当GPU不能使用时，弹出错误信息。


## 安装OpenCV

### 下载OpenCV
* 下载地址：https://github.com/jayrambhia/Install-OpenCV，这是根据大神编译过的版本进行安装的。
* 切换到文件保存的文件夹，然后安装依赖项：
```bash
#切换路径
cd ~/Downloads/Install-OpenCV-master/Ubuntu
#安装OpenCV的依赖项
sudo ./dependencies.sh
```
* 修改opencv2_4_9.sh
*  [参考 Ubuntu14.04安装ffmpeg](http://redstarofsleep.iteye.com/blog/2122612)         [ffmpeg下载地址](https://www.ffmpeg.org/download.html)
* 如果不添加CUDA_GENERATION，编译过程会失败 [参考文章](http://blog.csdn.net/sysuwuhongpeng/article/details/45485719)
```
#切换路径
cd 2.4
#修改opencv2_4_9.sh, 添加CUDA_GENERATION
#根据显卡支持Fermi或Kepler做相应的修改。此处以Fermi为例。
sudo gedit opencv2_4_9.sh
```
* 将以下内容
```
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_TBB=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D WITH_V4L=ON -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON -D BUILD_EXAMPLES=ON -D WITH_QT=ON -D WITH_OPENGL=ON -D ..
```
* 修改为:
```
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_TBB=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D WITH_V4L=ON -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON -D BUILD_EXAMPLES=ON -D WITH_QT=ON -D WITH_OPENGL=ON -D CUDA_GENERATION=Fermi ..
```

* 即在最后的`..`前面添加***`CUDA_GENERATION=Fermi`***
* 安装最新版opencv2_4_9
```
#添加执行权限
sudo chmod +x opencv2_4_9.sh
#安装OpenCV
sudo ./opencv2_4_9.sh
```

* 等待.....，直到安装完成。如下图所示。
![这里写图片描述](http://img.blog.csdn.net/20150731210950383)

## 安装其它依赖项
* 执行以下命令，安装其它依赖项
```
sudo apt-get install libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libboost-all-dev libhdf5-serial-dev libgflags-dev libgoogle-glog-dev liblmdb-dev protobuf-compiler protobuf-c-compiler  python-pandas 
```

## 安装glog

1. Google Logging Library（glog），下载地址：https://code.google.com/p/google-glog/，然后解压安装：
```
$ tar zxvf glog-0.3.3.tar.gz
$ ./ configure
$ make
$ sudo make install
```

## 安装caffe

### 下载caffe
* 下载地址：https://github.com/BVLC/caffe

### 编辑Makefile.config
* 参考：
http://caffe.berkeleyvision.org/installation.html  http://ouxinyu.github.io/Blogs/20140723001.html
* 执行以下命令，通过设置Makefile.config文件，来使用CuDNN来加速。
```
unzip caffe-master.zip #本地解压caffe-master
cd /caffe-master #切换路径
vi Makefile.config #编辑Makefile.config
```
* 开始编辑Makefile.config
	* 取消第5行的注释，即将 ***#USE_CUDNN=1*** 改为 ***USE_CUDNN=1***
	* 将 ***BLAS=atlas*** 改为 ***BLAS=open***

执行以下命令，

### 配置Python相关选项
* 安装python依赖库
```
cd python #切换到./caffe-master/python/路径下
for req in $(cat requirements.txt); do sudo pip install $req; done
```
* 设置Python环境变量
```
sudo vi /etc/profile # 编辑profile文件
#在最后面添加以下语句，注意将path换成你的系统下的路径
export PYTHONPATH=/path/to/caffe/python:$PYTHONPATH
```

### 安装Matlab
* 选择Mathworks.Matlab.R2014a.Unix.iso - 右键 - 使用磁盘映像挂载器打开”
* 进入装载的虚拟光盘，拷贝全部文件至home/Matlab 文件夹
3. 授权安装文件夹
` $ chmod a+x Matlab -R`
4. 安装
`$ sudo ./install`
拷贝 libmwservices.so 至 /usr/local/MATLAB/R2014a/bin/glnxa64
```
$ sudo cp libmwservices.so /usr/local/MATLAB/R2014a/bin/glnxa64/
安装完毕，程序默认启动路径：
$ sh /usr/local/MATLAB/R2014a/bin/matlab
```

## 参考文章
* [Ubuntu14.04安装Theano详细教程 ](http://blog.csdn.net/xuezhisdc/article/details/47065475)
* [caffe官方安装教程](http://caffe.berkeleyvision.org/installation.html)
* [Caffe + Ubuntu 14.04 64bit + CUDA 6.5 配置说明](http://www.cnblogs.com/platero/p/3993877.html)
* [Caffe在Ubuntu 14.04 64bit 下的安装](http://www.linuxidc.com/Linux/2015-07/120449.htm)
* [Ubuntu Theano CUDA](http://seraphli.insecterswar.com/archives/category/dev/code) 
* [Unsupported gpu architecture 'compute_11'解决方法](http://blog.csdn.net/sysuwuhongpeng/article/details/45485719)
* [Caffe + Ubuntu 15.04 + CUDA 7.0 新手安装配置指南(推荐)](https://ouxinyu.github.io/Blogs/20140723001.html)