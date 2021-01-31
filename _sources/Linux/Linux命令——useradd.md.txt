# Linux命令——useradd






## useradd
* **功能**：建立用户账号

<!-- more -->

* **提示**：
	* 使用useradd指令所建立的帐号，实际上是保存在/etc/passwd文本文件中；
	* 帐号建好之后，再用passwd设定帐号的密码；
	* 可用userdel删除帐号；
	* **设定ID值时尽量要大于500，以免冲突。** 因为Linux安装后会建立一些特别用户，一般0到499之间的值留给bin、mail这样的系统账号。
	* 系统用户的权限稍微大一些，可以修改自己的某些信息；系统用户的UID<500；
* **选项**： 
	* -c：加上备注文字。备注文字会保存在passwd的备注栏位中； 
	* -d：指定用户登入时的启始目录。
	* -D：变更预设值； 
	* -e：指定帐号的有效期限，缺省表示永久有效；
	*  -f：指定在密码过期后多少天即关闭该帐号；
	* -g：指定用户所属的群组。 
	* -G：指定用户所属的附加群组； 
	* -m：自动建立用户的登入目录； 
	* -M：不要自动建立用户的登入目录；
	* -r：建立系统帐号； 
	* -s：指定用户登入后所使用的shell；
	* -u：指定用户id；
* **示例**：

```bash
# 新建用户test
useradd test 
# 新建用户test，并添加备注
useradd test -c "temp user"
# 新建用户test，并指定目录
useradd test -d /home/test
# 添加新用户jack，主要组:sales,次要组：company
useradd jack –g sales –G company,employees 
# 新建用户test，并自动建立用户登入目录
useradd test -m
# 新建系统用户test
useradd test -r 
# 新建一个用户，并指定用户登录后使用的shell
useradd test -s /bin/bash
# 建立一个新用户账户，并设置ID：
useradd test －u 544
```



## 参考网址
* [Linux命令查询网站](http://www.lx138.com/)
* [Linux命令大全](http://man.linuxde.net/)
* [baidu](http://baidu.com/)
* [Google](http://google.com.hk)












