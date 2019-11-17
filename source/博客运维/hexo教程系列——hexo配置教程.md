# hexo教程系列——hexo配置教程

## 网站的配置文件
* 网站配置文件的存储位置：**hexo_blog/_config.yml**。
* 配置文件中，冒号后面一定要加空格。
* [hexo官方配置说明](https://hexo.io/docs/configuration.html)

* 我的配置文件内容如下所示。

```yaml
# Hexo Configuration Hexo配置文件
## Docs: https://hexo.io/docs/configuration.html
## Source: https://github.com/hexojs/hexo/


# 网站信息
#标题
title: 学志の博客
#副标题
subtitle: 记录学习的技能和遇到的问题
#网站描述
description: 做自己爱做的事，爱自己在做的事！
#作者昵称
author: 张学志
#网站语言，默认英语，设置简体汉语
language: zh-Hans

#时区，默认电脑时区
#timezone: 
timezone: Asia/Shanghai


# 网址设置
#如果网站是放在子目录中，将url设置成'http://yoursite.com/child'，将root设置成'/child/'
## If your site is put in a subdirectory, set url as 'http://yoursite.com/child' and root as '/child/'
#网址
url: http://zhangxuezhi.com
#网站根目录。如果网站是放在子目录中，将root设置成'子目录名'
root: /
#文章链接地址格式 。即文章存放的目录。
permalink: :year/:month/:day/:title/
permalink_defaults:


# 目录设置
#资源文件夹，放在里面的文件会上传到github中
source_dir: source
#公共文件夹，存放生成的静态文件
public_dir: public
#标签文件夹，默认是tags。实际存放在source/tags中。
tag_dir: tags
rss_dir: rss
#档案文件夹，默认是archives。
archive_dir: archives
#分类文件夹，默认是categories。实际存放在source/categories中。
category_dir: categories
#代码文件夹，默认是downloads/code
code_dir: downloads/code
#国际化文件夹，默认跟language相同
i18n_dir: :lang
#不需要渲染的文件夹或文件夹,放在[]中
# 这两个文件是百度和google的站长验证文件，不能渲染，否则会改变内容，不能验证过
skip_render: [baidu_verify_R9MZjdMkXT.html, google0f8fac7da2b48ef8.html, README.md, 模板.md]


# 写作选项
# 新建博文（帖子）的默认名称
# File name of new posts
new_post_name: :title.md 
#默认布局模板是post，而不是draft和page
default_layout: post
#是否将标题转换成标题形式（首字母大写）
titlecase: false # Transform title into titlecase
#在新标签页面中打开网页
external_link: true # Open external links in new tab
filename_case: 0
#是否渲染草稿
render_drafts: false
#启动 Asset 文件夹
post_asset_folder: false
#把链接改为与根目录的相对位址
relative_link: false
#显示未来的文章
future: true
#代码块的设置
highlight:
  enable: true          #  使用代码高亮
  line_number: true # 显示行号
  auto_detect: true  # 自动检测语言
  tab_replace:

  
# 分类和标签
# 默认分类
default_category: uncategorized
#分类别名
category_map:
#标签别名
tag_map:


# 日期和时间格式
#Hexo 使用 Moment.js 来解析和显示时间。
## You can customize the date format as defined in
## http://momentjs.com/docs/#/displaying/format/
date_format: YYYY-MM-DD
time_format: HH:mm:ss


# 分页配置
# ---------------下面选项需要对应插件的支持---------------
# npm install hexo-generator-index --save
# npm install hexo-generator-archive --save
# npm install hexo-generator-category --save
# npm install hexo-generator-tag --save
## Set per_page to 0 to disable pagination
#每页显示的文章量 
#per_page: 20
#首页的分页设置
index_generator:
  per_page: 5
#归档页的分页设置
archive_generator:
  per_page: 30
  yearly: true
  monthly: true
#标签页的分页设置
tag_generator:
  per_page: 20

#分页路径，在public中可以看到
#pagination_dir: page


# Extensions 拓展插件配置
## Plugins: https://hexo.io/plugins/
plugins: 
baidusitemap: 
  path: baidusitemap.xml


# 配置RSS
feed: 
  #feed 类型 (atom/rss2)
  type: atom   
  #rss 路径
  path: atom.xml  
  #在 rss 中最多生成的文章数(0显示所有)
  limit: 0
  
  
  
# 自定义站点内容搜索
# 需要先安装插件：
# npm install hexo-generator-search --save
search:
  path: search.xml
  # 如只想索引文章，可设置为post
  field: all 
  
# 主题配置
## Themes: https://hexo.io/themes/
#theme: false #禁用主题
#theme: landscape
theme: next


# 部署配置
## Docs: https://hexo.io/docs/deployment.html
deploy:
  type: git
  #repo: https://github.com/xuezhisd/xuezhisd.github.io.git
  repo: 
    # 部署到github
    github: git@github.com:xuezhisd/xuezhisd.github.io.git,master
    # 部署到coding.net。取消注释，可同时部署
    #coding: git@git.coding.net:xuezhisd/blog.git,coding-pages
  #type: baidu_url_submitter
```

## 主题的配置文件
* 默认主题是landscape
* [hexo官方主题页面](https://hexo.io/themes/)。从中选择喜欢的主题，下载并放到themes文件中。
* 我使用的主题是[NexT](http://theme-next.iissnan.com/getting-started.html)。

## 参考博客
* [手把手教从零开始在GitHub上使用Hexo搭建博客教程(二)](http://www.jianshu.com/p/dd9ef08b12df)
* [hexo官方文档](https://hexo.io/zh-cn/docs/index.html)
* [next主题官方文档](http://theme-next.iissnan.com/getting-started.html)
