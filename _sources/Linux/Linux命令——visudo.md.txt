# Linux命令——visudo



## visudo
* **功能**：编辑sudoers文件
<!-- more -->
* **提示**：
	* 需要超级用户权限；
	* 默认编辑/etc/sudoers文件；
	* sudoers文件的默认权限是440，即默认无法修改；
	* visudo可以在不更改sudoers文件权限的情况下，直接修改sudoers文件；
* **选项**： 
	* -c：使用**check-only**模式，打印语法等错误信息；
	* -q：使用**quiet**模式，不打印语法等错误信息；
	* -f：指定sudoers文件；
* **示例**：
```bash
# 编辑/etc/sudoers文件
visudo
# 编辑/etc/sudoers文件，并检查语法等错误
visudo -c
# 编辑/etc/sudoers文件，但不打印语法等错误
visudo -q
# 显示版本信息
visudo -V
```



## 参考网址
* [Linux命令查询网站](http://www.lx138.com/)
* [Linux命令大全](http://man.linuxde.net/)
* [baidu](http://baidu.com/)
* [Google](http://google.com.hk)

