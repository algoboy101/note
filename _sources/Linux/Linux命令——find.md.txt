# Linux命令——find



## find
* **功能**：在指定目录下**查找文件**

* **提示**：
	* 任何位于参数之前的字符串都将被视为欲查找的目录名；
	* 如果使用该命令时，不设置任何参数，则find命令将在当前目录下查找子目录与文件，并且将查找到的子目录和文件全部进行显示；
    
    
* **选项**： 
	* -name：指定模式，大小写敏感；
	* -iname：指定模式，大小写**不敏感**；
	* -type：指定文件类型
	* --help：显示帮助信息
	* --version：显示版本信息


* **示例**：
```bash
# 列出当前目录及子目录下的所有文件和文件夹
find .

# 在主目录下，查找test.txt文件
find ~ -name test.txt
# 在主目录及其子目录下，查找test.txt文件
find ~ -name "test.txt"

# 在主目录下，查找以txt结尾的文件
find ~ -name "*.txt"
# 在主目录下，查找以txt结尾的文件【但忽略大小写】
find ~ -iname "*.txt"

# 根据【文件类型】查找
# 在主目录及其子目录下下查找“普通文件”
find ~ -type f 
# 在主目录及其子目录下下查找“符号连接”
find ~ -type l
# 在主目录及其子目录下下查找“目录”
find ~ -type d
# 在主目录及其子目录下下查找“字符设备”
find ~ -type c
# 在主目录及其子目录下下查找“块设备”
find ~ -type b
# 在主目录及其子目录下下查找“套接字”
find ~ -type s

# 显示帮助信息
find --help
# 显示版本信息
find --version 
```


## 参考网址
* [Linux命令查询网站](http://www.lx138.com/)
* [Linux命令大全](http://man.linuxde.net/)
* [baidu](http://baidu.com/)
* [Google](http://google.com.hk)
