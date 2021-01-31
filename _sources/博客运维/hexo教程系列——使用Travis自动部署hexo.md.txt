# hexo教程系列——使用Travis自动部署hexo

> 本文介绍了如何使用Travis CI自动部署hexo，解决了家里和公司两地写博客的麻烦。本博客实现了博客仓库中的dev分支改动时，自动部署到master分支中。


## 说明
* 为了在不同电脑上写完并提交博文后，博客能自动更新内容。本文介绍如何通过Travis CI来实现github上的hexo博客自动部署。
* 本教程是在Windows 7上操作的。
* 本教程使用了GitHub API实现，用到了Linux中的sed命令。


## 新建Personal Access Token
* 点击右上角头像旁边的三角，在菜单中点击“Setting”，进入设置页面。
![](http://img.zhangxuezhi.com/v90uk9inuvo8yjywxj9gm5hjb5.png)

* 点击左侧栏的最下面的“Personal access tokens”，创建Personal access tokens。
![](http://img.zhangxuezhi.com/syvhuszdqc8zoe5hncv99r8ntg.png)

* 点击右上角的“Generate new token”，输入用户密码，进入“New personal access token”页面。
![](http://img.zhangxuezhi.com/183vnbiixxadzm7bp75458dc59.png)

* 设置Token description（其实就是名称），选择相应的权限，如下图所示。
![](http://img.zhangxuezhi.com/brnxrllts6783vig9u5o0903k5.png)

* 点击“Generate token”按钮，生成Personal access tokens。如下图中红线标注的部分。**注意：这行token只会在刚刚创建完成后显示一次，以后不再显示**。因此，复制并保存到本地。
![](http://img.zhangxuezhi.com/spb4526esm5qmhvocnn24f0i19.png)

## 配置Travis CI

### 登录并配置Travis CI
* Travis CI是目前新兴的开源持续集成构建项目。可以直接使用GitHub账号登录。
* 将鼠标放在用户名上，在弹出的菜单中点击“Accounts”，将会显示你在GitHub上的仓库。如下图所示。
![](http://img.zhangxuezhi.com/yvrv0pcjjw1p29x879ohfhm0od.png)
* 找到自己的博客项目，点击X号，将其变成√号。再点击右侧的齿轮，进入该仓库的配置页面。
![](http://img.zhangxuezhi.com/ylz1rd42kfubl160tqvemhgs0p.png)
* 在项目的设置中开启Build only if .travis.yml is present这一项。如下图所示。
![](http://img.zhangxuezhi.com/vw68mu4fmciss8pkc6vgxu1t9b.png)

### 本地安装Travis
* 首先安装Ruby，直接官网下载，双击安装就OK了。
* 在Windows下，安装travis之前，需要解决一个问题：**SSL证书问题**，否则不能成功安装。详情请点击该链接：[参考教程](http://blog.csdn.net/chancein007/article/details/52940032)。
* 修复好上述问题后，执行下面的命令安装travis。
```yaml
# 安装travis
gem install travis
```

### 创建并修改配置文件
* 打开博客项目文件夹，在项目根目录新建.travis.yml配置文件。
```
cd 博客项目文件夹根目录
touch .travis.yml
```

* 执行下面的命令，加密上面生成的Personal access tokens，并添加到.travis.yml配置文件。
```
# 这里的 REPO_TOKEN 是变量名,在后面的配置文件中会用到
# TOKEN 是上面github生成的Token
travis encrypt 'REPO_TOKEN=<TOKEN>' --add
```

* 上述命令指向完后，.travis.yml配置文件的内容如下所示。
```
env:
  global:
    secure: F/gYu+bVe3aWs6YnuB5PNZLEmHH4CGf0najk8JI3/N+SFL0TH8tyYg+O1sXR3EIg.....省略.....iwr5HQG/G3fdL4JcXiAJIm/iH9ndDyGV5EGR1CmseNGNWrwnRZ7tlKE=
```

* 使用本地编辑器打开.travis.yml配置文件，将其修改成如下所示的内容。**注意：有些内容是你自己的!!!**
```
language: node_js
node_js:
- "4"  # nodejs的版本
branches:
  only:
  - dev  # 设置自动化部署的源码分支

# ------------------------------------------------
# 下面是你的Token加密信息，不要替换
# ------------------------------------------------
env:
  global:  
    secure: F/gYu+bVe3aWs6Yn.....省略..../iH9ndDyGV5EGR1CmseNGNWrwnRZ7tlKE=
    
before_install:
- export TZ='Asia/Shanghai'  
- npm install -g hexo
- npm install -g hexo-cli 
before_script:
# ------------------------------------------------
# 设置github账户信息 注意修改成自己的信息
# ------------------------------------------------
- git config --global user.name "xuezhisd"
- git config --global user.email xuezhi@126.com 
# ------------------------------------------------
# github仓库操作  注意将仓库修改成自己的
# ------------------------------------------------
- sed -i'' "s~git@github.com:xuezhisd/xuezhisd.github.io.git~https://${REPO_TOKEN}:x-oauth-basic@github.com/xuezhisd/xuezhisd.github.io.git~" _config.yml
# 安装依赖组件
install:
- npm install
# 执行的命令
script:
- hexo clean
- hexo generate
# 执行的成功后执行 
after_success:
- hexo deploy
```

* 至此，Travis CI已经配置完成了。

## 创建仓库，推送到GitHub
* 新建仓库blog。
```
git init blog
cd blog
```

* 将原来博客目录下的以下内容复制到blog文件夹中。
![](http://img.zhangxuezhi.com/747d3iy0nq4a39mdnpdx57c51a.png)

* 修改.gitignore文件，取消对node_modules文件夹的忽略。（即删除对应的行）

* 关联GitHub上的远程仓库。
```bash
# 将github仓库改为自己的博客仓库
git remote add origin git@github.com:xuezhisd/xuezhisd.github.io.git
```

* 提交本地修改，推送到GitHub上。
```
# 添加文件到暂存区
git add .
# 提交修改
git commit -m "test travis"
# 推送至远程仓库的dev分支
git push -u origin dev
```

* push本地的代码至远程仓库之后，在https://travis-ci.org 后台查看相关情况。如果如下图所示，就代表成功了。
![](http://img.zhangxuezhi.com/pkv15sreco6fl4g85v8lzz4uqh.png)


## 参考博客
* [hexo官方文档](https://hexo.io/zh-cn/)
* [NexT主题官方文档](http://theme-next.iissnan.com/getting-started.html)
* [hexo 下的分类和表签无法显示，怎么解决？](https://www.zhihu.com/question/29017171)
* [手把手教从零开始在GitHub上使用Hexo搭建博客教程(一)](http://www.jianshu.com/p/f4cc5866946b)
* [Github上搭建Hexo如何跨电脑写作部署方便？](https://segmentfault.com/q/1010000004593371)
* [Continuous Integration Your Hexo Blog With Travis CI](http://blog.bigruan.com/2015-03-09-Continuous-Integration-Your-Hexo-Blog-With-TravisCI/)
* [【Hexo+Github】域名和github绑定的问题](http://www.jianshu.com/p/1d427e888dda)
* [万网域名+GitHub平台搭建的博客](http://www.jianshu.com/p/3cb4c9ff5b58)