# Linux命令——diff

## diff
* **功能**：逐行比较两个文件

* **提示**：
	* 默认情况下，跟两个参数，指定对比的文件名称；
	* 如果一个参数指定文件名称，另一个参数指定路径，则将与该路径下同名的文件进行比较；
	* 如果使用“-”代替“文件”参数，则要比较的内容将来自标准输入；
	* diff命令是以逐行的方式，比较文本文件的异同处；
	* 如果该命令指定进行目录的比较，则将会比较该目录中具有相同文件名的文件，而不会对其子目录文件进行任何比较操作；
	* 返回结果中，字母"a"、"d"、"c"分别表示添加、删除及修改操作；
* **选项**： 
	* -c：显示全部内容，并标出不同之处；
	* -i：不检查大小写；

* **示例**：
```bash
# 比较test.txt和test.c
diff test.txt test.c
# 比较test.txt和work/test.txt
diff test.txt work
# 比较test.txt和test.c，将显示全部内容，并标出不同之处
diff test.txt test.c -c
# 比较test.txt和test.c，但忽略大小写
diff test.txt test.c -i
```

## 参考网址
* [Linux命令查询网站](http://www.lx138.com/)
* [Linux命令大全](http://man.linuxde.net/)
* [baidu](http://baidu.com/)
* [Google](http://google.com.hk)
