# Linux命令——uname


## uname
* **功能**：显示系统信息

* **提示**：
	* 系统信息包括：内核版本号、硬件架构、主机名称和操作系统类型等；
* **选项**： 
	* -a或--all：显示全部的信息； 
	* -m或--machine：显示机器硬件架构（如x86_64）； 
	* -n或-nodename：显示主机名； 
	* -o：显示操作系统名称；
	* -r：显示内核的发行编号； 
	* -s：显示内核名称； 
	* -v：显示内核的版本； 
	* --help：显示帮助； 
	* --version：显示版本信息。

* **示例**：
```bash
# 显示内核名称（如Linux）
uname
uname -s
# 显示操作系统名称
uname -o
# 显示所有信息
uname -a
# 显示系统架构（如x86_64）
uname -m
# 显示主机名
uname -n
# 显示内核的发行编号
uname -r
# 显示内核的版本
uname -v
# 显示帮助
uname --help
# 显示版本
uname --version
```


## 参考网址
* [Linux命令查询网站](http://www.lx138.com/)
* [Linux命令大全](http://man.linuxde.net/)
* [baidu](http://baidu.com/)
* [Google](http://google.com.hk)

