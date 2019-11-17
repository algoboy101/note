# Ubuntu-安装-Chrome


## 一、下载Chrome的安装包
* 打开终端，输入一下命令（区分64位和32位），下载Chrome的deb安装包。
```bash
#32位
wget https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb
#64位
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
```

## 二、安装Chrome
* 注意：需要root权限
* 在Terminal中输入以下命令
```bash
#32位安装命令
sudo dpkg -i google-chrome-stable_current_i386.deb
#64位安装命令
sudo dpkg -i google-chrome-stable_current_amd64.deb 
```

<!-- more -->

## 三、修复安装错误
* 安装过程中会提示错误信息“在处理时有错误发生： google-chrome-stable”
* 英文错误：
```bash
dpkg: error processing package google-chrome-stable (--install):
dependency problems - leaving unconfigured
```
* 出现这个错误之后，执行下面的命令
```bash
sudo apt-get -f install
```
* 执行完成后，Chrome就安装成功了。
* 在Dash中搜索Chrome，打开Chrome，并绑定到启动栏（launcher）


## 四、参考文章：
* http://www.linuxidc.com/Linux/2014-04/100645.htm
* http://jingyan.baidu.com/article/a681b0de18071e3b1843463b.html
