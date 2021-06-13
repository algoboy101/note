# Ubuntu使用过程中遇到的问题



## 打开终端的方法

### 1. 快捷键
* 打开终端对额快捷键：`[Ctrl] + [Alt] + [T]`

### 2. Dash主页图标
* 在Dash主页中搜索`terminal`，即可找到终端。

<!-- more -->

## 打开Dash的快捷键
* windows键


## 将./添加到PATH

### 目的
编写的脚本文件test.py，赋予执行权限之后，每一次都需下面的命令来执行。想要省去`./`
```
./test.py
```
变成
```
test.py
```

### 1. 临时方法
在终端中即可修改，但是重新登陆后失效。

执行如下命令即可。
``` shell
export PATH="$PATH:."
```

### 2. 修改environment文件
* 修改/etc/environment文件，可以永久有效。
* 需要root权限
* 需要重启电脑生效
* 添加在其他路径的前面

```
sudo vi /etc/environment
```
输入密码，修改PATH。
修改前：
```
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
```
修改后：
```
PATH=".:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
```
注意：`.`添加在**最前面**。

* 输入以下命令，使配置立刻生效，避免重启电脑。

```
source /etc/environment
```

### 3. 修改～/.bashrc 文件
* 该文件编辑保存后，可立即在新打开的终端窗口内生效。
* 该方式只对当前用户有效。
* 在该文件的最后添加如下语句

```
export PATH=.:$PATH
```

### 4. 修改profile 文件
* 文件位置：**`/etc/profile`**
* 该文件编辑保存后，重启系统，变量生效。
* 该方式添加的变量对所有的用户都有效。
* 在文件的最后面追加：

```
export PATH=.:$PATH
```


## 安装软件**源码**的步骤
分为3个步骤
```
./configure
make 
make install
make clean #清理临时文件
```
[参考](http://www.cnblogs.com/huangfenghit/archive/2011/02/17/1957057.html)


## vim不显色的问题

* 打开vim查看加载那些脚本。底行模式下输入`:scriptnames`。
* 设置`.vimrc`文件，将该文件设置成以下内容。

``` 
set nocompatible        " Vim settings, not Vi settings.  must be first
set autoindent          " Auto align when insert new line, for instance, when using o or O to insert new line.
set ruler               " Show ruler at the bottom-right of vim window
set showcmd
set backspace=indent,eol,start          " Enable delete for backspace under insert mode"
colorscheme darkblue
set number              " Show line number
syntax on
if &term =~ "xterm"
  if has("terminfo")
    set t_Co=8
    set t_Sf=^[[3%p1%dm
    set t_Sb=^[[4%p1%dm
  else
    set t_Co=8
    set t_Sf=^[[3%dm
    set t_Sb=^[[4%dm
  endif
endif
```

[参考文章](http://www.cnblogs.com/softwaretesting/archive/2012/01/10/2317820.html)

## vim不能正常使用方向键与退格键的问题
* vim出现问题的原因可能是由于版本低
* 在7.3中出现这些问题，但是在vim7.4中没有这些问题。
##方法1
* 安装vim full 版本。full版本下键盘正常。
##方法2
* 在vi底行模式下，使用命令**`: set nocompatible`**，就是设置vi不使用兼容模式。

[参考文章](http://www.2cto.com/os/201204/126724.html)

## 如何是配置立即生效
* 使配置立即生效的命令**`source`**
* 好处：不用重启电脑
* 示例1：

```bash
#使environtment修改后立即生效
source /etc/environment
```
* 示例2：

```bash
#使profile修改后立即生效
source /etc/profile
```