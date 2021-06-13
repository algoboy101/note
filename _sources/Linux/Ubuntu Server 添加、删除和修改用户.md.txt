# Ubuntu Server 添加、删除和修改用户

## 添加用户
* 添加用户的命令如下所示。添加一个用户名为sam的用户，主目录是/home/sam。
```bash
# -d 指定用户目录
# -m 创建用户目录（如果该目录不存在）
# useradd –d /home/sam -m sam
```

<!-- more -->

## 修改密码
* root用在终端中运行以下命令，为sam用户重新设置密码。
```bash
sudo passwd sam
```
* 设置root密码。root用户初始密码是随机的。按照下面的命令可以重新设置固定的root密码。
```bash
sudo passwd root
```

## 删除用户
* root用在终端中运行以下命令，将删除sam，但不删除其主目录。
```bash
sudo userdel sam
```

## 添加超级用户权限
* 修改`/etc/sudoers`文件，将sam添加到超级用户列表中，可以将sam设置成超级用户。

	* 执行下面的命令，使用vi打开sudoers文件；

	```bash
		vi /etc/sudoers
	```

	* 在`root ALL=(ALL) ALL`后面添加新的一行`sam ALL=(ALL) ALL` ，保存并退出，添加超级用户权限完成。
	* sam具有了超级用户权限，就可以具有root所有权限。执行命令式，使用sudo开头，并输入sam的密码，即能使用root权限执行命令。
