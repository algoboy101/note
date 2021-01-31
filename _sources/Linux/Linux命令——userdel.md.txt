# Linux命令——userdel



## userdel 
* **功能**：删除用户账号

<!-- more -->

* **提示**：
	* 一次删除一个用户；
	* 删除的用户必须存在；
	* userdel 不 允 许 你 移 除 正 在线 上 的 使 用 者 帐 号 。 你 必 须 砍 掉 此 帐 号 现 在 在 系 统 上 执 行 的 程 序 才 能 进 行 帐 号 删 除 ；
* **选项**： 
	* -f：强制删除用户，即使用户当前已登录；
	*  -r：删除用户的同时，删除与用户相关的所有文件。
* **示例**：
```bash
# 删除用户test
userdel test 
# 删除用户test的同时，删除用户登录目录以及目录下的文件
userdel test -r 
# 强制删除用户
userdel test -f 
# 强制删除用户，并删除用户登录目录以及目录下的文件
userdel test -fr

# 删除已经登录的用户
# 先查看当前登录的用户，并记录TTY
w
# 关闭希望删除的用户
pkill -kill -t [TTY]
userdel test -rf
```



## 参考网址
* [Linux命令查询网站](http://www.lx138.com/)
* [Linux命令大全](http://man.linuxde.net/)
* [baidu](http://baidu.com/)
* [Google](http://google.com.hk)