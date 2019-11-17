# Linux命令——who





## who
* **功能**：显示登录用户的信息
<!-- more -->
* **提示**：
	* 执行who命令可得知目前有那些用户登入系统；
	* 单独执行who命令会列出登入帐号，使用的终端机，登入时间和从何处登入；
* **选项**： 
	* -b：显示系统上次启动时间
	* -H或--heading：显示头信息【标题栏】； 
	* -u：显示闲置时间； 
	* -m：显示当前用户的信息，等价于`who am i`； 
	* -q或--count：只显示登入系统的用户名和总人数；
	* -r：显示当前运行级别（runlevel） ;
	* -s：此参数将忽略不予处理，仅负责解决who指令其他版本的兼容性问题； 
	* -w或-T：显示用户的信息状态栏； 
	* --help：在线帮助； 
	* --version：显示版本信息；

* **示例**：
```bash
# 显示系统上次启动时间
who -b
# 显示头信息【标题栏】
who -H
who --heading
# 突出显示“闲置时间”
# 若该用户在前一分钟之内有进行任何动作，将标示成"."号，如果该用户已超过24小时没有任何动作，则标示出"old"字符串
who -u
# 显示当前用户的信息
who -m
who am i
# 只显示登入系统的用户名和总人数
who -q
who --count
# 显示当前运行级别
who -r
# 显示用户的信息状态栏
who -w
who -T
# 显示在线帮助信息
who --help
# 显示版本信息
who --version
```


## 参考网址
* [Linux命令查询网站](http://www.lx138.com/)
* [Linux命令大全](http://man.linuxde.net/)
* [baidu](http://baidu.com/)
* [Google](http://google.com.hk)

