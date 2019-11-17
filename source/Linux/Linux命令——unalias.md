# Linux命令——unalias


## unalias
* **功能**：取消**命令别名**(shell内建命令)
<!-- more -->
* **提示**：
	* 如果需要取消任意一个命令别名，则使用该命令别名作为指令的参数选项即可；
	* 如果使用-a选项，则表示取消所有已经存在的命令别名；
* **选项**： 
	* -a：取消所有命令别名；

* **示例**：
```bash
# 定义命令xuezhisd,显示登录用户信息
alias xuezhisd='who am i'
# 测试命令xuezhisd是否可用（可用）
xuezhisd
# 删除命令别名xuezhisd
unalias xuezhisd
# 测试命令xuezhisd是否可用（不可用）
xuezhisd
```


## 参考网址
* [Linux命令查询网站](http://www.lx138.com/)
* [Linux命令大全](http://man.linuxde.net/)
* [baidu](http://baidu.com/)
* [Google](http://google.com.hk)
