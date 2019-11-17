# Ubuntu-安装-cuda7.0-单显卡-超详细教程


## 一、说明
* 本教程是在台式机上安装的，只有一个NVIDIA显卡。
* 操作系统是Ubuntu 14.04 (64bit)。
* 双显卡的笔记本请移步[Ubuntu-安装-cuda7.0-双显卡-超详细教程](http://www.baidu.com)



## 二、准备
**说明：本文假设下载的文件都在~/Dowloads/下面**

<!-- more -->

### 1. 更新操作系统
```bash
sudo apt-get update
```

### 2. 下载cuda7.0
* 下载cuda。[点此下载](https://developer.nvidia.com/cuda-downloads) 

* 如果不是该版本，可以搜索，如下图所示；

* 点击"Linux x86"，选择“Ubuntu 14.04”行的最后一个“RUN”下载；
	![这里写图片描述](http://img.blog.csdn.net/20150731081204846)
	![这里写图片描述](http://img.blog.csdn.net/20150731081542503)

### 3. 下载NVIDIA显卡驱动
* 下载驱动。[点此下载](http://www.nvidia.cn/Download/index.aspx?lang=cn)

* 选择自己电脑对应的配置，然后点击“搜索”；
* 点击“DOWLOAD”，进行下载；
	![这里写图片描述](http://img.blog.csdn.net/20150731081921600)
	![这里写图片描述](http://img.blog.csdn.net/20150731082244468)


## 三、验证系统是否符合要求

### 1. 验证显卡是否支持cuda
* 终端输入命令，如图所示。如果只返回两条信息，即有两个显卡，可以继续下面教程，否则请移步[《Ubuntu-安装-cuda7.0-双显卡-超详细教程》](http://blog.csdn.net/xuezhisdc/article/details/47075401)

	```shell
	lspci | grep VGA
	```

	![这里写图片描述](http://img.blog.csdn.net/20150731082709383)

* 如果操作系统是Ubuntu Server，即使有NVIDIA显卡，执行上面的命令可能也不会返回相关信息。这时需要执行的命令是 `lspci |grep nvidia -i` ，就能返回正常的结果。
* 终端会显示显卡型号，在https://developer.nvidia.com/cuda-gpus中查找，是否有你的显卡型号，只要存在，就表明显卡支持cuda，同时还可以查看显卡的计算能力，数值越大越好。

### 2. 查看系统类型
* 命令行输入下面命令;

	```shell
	uname -m && cat /etc/*release
	```
* 第一行显示有x86_64，说明系统是x86构架64位系统;

	![这里写图片描述](http://img.blog.csdn.net/20150731083253009)



## 四、安装NVIDIA显卡驱动

>说明：前面下载的cuda7.0*.run中含有NVIDIA显卡驱动，而且安装时会提示安装驱动。但是，由于Ubuntu中已经为NVIDIA显卡安装了驱动nouveau，而且该驱动正在运行中，所以安装驱动的过程稍微麻烦，建议**先单独安装显卡驱动，再安装cuda**
	
### 1. 切换到tty1
* 说明，视窗会使用显卡，如果在视窗下，原来的驱动nouveau不会停止，也就不能安装成功

* 按组合键”Ctrl+Alt+F1“，切换到tty1；

### 2. 关闭显示器管理器
* 输入命令`sudo stop lightdm`，关闭显示器管理器。否则后面旧的显卡驱动无法禁用，新的显卡驱动无法安装。

### 3. 禁用旧的显卡驱动
* 注意：`禁用旧的显卡驱动`这一步可以不操作，后面安装新的NVIDIA显卡驱动时，会提示该问题；那时选择相应的选项即可创建该文件。

* 禁用旧的显卡驱动；切换到/etc/modprobe.d/，新建文件nvidia-installer-disable-nouveau.conf，输入以下内容，保存退出；

	```
	blacklist nouveau
	options nouveau modeset=0
	```
* 在文件/etc/default/grub的最后，添加一行，如下所示；

	```
	rdblacklist nouveau
	nouveau.modeset=0
	```

### 4. 安装新的驱动
* 小技巧：如果按照第3步做完了，重启后依然无法安装新的NVIDIA显卡驱动，那么可以通过software manger安装NVIDIA低版本的显卡驱动（它就会自动关闭nouveau），重启后卸载低版本显卡驱动，接着安装当前版本的显卡驱动。这样一般情况下可以成功。（曲线救国）
* 执行以下命令安装

	```bash
	# 切换到驱动所在的路径
	cd ~/Downloads
	# 查看驱动的名称(ls)
	ls
	# 开始安装,注意将驱动名换成你下载的驱动的名称
	sudo sh ./NVIDIA-Linux-x86_64-352.30.run
	```
* 安装过程中，根据提示，选择`accept`, 'yes'或默认选项
	* 选项：Accept →  Continue → installation →  OK → OK → OK 
* 当提示**重启**时，重启继续。(如果前面没有禁用nouveau，会提示向/etc/modprobe.d/路径下添加文件，其实是在尝试禁用nouveau。如果出现该提示，需要重启电脑之后，再次运行显卡安装程序，重新开始安装一遍。)

* 重启后，切换到tty（Ctrl+Alt+F1），关闭显示器管理（*`sudo stop lightdm`*），重新运行安装驱动命令 （*`sudo sh ./NVIDIA-Linux-x86_64-352.30.run`*）

* 当提示***would you run nvidia-Xconfig utility ... **，选择Yes。

### 5. 检验驱动是否安装成功
* 打开终端，输入以下命令：

	```bash
	cat /proc/driver/nvidia/version
	```
* 如果显示驱动版本，说明安装成功。如下图所示。

	![这里写图片描述](http://img.blog.csdn.net/20150731094233828)


## 五、安装cuda
***注意，请在成功安装显卡驱动的前提下继续安装cuda，否则也会安装失败。***

### 1. 安装依赖库
* 请先在Terminal中安装以下依赖库：

	```bash
	sudo apt-get install freeglut3-dev
	sudo apt-get install build-essential
	sudo apt-get install libx11-dev
	sudo apt-get install libxmu-dev 
	sudo apt-get install libxi-dev 
	sudo apt-get install libglu1-mesa 
	sudo apt-get install libglu1-mesa-dev
	```
	
### 2. 运行cuda安装命令
* 在Terminal中运行以下命令，开始安装cuda：

	```bash
	# 注意，将cuda名称换成自己下载的名称
	# 添加执行权限
	chmod a+x cuda_7.0.28_linux.run
	sudo ./cuda_7.0.28_linux.run
	```
	
* 安装过程中会提示安装**NVIDIA驱动**，OpenGL，CUDA安装包和SAMPLE包。此处只安装后面三个。由于前面已经安装了最新版的NVIDIA驱动，此处不用再安装。

* 安装过程中，根据提示，选择accept, ‘yes’或默认选项；

* ***...symbolic link ...***选项选择Yes，否则没有*`/usr/local/cuda/`*，只有*`/usr/local/cuda7.0/`*

* 安装完成之后，启动显示器管理（`sudo start lightdm`），切换回视窗界面。

### 3. 配置环境变量
* 打开终端，在文件/etc/profile的最后添加以下内容：

	```
	PATH=/usr/local/cuda/bin:$PATH
	export PATH
	```
* 保存后, 执行下列命令, 使环境变量立即生效

	```bash
	source /etc/profile
	```
* 在 /etc/ld.so.conf.d/新建文件 cuda.conf，并添加如下内容：

	```bash
	/usr/local/cuda/lib64
	```
* 执行下列命令使之立刻生效:

	```bash
	sudo ldconfig
	```

### 4. 检验环境是否设置好
* 打开终端，输入`cuda`，按2次”Tab键“，如果有弹出的命令提示，就说明环境配置成功。

### 5.安装其他一些辅助库
```
sudo apt-get install freeglut3-dev build-essential libx11-dev libxmu-dev libxi-dev libgl1-mesa-glx libglu1-mesa libglu1-mesa-dev
```

## 六、安装CUDA SAMPLES
* 安装cuda过程中，cuda samples默认安装了，并且存储在当前用户目录下（***/home/xuezhisd/NVIDIA_CUDA-7.0_Samples***），如下图所示：

	![这里写图片描述](http://img.blog.csdn.net/20150731094513416)

### 1. 验证nvcc
* 输入命令*`nvcc --version`*，如果已经安装了，会显示版本号；如果没有安装，按照提示完成安装。

### 2. make cuda samples
* 切换到cuda-samples路径，使用***`make`***命令：

	```bash
	#切换到cuda-samples所在目录
	#注意，换成自己的路径
	cd /home/xuezhisd/NVIDIA_CUDA-7.0_Samples
	#编译 make （安装命令 sudo apt-get install cmake)
	make
	#编译完毕，切换release目录
	cd ./bin/x86_64/linux/release
	#检验是否成功
	#运行实例 ./deviceQuery
	./deviceQuery
	```
* 显示如下结果，说明成功。

	![这里写图片描述](http://img.blog.csdn.net/20150731141630016)
	![这里写图片描述](http://img.blog.csdn.net/20150731141752530)


## 七、安装cuDNN

### 1. 下载cuDNN

* [官方下载](https://developer.nvidia.com/cudnn) 需要注册和验证，麻烦。
* 我将我下载文件上传到百度网盘中了，有需要的可以点击此处直接下载 [cudnn](http://pan.baidu.com/s/1sjBl5cL)    &     [cudnn-samples](http://pan.baidu.com/s/1hq8ggfy)

### 2. 安装cuDNNE
* 解压，并复制文件
```bash
#解压文件
tar -zxvf cudnn-6.5-linux-x64-v2.tgz
#切换路径
cd cudnn-6.5-linux-x64-v2
#复制lib文件到cuda安装路径下的lib64/
sudo cp lib* /usr/local/cuda/lib64/
#复制头文件
sudo cp cudnn.h /usr/local/cuda/include/
```
* 更新软连接
```bash
cd /usr/local/cuda/lib64/
sudo rm -rf libcudnn.so libcudnn.so.6.5
sudo ln -s libcudnn.so.6.5.48 libcudnn.so.6.5
sudo ln -s libcudnn.so.6.5 libcudnn.so
```

至此，cuDNN完成安装。
	



## 八、参考文章
* [Ubuntu 13.04 双显卡安装NVIDIA GT 630M驱动](http://www.linuxidc.com/Linux/2013-05/84814.htm)
* [Caffe + Ubuntu 14.04 64bit + CUDA 6.5 配置说明](http://www.cnblogs.com/platero/p/3993877.html)
* [Ubuntu14.04+cuda6.5+opencv2.4.9+MATLAB2013a+caffe配置记录（二）](http://www.bubuko.com/infodetail-462458.html)
* [ERROR: Module nouveau is in use](https://www.google.com.hk/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=ERROR%3A%20Module%20nouveau%20is%20in%20use)
* [HOW-TO: Unload nouveau and Install Nvidia Driver](http://www.pimp-my-rig.com/2012/01/unload-nouveau-install-nvidia-driver.html)
* [Caffe在Ubuntu 14.04 64bit 下的安装](http://www.linuxidc.com/Linux/2015-07/120449.htm)
* [ubutu14.04LTS+opencv2.4.9+matlab 2014a+caffe+cuDNN](http://blog.csdn.net/guicydy/article/details/45367217)
* [Optimus双显卡用Bumblebee3.0在ubuntu12.04下配置CUDA4.2](http://blog.sina.com.cn/s/blog_403db75501010yp2.html)
* [Ubuntu 14.04 Nvidia显卡驱动安装及设置](http://www.cnblogs.com/platero/p/4070756.html)
* [ubuntu 11.10驱动gtx 460显卡 禁用nouveau ](http://www.shangxueba.com/jingyan/1661938.html)
* ERROR: 启动过程中，会出现两个错误，执行以下命令可以解决。
	```
	sudo apt-get purge nvidia-304
	sudo apt-get install nvidia-331
	```