---
title: 另类方法解决windows下git-bash中文输入的乱码问题
slug: fucking-fix-msysgit-chinese-input-method-issue
date: 2012-04-18 17:16
tags: [git, windows]
---

对于 windows 下的 git 用户来说，[msysgit] 再熟悉不过了，不过它对中文的支持问题也一直困扰着我们。

[20120409 1.7.10][1] 这版已经加了 unicode  的 patch，但是按照传统方法进行配置后，在 `git-bash` 
中 `ls `可以正常显示中文，但输入中文时却依然乱码。

![git-bash](http://pic.yupoo.com/greatghoul_v/BTSP5iDb/Ym61n.png)

我在 中文版的 win7 和 xp 上都出现了这样的问题，本来想找一个 msysgit 的替代方案，结果用一种另类
的方法解决的中文输入的问题

这里我需要提一下 [msys-cn] 这个开源项目：MSYS 中国项目，Windows 下程序开发、远程登录、科学计算、
代码移植的瑞士军刀

这个项目对中文有着较好的支持，而我们需要用的，只是它里面的一部分东西而已。

我们需要下载 [MSYS-CN 2010-08-19 更新版本][2] ，将里面的 bin 目录解压覆盖 git 中的 bin 目录
（记得备份原来的 bin目录中的内容）

然后运行 git-bash，很简单，你可以正常输入中文了。

PS: 美中不足的是，删除中文的时候，只能一次删除半个中文，还有就是访问中文目录还是会出问题。

![git-bash中文目录乱码](http://pic.yupoo.com/greatghoul_v/BTSSKUfE/12IaTv.png)

[1]: http://code.google.com/p/msysgit/downloads/detail?name=Git-1.7.10-preview20120409.exe&amp;can=2&amp;q=full+installer+official+git
[2]: http://code.google.com/p/msys-cn/downloads/detail?name=MSYS-Update.7z&amp;can=2&amp;q=
[msys-cn]: http://code.google.com/p/msys-cn/
[msysgit]: http://code.google.com/p/msysgit/
