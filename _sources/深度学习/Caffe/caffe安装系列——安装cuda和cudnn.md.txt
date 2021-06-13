# caffe安装系列——安装cuda和cudnn

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



## 安装cuda
* 参考[《Ubuntu-安装-cuda7.0-单显卡-超详细教程》](http://blog.csdn.net/xuezhisdc/article/details/47075401) [《Caffe + Ubuntu 15.04 + CUDA 7.0 新手安装配置指南》](http://ouxinyu.github.io/Blogs/20140723001.html)
* 注意1：安装cuda可以通过二进制安装包安装，也可以通过deb包在线安装。本文使用二进制安装包安装。
* 注意2：由于前面已经安装了**显卡驱动**，因此关于显卡驱动的选项，选择**no**，即不再安装显卡驱动。
```
# 安装依赖库
apt-get install freeglut3-dev build-essential libx11-dev libxmu-dev libgl1-mesa-dev libglu1-mesa libglu1-mesa-dev libxi-dev 
# 添加执行权限,并安装。注意不要重复安装显卡驱动。
# cuda**run根据自己下载的版本更改名称。
# 选择安装Cuda Samples，后边还会编译它。
# 选择创建软连接。cuda -> cuda7.0
stop lightdm
chmod a+x cuda_7.0.28_linux.run
sudo ./cuda_7.0.28_linux.run
```
* 修改/etc/profile文件，将cuda添加到环境变量中。【注：关于这一点，安装完cuda之后，命令行中有提示！！！细心看一下】
* 将/usr/local/cuda-7.0/bin添加到环境变量**PATH**路径中，这样一来，就可以在任何路径下调用cuda相关的可执行文件了。
* 将/usr/local/cuda7.0/lib64添加环境变量**LD_LIBRARY_PATH **中，作为共享库使用。这样一来，后面编译Cuda Samples 和OpenCV时，就不会提示找不到库的错误了。
* 操作1：将以下内容添加到文件**/etc/profile**的最后面，保存后，执行命令`source /etc/profile`，使配置生效。
```
PATH=/usr/local/cuda/bin:$PATH 
export PATH 
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64
export LD_ LIBRARY_PATH 
```
* 操作2：在目录`/etc/ld.so.conf.d/`下新建文件 **cuda.conf**，并添加如下内容。然后执行命令`sudo ldconfig`，使配置生效。
* 解释：下面第一行是上面提到的cuda库文件路径，后面3行是后来综合调试错误和其它博文总结得到的。所以，最好加上，省的出错哦。。。
```
/usr/local/cuda/lib64
/lib
/usr/lib
/usr/lib32
```

* 检查cuda是否配置好,在命令行中执行以下命令。
```
#输入以下命令，检查是否配置好。如下图所示，说明安装好。
nvcc --version
```
![这里写图片描述](http://img.blog.csdn.net/20150922143811428)

## 安装CUDA SAMPLES
* ***为什么安装cuda samples?***
* 一方面为了后面学习cuda使用，另一方面，可以检验cuda是否真的安装成功。如果cuda samples全部编译通过，没有一个Error（Warning忽略），那么就说明成功地安装了cuda。但如果没有通过编译，或者虽然最后一行显示***PASS***，但是编译过程中有ERROR，请自行GOOGLE解决之后，再向下安装，否则**失之毫厘谬以千里**！！！

* make时，请使用`make -j`，可以最大限度的使用cpu编译，加快编译的速度。
```
# 切换到cuda-samples所在目录
# 注意，换成自己的路径
cd /home/xuezhisd/NVIDIA_CUDA-7.0_Samples
# 编译 make （安装命令 sudo apt-get install cmake)
make –j 
# 编译完毕，切换release目录
cd ./bin/x86_64/linux/release
# 检验是否成功
# 运行实例 ./deviceQuery
./deviceQuery 
# 可以认真看看自行结果，它显示了你的NVIDIA显卡的相关信息。
```
* ./deviceQuery执行结果如下图所示：
![这里写图片描述](http://img.blog.csdn.net/20160829100835693)
* ***一个Error例子***
* 安装CUDA SAMPLES的过程中，可能会出现错误“/usr/bin/ld: cannot find –lGL”
* 通过Google搜索，找到以下解决方法：
```
locate libGL.so
# 返回结果
#/usr/lib/i386-linux-gnu/mesa/libGL.so.1
#/usr/lib/i386-linux-gnu/mesa/libGL.so.1.2.0
sudo ln -s /usr/lib/i386-linux-gnu/mesa/libGL.so.1.2.0 /usr/lib/libGL.so
```
* 但是，依然不能编译通过。忽略进行后面的步骤，依然会提示一些*.so文件找不到。最终在OpenCV那里完全无法再安装了，返回卸掉***卸载NVIDIA DRIVER 和cuda，重新安装驱动和cuda***，成功地编译cuda samples。
* 安装的驱动的方法是在命令行中执行：
```
sudo stop lightdm 
sudo apt-get install nvidia-346
```
* 然后将libGLobal.so链接到nvidia提供的libGLobal.so.346.82。后面编译cuda samples和opencv过程中顺利通过。
```
sudo ln –s /usr/lib/nvidia-346-updates/libGL.so.346.82 /usr/lib/libGL.so
```
* 即使用NVIDIA提供的libGL.so可以完成编译，不再报错。

* 注意：上面这个错误，就是在先装显卡驱动，后装gcc4.7过程遇到的。所以，请先安装gcc4.7和g++4.7，然后再安装NVDIA显卡驱动，再安装cuda。

## 安装cudnn
* 安装cudnn比较简单，简单地说，就是复制几个文件：库文件和头文件。将cudnn的头文件复制到cuda安装路径的include路径下，将cudnn的库文件复制到cuda安装路径的lib64路径下。
```
#解压文件
tar -zxvf cudnn-6.5-linux-x64-v2.tgz
#切换路径
cd cudnn-6.5-linux-x64-v2
#复制lib文件到cuda安装路径下的lib64/
sudo cp lib* /usr/local/cuda/lib64/
#复制头文件
sudo cp cudnn.h /usr/local/cuda/include/

#更新软连接
cd /usr/local/cuda/lib64/ 
sudo rm -rf libcudnn.so libcudnn.so.6.5 
sudo ln -s libcudnn.so.6.5.48 libcudnn.so.6.5 
sudo ln -s libcudnn.so.6.5 libcudnn.so 
```
* 到目前为止，cudnn已经安装完了。但是，是否安装成功了呢，还得通过下面的cudnn sample测试。
```
#运行cudnn-sample-v2
tar –zxvf cudnn-sample-v2.tgz
cd cudnn-sample-v2
make
./mnistCUDNN
#改程序运行成功，说明cudnn安装成功。
```
* 此时可能出现错误：***./mnist CUDNN: error while loading shared libraries: libcudart.so.6.5: cannot ope***
* 解决方法参考 https://groups.google.com/forum/#!topic/caffe-users/dcZrE3-60mc

* 方法1：在命令行中执行
`export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64`
* 方法2：在/etc/profile文件最后添加`export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64`, 并在命令行中执行`source /etc/profile`。
 
