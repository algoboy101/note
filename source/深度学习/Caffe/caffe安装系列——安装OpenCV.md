# caffe安装系列——安装OpenCV

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
* [准备工作](http://zhangxuezhi.com/2015/09/24/caffe%E5%AE%89%E8%A3%85%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E7%BB%BC%E8%BF%B0/)
* [安装GCC4.7和G++4.7并降级](http://zhangxuezhi.com/2015/09/22/caffe%E5%AE%89%E8%A3%85%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E5%AE%89%E8%A3%85GCC4.7%E5%92%8CG++4.7%E5%B9%B6%E9%99%8D%E7%BA%A7/)
* [安装显卡驱动](http://zhangxuezhi.com/2015/09/24/caffe%E5%AE%89%E8%A3%85%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E5%AE%89%E8%A3%85NVIDIA%E6%98%BE%E5%8D%A1%E9%A9%B1%E5%8A%A8/)
* [安装cuda和cudnn](http://zhangxuezhi.com/2015/09/22/caffe%E5%AE%89%E8%A3%85%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E5%AE%89%E8%A3%85cuda%E5%92%8Ccudnn/)
* [安装Matlab](http://zhangxuezhi.com/2015/09/23/caffe%E5%AE%89%E8%A3%85%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E5%AE%89%E8%A3%85Matlab/)
* [安装OpenCV](http://zhangxuezhi.com/2015/09/24/caffe%E5%AE%89%E8%A3%85%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E5%AE%89%E8%A3%85OpenCV/)
* [安装Python依赖包](http://zhangxuezhi.com/2015/09/24/caffe%E5%AE%89%E8%A3%85%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E5%AE%89%E8%A3%85python%E4%BE%9D%E8%B5%96%E5%8C%85/)
* [安装caffe](http://zhangxuezhi.com/2015/10/13/caffe%E5%AE%89%E8%A3%85%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E5%AE%89%E8%A3%85caffe/)


## 安装OpenCV
* 安装前，请下载我的安装脚本,如下图所示。[点此下载](http://pan.baidu.com/s/1geAezRH)
![这里写图片描述](http://img.blog.csdn.net/20150923231755240)
* 这个脚本是我根据GitHub上大神写的[安装OpenCV的脚本](https://github.com/jayrambhia/Install-OpenCV)改造的，这个脚本有一些问题，有些包安装不上，比如mmfpeg，有些包前后安装相互冲突，后面的会把前面的卸载等等。
* 使用这个脚本的方法就是，先给5个脚本执行权限`chmod +x *.sh`，然后依照顺序执行这些脚本。
* 执行1dependeccies.sh的方法是`sudo sh 1dependencies.sh`。这个脚本主要是安装OpenCV的一些依赖库。

```bash
#!/bin/bash
#edited by xuezhi zhang.
echo "--- Removing any pre-installed ffmpeg and x264"
sudo apt-get -qq remove ffmpeg x264 libx264-dev
#function install_dependency {
#    echo "--- Installing dependency: $1"
#    sudo apt-get -y install $1
#}
echo "Installing dependency"
sudo apt-get -y install libopencv-dev
sudo apt-get -y install build-essential
# conflict
#sudo apt-get -y install checkinstall
sudo apt-get -y install cmake
sudo apt-get -y install pkg-config
sudo apt-get -y install yasm
sudo apt-get -y install libjasper-dev
sudo apt-get -y install libavcodec-dev
sudo apt-get -y install libavformat-dev
sudo apt-get -y install libswscale-dev
sudo apt-get -y install libdc1394-22-dev
sudo apt-get -y install libxine-dev
#echo "===================================================="
# conflict with libxine-dev
#sudo apt-get -y install libxine2-dev
sudo apt-get -y install libgstreamer0.10-dev
sudo apt-get -y install libgstreamer-plugins-base0.10-dev
sudo apt-get -y install libv4l-dev
sudo apt-get -y install python-dev
sudo apt-get -y install python-numpy
sudo apt-get -y install python-scipy
sudo apt-get -y install  python-sphinx
sudo apt-get -y install libtbb-dev
sudo apt-get -y install libqt4-dev
sudo apt-get -y install libgtk2.0-dev
sudo apt-get -y install libfaac-dev
sudo apt-get -y install libmp3lame-dev
sudo apt-get -y install libopencore-amrnb-dev
sudo apt-get -y install libopencore-amrwb-dev
sudo apt-get -y install libtheora-dev
sudo apt-get -y install libvorbis-dev
sudo apt-get -y install libxvidcore-dev
sudo apt-get -y install x264
sudo apt-get -y install v4l-utils
sudo apt-get -y install unzip
sudo apt-get -y install libgtk2.0-0
sudo apt-get -y install libjpeg-dev
sudo apt-get -y install libjpeg62 
# conflict
#sudo apt-get -y install libjpeg62-dev
sudo apt-get -y install libtiff4-dev
sudo apt-get -y install libtiff5-dev
sudo apt-get -y install qt5-default
echo "===================================================="
echo "^^^^^^^^^^^^^^^^^^^^^^Over^^^^^^^^^^^^^^^^^^^^^^^^^^"
echo "===================================================="

#install_dependency ffmpeg
#install fail, run file of ffmpeg_install to install it
```

* 执行2download.sh的方法是`sudo sh 2download.sh`。这个脚本主要是下载一个安装包，为后面编译安装做准备。
* 执行2download.sh前，修改一下脚本，选择opencv-2.4.11和opencv-3.0.0，注释（#）另外一个就OK。

```bash
echo "===================================================="
echo "--- Dowloading v4l-utils"
echo "===================================================="
wget http://www.linuxtv.org/downloads/v4l-utils/v4l-utils-0.8.5.tar.bz2

echo "===================================================="
echo "--- Dowloading mmfpeg-2.8"
echo "===================================================="
wget http://ffmpeg.org/releases/ffmpeg-2.8.tar.bz2
echo "===================================================="
echo "Downloading OpenCV"
echo "===================================================="
# opencv-2.4.11和opencv-3.0.0根据自己的需要，选择下载一个就OK了。
# 下载 opencv-2.4.11.zip
wget -O opencv-2.4.11.zip http://sourceforge.net/projects/opencvlibrary/files/opencv-unix/2.4.11/opencv-2.4.11.zip/download
# 下载 opencv-3.0.0
#wget -O opencv-3.0.0.zip http://sourceforge.net/projects/opencvlibrary/files/opencv-unix/3.0.0/opencv-3.0.0.zip/download

```

* 执行3mmfpeg_install.sh的方法是`sudo sh 3mmfpeg_install.sh`。这个脚本主要是安装mmfpeg。为后面安装OpenCV做准备。
* 因为mmfpeg不能使用apt-get安装，因此需要自己编译安装。

```bash
echo "===================================================="
echo "Installing dependency"
echo "===================================================="
sudo apt-get install -y libx264-dev libxext-dev libxfixes-dev

echo "===================================================="
echo "--- Configure mmfpeg-2.8"
echo "===================================================="
tar -xf ffmpeg-2.8.tar.bz2
cd ffmpeg-2.8
./configure --prefix=/usr/local/ffmpeg --enable-gpl --enable-version3 --enable-nonfree --enable-postproc --enable-pthreads --enable-libfaac --enable-libmp3lame --enable-libtheora --enable-libx264 --enable-libxvid --enable-x11grab --enable-libvorbis

echo "===================================================="
echo "--- Making mmfpeg-2.8"
echo "===================================================="
make -j

echo "===================================================="
echo "--- Installing mmfpeg-2.8"
echo "===================================================="
make install
cd ..
```

* 执行4v4l_install.sh，安装v4l。

```bash
echo "===================================================="
echo "---Installing v4l---"
echo "===================================================="
#wget http://www.linuxtv.org/downloads/v4l-utils/v4l-utils-0.8.5.tar.bz2
tar -xvf v4l-utils-0.8.5.tar.bz2
cd v4l-utils-0.8.5
make -j
sudo make install
cd ..
```

* 安装OpenCV有两个选择，OpenCV2.4.11和OpenCV3.0.0，分别对应于5opencv2411.sh和5opencv300.sh，根据自己的需要选择执行哪个脚本。【注意：和前面2download.sh中下载的版本保持一致】
* 注意根据自己的显卡，修改 CUDA_GENERATION。如果是Fermi架构，就需要将Kepler修改成Fermi
* 安装opencv2.4.11之前，根据最下面的错误分析中的错误1，修改opencvpath/cmake/OpenCVDetectCUDA.cmake文件之后，再执行脚本，否则可能出错。

```bash
# added by xuezhi zhang.
# 
# OpenCV 2.4.11
# http://vinayhacks.blogspot.com.es/2011/11/installing-opencv-231-with-ffmpeg-on-64.html
echo "===================================================="
echo "Installing OpenCV"
echo "===================================================="

sudo unzip opencv-2.4.11.zip
cd opencv-2.4.11
sudo mkdir build
cd build
# 注意根据自己的显卡，修改 CUDA_GENERATION。如果是Fermi架构，就需要将Kepler修改成Fermi
sudo cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_TBB=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D WITH_V4L=ON -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON -D BUILD_EXAMPLES=ON -D WITH_QT=ON -D WITH_OPENGL=ON CUDA_GENERATION=Kepler ..
#make -j 32
sudo make -j
sudo make install
sudo sh -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf'
sudo ldconfig
echo "OpenCV ready to be used"
```

## 判定OpenCV是否安装成功
* 安装过程中如果没有返回错误，说明安装没有问题，如果有任何错误提示，请自行Google解决。
* 安装成功之后，如下所示。
![这里写图片描述](http://img.blog.csdn.net/20150924090717807)

## OpenCV安装过程中的错误
* 因为OpenCV有很多依赖包，因此安装过程非常的复杂。如果依赖的包没有安装，或者操作系统的编译环境有问题的话，很造成容易编译失败。
* ***错误1： cannot build OpenCV 2.4.11 with CUDA 7.0***
* 这个问题已经解决，[参考网址](https://github.com/Itseez/opencv/pull/3886)。
* 这是一个和cuda的架构1.1（cuda7.0不再支持架构1.x）有关的错误，通过修改opencvpath/cmake/OpenCVDetectCUDA.cmake文件解决。如下图所示。
![这里写图片描述](http://img.blog.csdn.net/20150924091021080)
* ***错误2：error: a storage class is not allowed in an explicit specialization***
* 这是cuda和opencv版本不适应的错误。
* 这个问题也已经解决，[参考网址](http://code.opencv.org/issues/3814)。
* 因此，最好的组合方式【cuda7.0 + opencv3.0.】和【cuda6.5+opencv2.4.11】。这两种组合方法，我都已经在Ubuntu14.04操作系统（64位版本）上成功地安装了。
* 网上安装OpenCV的教程很多都是通过Install-OpenCV脚本来安装的，但我在使用过程中发现会出现问题，而网络教程有没有说明遇到问题如何解决，因此很坑。最终，借助Google，解决的所有问题，成功安装了所有依赖和OpenCV3.0。因此，如果大家遇到什么编译错误，不要害怕，google一下，一般别人已经遇到这个问题，并成功地解决了。

## 参考
* [《Caffe + Ubuntu 15.04 + CUDA 7.0 新手安装配置指南》](http://ouxinyu.github.io/Blogs/20140723001.html)——欧新宇 
* [opencv 项目](http://sourceforge.net/projects/opencvlibrary/files/opencv-unix/)
* [我的opencv安装脚本](http://pan.baidu.com/s/1mgH5dbE)
* [GitHub上的opencv安装脚本](https://github.com/jayrambhia/Install-OpenCV)