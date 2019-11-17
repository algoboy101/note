# caffe安装系列——安装NVIDIA显卡驱动

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


## 0.版本说明
* cuda6.5 ***NVIDIA-Linux-x86_64-346.xx*** (Ubuntu 14.04)
* cuda7.0 ***NVIDIA-Linux-x86_64-346.xx*** (Ubuntu 14.04)
* cuda7.5 ***NVIDIA-Linux-x86_64-352.xx*** (Ubuntu 15.04)

## 1.使用apt-get安装
* 安装32位兼容包
```
# 32位兼容包
# 为什么呢？安装二进制安装包时，提示是否安装32bit兼容包，因此，最好安装上32兼容包，以后操作系统上安装32bit软件也方便啊。。。
sudo apt-get install lib32z1 
```
* 关闭图形显示管理器
```
# 需要关闭图形显示管理器（Display Manager）。显卡，当然和显示有关喽，因此最好关闭图形显示管理器。
stop lightdm 
```
* 安装显卡驱动
```
# 安装显卡驱动。截止目前为止，346显卡驱动是Ubuntu可以通过apt-get安装的最新显卡驱动，也是cuda7.0支持的最低显卡驱动版本。
sudo apt-get install nvidia-346
```
* 重启电脑，检查是否成功
	* 电脑重启后，命令行中输入`cat /proc/driver/nvidia/version`查看显卡信息。如下图所示
	* 如果/proc/driver/目录下没有nvidia目录，说明nvidia显卡驱动没有加载，也就意味着安装失败。请参考其它教程，保证安装完成。
![这里写图片描述](http://img.blog.csdn.net/20150922092210340)
* 注意：务必成功安装显卡驱动之后，再继续其它步骤，否则。。。。
* 注意：先将GCC和G++降级，然后再安装驱动。

## 2.使用二进制安装包安装
* 下载驱动
* 参考[《Ubuntu-安装-cuda7.0-单显卡-超详细教程》](http://blog.csdn.net/xuezhisdc/article/details/47075401)安装。。。