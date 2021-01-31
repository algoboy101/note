# ubuntu中apt-get安装与默认路径

## 一、apt-get 安装

* deb是debian linus的安装格式，跟red hat的rpm非常相似，最基本的安装命令是：dpkg -i file.deb或者直接双击此文件
*  dpkg 是Debian Package的简写，是为Debian 专门开发的套件管理系统，方便软件的安装、更新及移除。所有源自Debian的Linux发行版都使用dpkg，例如Ubuntu、Knoppix 等。

>  以下是一些 dpkg 的普通用法：

<!-- more -->

### dpkg -i
* 安装一个 Debian 软件包，如你手动下载的文件。

### dpkg -c
* 列出 的内容。

### dpkg -I
* 从 中提取包裹信息。

### dpkg -r
* 移除一个已安装的包裹。

### dpkg -P
* 完全清除一个已安装的包裹。和 remove 不同的是，remove 只是删掉数据和可执行文件，purge 另外还删除所有的配制文件。

### dpkg -L
* 列出 安装的所有文件清单。同时请看 dpkg -c 来检查一个 .deb 文件的内容。

### dpkg -s
* 显示已安装包裹的信息。同时请看 apt-cache 显示 Debian 存档中的包裹信息，以及 dpkg -I 来显示从一个 .deb 文件中提取的包裹信息。

### dpkg-reconfigure
* 重新配制一个已经安装的包裹，如果它使用的是 debconf (debconf 为包裹安装提供了一个统一的配制界面)。


## 二、软件安装后相关文件位置

### 下载的软件存放位置
* /var/cache/apt/archives

### 安装后软件默认位置
* /usr/share

### 可执行文件位置 
* /usr/bin

### 配置文件位置
* /etc

### lib文件位置
* /usr/lib
