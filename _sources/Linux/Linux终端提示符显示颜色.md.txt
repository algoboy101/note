# Linux终端提示符显示颜色

## 用法
* 将以下内容复制到～/.bashrc中，

```bash
PS1='[\[\e[32;40m\]\u@\w]\$\[\e[m\]'
```

* 效果如下图所示。
![这里写图片描述](http://img.blog.csdn.net/20151113210746257)

## 参考
* [Linux修改Shell命令提示符及颜色](http://www.linuxidc.com/Linux/2014-10/108195.htm)
* [修改Linux/Centos6终端命令提示符颜色](http://www.centoscn.com/CentOS/2013/0418/321.html)