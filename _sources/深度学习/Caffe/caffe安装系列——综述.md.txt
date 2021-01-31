# caffe安装系列——综述

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


## 0.准备工作
* 安装Ubuntu 14.04（15.04）,最好安装较新版本的Ubuntu。为什么选择Ubuntu呢？一方面，个人使用习惯，感觉Ubuntu安装软件等特别方便，使用特别顺手；另一方面，caffe项目最初貌似在Ubuntu上开发的，原生嘛。
* 安装过程需要下载东东，因此需要**联网**。

## 1.安装GCC4.7和G++4.7并降级
* ***为什么要先安装GCC和G++，并需要降级呢？***
* Ubuntu14.04版本默认的GCC和G++都是4.8。而Matlab默认支持的mex编译器是GCC4.7.x和G++4.7.x。因此需要额外安装GCC4.7和G++4.7并降级。
* ***为什么需要先安装编译器GCC和G++，而不是先安装显卡驱动和cuda等等呢？***
* 首先，先安装显卡驱动，后安装GCC并降级的安装顺序过程中，遇到了很多问题。比如，在安装CUDA SAMPLES的过程中，遇到了问题**/usr/bin/ld: cannot find –lGL**，后面通过网上教程，重新连接该库文件，仍然不能通过OpenCV的编译。但是，先安装GCC，再安装显卡驱动，就不会遇到这个问题了。
* 其次，请先看下图。这是在成功地安装完显卡驱动之后，查看加载的显卡的版本信息时返回的结果。注意，包含了GCC4.7.3。说明，显卡安装过程中，会和GCC的版本产生联系。。。。这也就不不难理解为什么在编译Cuda Samples过程中会遇到上面的问题。
![这里写图片描述](http://img.blog.csdn.net/20150922092210340)

* 所以，请先安装GCC4.7和G++4.7，然后在执行下面的步骤。

## 2.[安装NVIDIA显卡驱动](http://blog.csdn.net/xuezhisdc/article/details/48650565)
* ***为什么需要安装NVIDIA显卡驱动，Ubuntu没有自带的显卡驱动吗？***
    * Ubuntu自带的显卡驱动是开源的Nouveau，据说是一个比较烂的东东。而且，最关键的是cuda不支持Nouveau。如果想使用cuda进行GPU计算，必须安装NVIDIA显卡驱动。
* ***选择哪个版本的显卡驱动呢***
    * 这个问题需要结合操作系统，显卡和个人需求来讨论。
    * 操作系统影响显卡驱动的版本。比如，我在Ubuntu14.04 Server上安装NVIDIA-352显卡驱动，说是由于dkms，安装失败。目前，通过apt-get方式可以安装的最新NVIDIA显卡驱动是NVIDIA-346。
    * 显卡嘛，硬件当然要和驱动适应才行
    * 个人需求，主要从cuda的角度考虑。比如cuda7.5需要显卡驱动最低版本是nvidia-352；cuda7.0需要显卡驱动最低版本是nvidia-336；cuda6.5需要显卡驱动最低版本是nvidia-33*；其他的记不清楚啦。。。
* ***显卡驱动的安装方式有哪些***
    * 方法一：去NVIDIA官网下载相应的驱动二进制安装包，然后安装。
    * 方法二：通过`apt-get`来安装。
    * 区别：apt-get安装方便，但是不能安装最新的显卡驱动，目前ubuntu14.04通过apt-get可以安装nvidia-346显卡。
    * 安装过程中注意事项：①需要关闭显示管理器，②二进制安装需要修改文件，并重启。

## 3.[安装cuda和cudnn](http://blog.csdn.net/xuezhisdc/article/details/48651003)
* ***安装cuda的方式有哪些？***
    * 方法一：官网下载cuda开发包的二进制安装包进行安装。
    * 方法二：官网下载cuda开发包的deb文件进行安装。
* ***cuda版本的选择问题？***
    * 根据个人需求和操作系统来决定，显卡驱动版本。
    * cuda6.5是一个分界点，cuda6.5支持compute_11，compute_12. etc. compute_1X系列架构；从cuda7.0开始，不支持compute_1X系列架构，最低是compute_20架构。
    * cuda对显卡驱动有要求。比如cuda7.5需要显卡驱动最低版本是nvidia-352；cuda7.0需要显卡驱动最低版本是nvidia-336；cuda6.5需要显卡驱动最低版本是nvidia-33*；其他的记不清楚啦。因此，结合自己操作系统可以安装的NVIDIA显卡驱动来决定选择哪个版本的cuda。
* ***为什么安装cudnn？***
    * cudnn可以简单的理解为`CUDa cNN`，即在GPU上做卷积运算。最近几年，深度学习很火，尤其是CNN（卷积神经网络）。通过cudnn，可以极大的提高CNN训练速度。简单的说，实用GPU是为了快，实用cudnn是为了更快。
# 安装步骤
* 其它链接
* [综述](http://zhangxuezhi.com/2015/09/24/caffe%E5%AE%89%E8%A3%85%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E7%BB%BC%E8%BF%B0/)
* [安装GCC4.7和G++4.7并降级](http://zhangxuezhi.com/2015/09/22/caffe%E5%AE%89%E8%A3%85%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E5%AE%89%E8%A3%85GCC4.7%E5%92%8CG++4.7%E5%B9%B6%E9%99%8D%E7%BA%A7/)
* [安装显卡驱动](http://zhangxuezhi.com/2015/09/24/caffe%E5%AE%89%E8%A3%85%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E5%AE%89%E8%A3%85NVIDIA%E6%98%BE%E5%8D%A1%E9%A9%B1%E5%8A%A8/)
* [安装cuda和cudnn](http://zhangxuezhi.com/2015/09/22/caffe%E5%AE%89%E8%A3%85%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E5%AE%89%E8%A3%85cuda%E5%92%8Ccudnn/)
* [安装Matlab](http://zhangxuezhi.com/2015/09/23/caffe%E5%AE%89%E8%A3%85%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E5%AE%89%E8%A3%85Matlab/)
* [安装OpenCV](http://zhangxuezhi.com/2015/09/24/caffe%E5%AE%89%E8%A3%85%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E5%AE%89%E8%A3%85OpenCV/)
* [安装Python依赖包](http://zhangxuezhi.com/2015/09/24/caffe%E5%AE%89%E8%A3%85%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E5%AE%89%E8%A3%85python%E4%BE%9D%E8%B5%96%E5%8C%85/)
* [安装caffe](http://zhangxuezhi.com/2015/10/13/caffe%E5%AE%89%E8%A3%85%E7%B3%BB%E5%88%97%E2%80%94%E2%80%94%E5%AE%89%E8%A3%85caffe/)
的，深度学习的一大应用对象就是图像和视频。而OpenCV是目前最火的开源计算机视觉库，非常多的项目多用到了OpenCV，当然caffe也依赖OpenCV。所以，需要安装OpenCV，否则无法使用caffe哦。。。
* ***OpenCV安装简单吗？***
    * 答案是因人而异。有的人觉得简单，可以自己弄，有的人觉得难，没关系，大神们有写的安装脚本[点此*下载](https://github.com/jayrambhia/Install-OpenCV)，运行一下就OK了。
    * 但是，使用别人脚本安装的方法，也会遇到一些问题。如果遇到问题，请Google解决。
    * 最简单的方式是使用我修改过的脚本，按照顺序执行12345个脚本，基本不需要修改就能成功安装。
    * 最后提醒，安装OpenCV是挺麻烦的，请耐心安装，编译不过的话，查看错误Google，解决了再编译，一遍遍的尝试，最后就能解决问题了。
* ***应该安装OpenCV哪个版本呢？***
    * OpenCV的版本和cuda的版本最好匹配。这样子安排的目的是为了减少错误出现的概率。比如，我无错误编译成功的组合有【cuda7.0 + opencv3.0】，【cuda6.5+opencv2.11】。
    * 应该安装最新的，又不该安装最新的。呵呵，好别扭哦。针对于低版本的cuda，最好安装opencv2.x。而且是opencv2.x中最新的。
    * 低版本cuda安装opencv2.x的原因是，opencv的一些文件中涉及一些关于cuda架构的设置，opencv2.x中有支持相应的架构的配置。从这个角度看，cuda6.5是最保险的， 因为它既支持compute_1x，也支持更高的架构。


## 6.[安装Python相关依赖](http://blog.csdn.net/xuezhisdc/article/details/48706843)
* ***为什么要安装python相关依赖？？？***
    * 首先，python在linux中应用非常的广泛，很多项目都会涉及python，caffe也不例外。
    * 其次，caffe提供了python的接口，为了后面使用，也需要这些依赖。
* ***这些依赖都可以通过apt-get安装吗？***
    * 答案是否定的。
    * 首先，google一下`apt-get vs pip`，查看两者区别。
    * 其次，安装theano的时候，发现apt-get安装的numPy和sciPy无法通过测试，并且造成theano测试失败。使用pip安装成功。参考[《Ubuntu14.04安装Theano详细教程》](http://blog.csdn.net/xuezhisdc/article/details/47065475)。
    * 最后，在安装caffe的过程中，发现有几个python依赖包必须通过pip安装（即自行编译），否则无法成功地编译caffe。

## 7.[安装caffe](http://blog.csdn.net/xuezhisdc/article/details/48707101)
* 再重复一遍，请在上面所有步骤成功执行的前提下，安装caffe，否则编译肯定不会通过的。
* ***caffe源代码能不能直接拿过来编译呢？***
    * 不能。至少需要修改一个文件Makefile.config。该文件给caffe编译提供了必要的信息。
    * 如果opencv的版本是3.0，还需要修改其他项。
    * 其他的请参考安装caffe的教程

## 总结
* 至此，ubuntu下安装caffe的工作已经结束了。如果你完全按照本教程操作，相信你一定已经成功安装caffe了，并且对caffe有了一定的了解。
* ***世上无难事只怕有坚持***，安装过程虽然很复杂，但是只要坚持，不断的Google解决它，caffe就一定能安装。
* 错误不可怕，它是成功的障碍，同时也为我们成长提供了阶梯——所谓的能力，很大一部分是通过不断解决问题来获取的。
* 下面开始学习如何使用caffe做深度学习的研究喽，祝大家学习愉快。。。

## 参考
* [《Caffe + Ubuntu 15.04 + CUDA 7.0 新手安装配置指南》](http://ouxinyu.github.io/Blogs/20140723001.html)——欧新宇
这个教程很好，请查看本教程的过程中，结合欧新宇的教程一并查看。
* [《caffe - GitHub主页》](https://github.com/BVLC/caffe)