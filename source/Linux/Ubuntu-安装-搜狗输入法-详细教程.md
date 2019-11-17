# Ubuntu-安装-搜狗输入法-详细教程




## 下载deb安装包
* [安装包 下载地址](http://pinyin.sogou.com/linux/?r=pinyin)
* 系统32位的点击“立即下载32bit”，如下图所示；
* 系统64位的点击“立即下载64bit”，如下图所示。
![这里写图片描述](http://img.blog.csdn.net/20150731074947628)

## 安装fcitx
* 打开Terminal，输入以下命令，安装fcitx
```
sudo apt-get install fcitx
```

<!-- more -->

## 安装搜狗输入法
* 输入以下命令，安装第一步下载的deb安装包
* 注意：deb包名根据你下载的包名而定。
* 下面以64位版本为例。
```
sudo dpkg -i sogoupinyin_1.2.0.0048_amd64.deb 
```
* 如果出现错误，则输入以下命令，修复。
```
sudo apt-get update
sudo apt-get -f install
```

## 配置输入方法
* 输入以下命令
```
im-config
```
* 跳出一个对话框，如下图所示，点击“OK”；
![这里写图片描述](http://img.blog.csdn.net/20150731075138684)
* 点击“Yes”；
![这里写图片描述](http://img.blog.csdn.net/20150731075324395)
* 选择fcitx，点击“OK”；
![这里写图片描述](http://img.blog.csdn.net/20150731075426623)
* 点击“OK”；
![这里写图片描述](http://img.blog.csdn.net/20150731075404825)

## 重启
* 重启电脑，使配置生效。

## 添加搜狗输入法
* 点击右上角的**`小键盘图标`**，
![这里写图片描述](http://img.blog.csdn.net/20150731075545762)
* 选择**`配置`**选项，打开输入法配置对话框，点击左下角的**`+`**按钮；
![这里写图片描述](http://img.blog.csdn.net/20150731075710704)
* 在弹出的对话框中，取消`Only show current language`选项；
![这里写图片描述](http://img.blog.csdn.net/20150731075715863)
* 拖动滚动条到最后，选择`sougou  china`；
![这里写图片描述](http://img.blog.csdn.net/20150731075921662)
* 点击“Ok”，完成安装。
![这里写图片描述](http://img.blog.csdn.net/20150731080008992)

* 注： 切换输入法快捷键“Ctrl + 空格”，切换中英文快捷键“Shift”


至此，搜狗输入法完成安装。。。

## 参考
* http://pinyin.sogou.com/linux/help.php
* http://jingyan.baidu.com/article/0202781189b6ef1bcc9ce513.html