# 双系统(Linux)时间不一致问题


## 解决双系统时间不一致问题

### 问题描述
* 最近需要使用Linux（Ubuntu），所以在自己的电脑上安装了双系统（Windows+Ubuntu）。但是发现Windows的时间不正确，每次开机时，时间都会慢8个小时。
* 每次通过同步互联网时间可以更正，但是重启后又是如此。
* 后来，发现windows time服务没有开启。将其设置为自启动之后，每次开机后依然如此。而且windows time服务没有开启。
* 最后发现`两个系统的时间时间相差8小时`，意识到时两个系统设置不同引起的。

### 问题分析

* UTC即Universal Time Coordinated，协调世界时
* GMT 即Greenwich Mean Time，格林尼治平时
* Windows把系统硬件时间当作本地时间(local time)，即操作系统中显示的时间跟BIOS中显示的时间是一样的。
* Linux/Unix/Mac把硬件时间当作 UTC，操作系统中显示的时间是硬件时间经过换算得来的。
* 当PC中同时有多 系统共存时，就出现了问题。

<!-- more -->

### 问题解决

* **方法一 Ubuntu不使用UTC**

* 如果Ubuntu 不使用 UTC 时间，则可以与 Windows时间 保持一致。
* ubuntu默认开启UTC,即协调世界时，关闭它即可
```
sudo vi /etc/default/rcS
```
* 将`UTC=yes`改为`UTC=no`


* **方法二 修改 Windows 对硬件时间的对待方式**
* 让 Windows 把硬件时间当作 UTC
* 方法：
	* 开 始->运行->CMD，在命令行中输入下面命令并回车
```
Reg add KLM\SYSTEM\CurrentControlSet\Control\TimeZoneInformation /v RealTimeIsUniversal /t REG_DWORD /d 1
```

## CentOS时间同步问题

### 编辑时间配置文件
* 使用vi编辑`/etc/sysconfig/clock`文件，添加如下内容：
```
ZONE="Asia/Shanghai"
UTC=false       #设置为false，硬件时钟不于utc时间一致
ARC=false
```
* 使配置立即生效`source /etc/sysconfig/clock`

### 设置为上海时区
* 执行下面的命令，将Linux的时区设置为上海时区
```
ln -sf /usr/share/zoneinfo/Asia/Shanghai    /etc/localtime
```

### 对准时间
* 注意：需要联网
* 安装ntpdate的命令:`yum install ntp`
* 执行以下命令，对准时间
```
ntpdate us.pool.ntp.org
```

### 设置硬件时间和系统时间一致并校准
* 命令：
``` 
/sbin/hwclock --systohc   #设置硬件时间和系统时间一致并校准
```

至此，CentOS的时间已经同步了。

## 参考
* http://www.ithov.com/linux/122268.shtml
* http://os.51cto.com/art/201004/192549.htm