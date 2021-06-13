# caffe安装系列——安装GCC4.7和G++4.7并降级

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


## 安装GCC4.7和G++4.7并降级
* 注意：需要联网。

* 下载并安装gcc/g++ 4.7.x
```
sudo apt-get install -y gcc-4.7
sudo apt-get install -y g++-4.7
```

* 链接gcc/g++实现降级
```
cd /usr/bin
sudo rm gcc
sudo ln -s gcc-4.7 gcc
sudo rm g++
sudo ln -s g++-4.7 g++
# 查看是否连接到4.7.x
ls –al gcc g++
gcc --version
g++ --version
```

