# Linux判断文件和文件夹是否存在

* shell判断文件,目录是否存在或者具有权限

```bash
#!/bin/sh  
  
myPath="/var/log/httpd/"  
myFile="/var /log/httpd/access.log"  
  
#这里的-x 参数判断$myPath是否存在并且是否具有可执行权限  
if [ ! -x "$myPath"]; then  
　　mkdir "$myPath"  
fi  

#这里的-d 参数判断$myPath是否存在  
if [ ! -d "$myPath"]; then  
　　mkdir "$myPath"  
fi  
  
#这里的-f参数判断$myFile是否存在  
if [ ! -f "$myFile" ]; then  
　　touch "$myFile"  
fi  
  
#其他参数还有-n,-n是判断一个变量是否是否有值  
if [ ! -n "$myVar" ]; then  
　　echo "$myVar is empty"  
　　exit 0  
fi  
  
#两个变量判断是否相等  
if [ "$var1" = "$var2" ]; then  
　　echo '$var1 eq $var2'  
else  
　　echo '$var1 not eq $var2'  
fi
```

* 转载地址：http://www.cnblogs.com/platero/p/4021561.html