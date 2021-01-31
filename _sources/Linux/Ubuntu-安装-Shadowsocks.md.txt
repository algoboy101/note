# Ubuntu-安装-Shadowsocks


## 系统环境
* Ubuntu 14.04
* Python2.7

## 安装依赖关系

	sudo apt-get update
	sudo python --version
	sudo apt-get install python-gevent python-pip
	sudo pip install shadowsocks

<!-- more -->
    
## 找到shadowsocks的安装位置
```bash
sudo find / -name shadows*
```
其中， "/"是根目录下， *是通配符。
我的安装路径是`/usr/local/lib/python2.7/dist-packages/shadowsocks`

## 新建并修改配置文件

在安装路径下新建文件config.json，路径`/usr/local/lib/python2.7/dist-packages/shadowsocks`，创建命令`sudo touch config.json`

文件内容：

```yaml
{
"server":"79.45.115.110",
"server_port":12801,
"local_port":10808,
"password":"123456",
"timeout":600,
"method":"aes-256-cfb"
}
```
	
## 运行shadowsocks
在安装路径下，输入`sslocal`，即可启动shadowsocks。

## 开机自动启动
* 修改rc.local文件
```bash
cd /etc/
sudo vim rc.local
```
* 加上一行：
```bash
/usr/local/bin/sslocal -c /usr/local/lib/python2.7/dist-packages/shadowsocks/config.json
```
    
## 配置SwitchySharp
* [下载Switchysharp](http://pan.baidu.com/s/1eQCoeQ2)
* [安装Switchysharp](http://jingyan.baidu.com/article/380abd0a5543221d90192c9f.html)
* 配置如下图所示，注意：端口根据根据配置中填写，上面的配置是10808，所以此处端口应该由1080改为：10808
	![这里写图片描述](http://img.blog.csdn.net/20150802191807396)