# 内网穿透之ngrok
* **内网穿透：** 从外网（有IP）访问局域网中的设备。

## 问题
* 在家里有一台计算机，希望在外面时，能够查看家里计算机运行情况。但我家的宽带是移动宽带，没有给分配公网IP。

## 解决方法
* 这是一个典型的*外网访问内网问题*，有一些公司在提供相关技术，比如花生壳。
* 本文使用`ngrok`来解决这个问题。

### 第一步，注册账号，开通隧道
* 访问网站：[sunny-ngrok](http://www.ngrok.cc/)，注册账号。
* 开通`tcp`协议的隧道，如下图所示。（**注意:** 试验的话，购买网页最下面的免费的套餐即可）
![开通隧道](https://raw.githubusercontent.com/algoboy101/note_imgs/dev/sunny_ngrok.png)
* 点击`隧道管理`，查看刚刚开通的隧道的相关信息，如下所示：
![隧道信息](https://raw.githubusercontent.com/algoboy101/note_imgs/dev/ngrok_info.png)
* 记住以下三条信息。
```
隧道id:5f191234d990a838
隧道端口:14568
服务器地址:free.idcfengye.com（请不要暴露此地址，避免服务器遭受攻击，谢谢）
```

### 第二步，下载客户端
* 点击[下载链接](http://www.ngrok.cc/download.html)，下载客户端。比如，我是`Ubuntu`系统，下载`Linux 64bit版本`。
### 第三步，安装客户端
* 安装很简单：解压后，直接执行可执行命令即可。
* 以下是我的操作步骤，我将它放到`/usr/local/bin/`目录下，方便任何地方执行。
```sh
unzip linux_amd64.zip 
cd linux_amd64/
ls
sudo cp sunny /usr/local/bin/
cd
sunny -h
```

### 第四步，启动客户端
* 启动客户端很简单，一句命令即可。
* 需要使用`隧道id`。比如，上面我的隧道id是：`隧道id:5f191234d990a838`
* 执行命令是：`sunny clientid 隧道id`
* 注意替换成自己的隧道id：
```shell
sunny clientid 5f191234d990a838
```

### 第五步，测试
* 换一台电脑，执行以下命令测试：`ssh -p 端口号（ngrok注册时的端口号） 用户名@服务器地址`
* 比如，我的用户名是：`xuezhisd`，端口号是：`14568`，服务器地址是：`free.idcfengye.com`。
* 我的测试命令是：`ssh -p 14568 xuezhisd@free.idcfengye.com`。
* 成功地访问家里的计算机，顺利解决问题！:-D

## 参考
* [sunny-ngrok](http://www.ngrok.cc/) 提供免费ngrok。
* [使用ssh，ngrok 外网远程连接linux](https://blog.csdn.net/sethqqq/article/details/77033154) 提供了参考教程。
