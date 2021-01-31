# Ubuntu 14.04 64bit 安装32位兼容包


## 问题描述
* 我的操作系统是64bit版的Ubuntu 14.04，很多32bit的软件无法安装使用，因此希望通过安装32位兼容包解决。

## 安装过程
* 在Ubuntu 13.10之前，可以通过安装 **ia32-libs** 来支持32位软件。但是，该版本之后，Ubuntu就去掉了。
* 不过可以通过安装替的32位兼容包来实现该功能。
<!-- more -->
* 命令行中输入以下命令

```bash
sudo apt-get install ia32-libs
```
返回的信息如下所示，

```bash
Package ia32-libs is not available, but is referred to by another package.
This may mean that the package is missing, has been obsoleted, or
is only available from another source
However the following packages replace it:
  lib32z1 lib32ncurses5 lib32bz2-1.0
```
 
* 也就是说可以通过lib32z1 lib32ncurses5 lib32bz2-1.0是ia32-libs的替代安装包。可以安装任何一个来支持32位软件。
* 安装命令如下所示。

```bash
sudo apt-get install lib32z1
```



## 参考
* [ubuntu 14.04 64位 怎么安装 32位 支持库啊？](http://www.oschina.net/question/237198_146122)
* [Ubuntu14.04如何安装32位兼容库,即ia32-libs](http://www.oschina.net/question/1470892_151825)