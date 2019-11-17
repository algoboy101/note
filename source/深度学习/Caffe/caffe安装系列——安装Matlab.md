# caffe安装系列——安装Matlab

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

## 1. 下载Matlab
* 下载地址，请自行百度解决。太大了，不方便提供。
* 版本选择问题。最好下载较新的版本。比如R2014a，R2014b和R2015a等。
* 下载破解文件Crack文件。一般情况下，crack文件是包含在下载的Matlab安装镜像里面的——除非你下载的是MathWork公司提供的原版。如果里面没有crack文件，自行***Google***解决。

## 2. 安装Matlab
* Matlab安装过程请参考下面的连接（欧新宇）。里面给出了详细的教程。
* 说明几点：
	* Windows下安装Matlab，直接双击安装文件即可。但是，在Ubuntu中安装Matlab时，是***在命令行中安装***的。具体而言，在命令行中，切换到Matlab安装包路径下，执行`sudo ./install`，就会跳出安装会话框。
	* *Ubuntu安装Matlab需要在图形界面中操作*。如上所言，执行`sudo ./install`之后，会跳出图形对话框，如果是在纯粹的命令行上，应该无法进行。
	* 安装过程中，依次会提示**输入序列号**，**证书路径**。

* 切记：图形安装对话框结束之后，Matlab并没有安装完成。
	* 这时尝试打开Matlab会报错。通过在命令行中执行`matlab`，可以看到返回的错误信息是***没哟激活***。
	* 但是，你可能疑惑，为什么呢？最后激活步骤，明明导入了证书文件（*.lic）?!
	* 这是因为，我们使用的是盗版的的Matlab，所以还需要额外的一步：***替换libmwservices.so库文件***。
	* 替换需要在命令行中操作，还需要root权限（超级用户）。因为需要将libmwservices.so复制到`/usr/local/Matlab/R2014b/***`目录下，该目录属于root用户，所以需要在命令行中是，使用`cp`（或`mv`）命令完成。
	* 替换libmwservices.so之后就可以成功运行Matlab了。
```
sudo cp libmwservices.so /usr/local/MATLAB/R2014a/bin/glnxa64/
```

## 3.GCC和G++版本问题
* 前面[ 《caffe安装系列——安装GCC4.7和G++4.7并降级》](http://blog.csdn.net/xuezhisdc/article/details/48650015)介绍了如何实现GCC和G++降级，并提到了为什么这样操作——Ubuntu14.04版本默认的GCC和G++都是4.8。而Matlab默认支持的mex编译器是GCC4.7.x和G++4.7.x。因此需要额外安装GCC4.7和G++4.7并降级。
*请注意一点： [ 《caffe安装系列——安装GCC4.7和G++4.7并降级》](http://blog.csdn.net/xuezhisdc/article/details/48650015)实现了GCC和G++的降级，但是并没有更改任何的关于Matlab文件。Matalb要使用GCC4.7和G++4.7，还需要做一些工作——重新连接 libstdc++.so.6文件。
* 具体操作命令如下所示：
```
#拷贝文件
sudo cp /usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.20 /usr/local/MATLAB/R2014a/sys/os/glnxa64/libstdc++.so.6.0.20
# libstdc++.so.6.0.20的版本，可能因为系统不同而不同，使用最新的就可以了。Ubuntu14.04的最新版本是libstdc++.so.6.0.19。
# 切换路径
cd /usr/local/MATLAB/R2014a/sys/os/glnxa64/
# 修改权限
chmod 555 libstdc++.so.6.0.20
#（仅仅是备份，可以不操作）。
sudo mv libstdc++.so.6 libstdc++.so.6.backup 
# 重新链接
ln –s libstdc++.so.6.0.20 libstdc++.so.6
# 使配置生效
sudo ldconfig -v
```

## 4. 建立Matlab的快捷方式
* 新建一个文本文件（使用vi, gedit等），输入以下内容。退出保存。将该文件放到/home/yourname/Desktop/目录下，既可以看到Matlab的快捷方式。
```
[Desktop Entry]
Name=Matlab 2014b
Exec=/usr/local/MATLAB/R2014b/bin/matlab -desktop
Icon=/usr/local/MATLAB/R2014b/toolbox/nnet/nnresource/icons/matlab.png
Type=Application
```
* **Exec**是可执行文件，需要是绝对路径。
* **Icon**是图标，如果没有设置的话，不会显示Matlab的标志图标
* 以上路径根据自己安装路径更改。
* 快捷方式带一个小锁的问题。看看该文件的属主是谁，如果不是自己，使用`chown`命令将属主改为自己；如果没有执行权限，使用`chmod`命令增加可执行权限。


## 检查
* **检查Matlab是否安装成功。**
在命令行中输入matlab，回车。如果打开Matalb，说明安装成功。如果没有打开，将路径切换到Matlab安装路径下的bin文件夹下，再次执行matlab，如果还没有打开，就说明没有安装成功。如果任何一次打开了，就说明安装成功了。
* **检查GCC版本问题**。
通过命令`strings /usr/local/MATLAB/R2014a/sys/os/glnxa64/libstdc++.so.6 | grep GLIBCXX`，可以看一下，是否已经成功包含了GLIBCXX_3.4.20（Ubuntu14.04中是GLIBCXX_3.4.19），如果已经存在，基本上就成功了。


## 参考链接
* [《Caffe + Ubuntu 15.04 + CUDA 7.0 新手安装配置指南》](http://ouxinyu.github.io/Blogs/20140723001.html)——欧新宇 
* [ 《caffe安装系列——安装GCC4.7和G++4.7并降级》](http://blog.csdn.net/xuezhisdc/article/details/48650015)