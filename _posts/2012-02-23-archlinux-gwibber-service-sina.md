---
layout: post
title: 在ArchLinux的上折腾Gwibber的新浪微博插件
slug: archlinux-gwibber-service-sina
date: 2012-02-23 23:38
tags: [archlinux, gwibber, weibo]
---

在 ArchLinux 上安装了 [Gwibber][1]，安装时是要解决各种依赖的，然后开始折腾新浪微博的插件 [Sina plugin for Gwibber][2]

解压后直接安装：

    $ cd gwibber-service-sina-0.9.1
    $ sudo python setup.py install --record=setup.log

可安装后运行 gwibber 并没有在帐户管理中发现 sina，于是在命令行中运行看到如下结果：

    $ gwibber-accounts
    ...
    Traceback (most recent call last):
      File "/usr/bin/gwibber-accounts", line 108, in &lt;module&gt;
        accounts.GwibberAccountManager(selected_account=selected_account, condition=condition, message=message)
      File "/usr/lib/python2.7/site-packages/gwibber/accounts.py", line 81, in __init__
        self.setup_account_tree()
      File "/usr/lib/python2.7/site-packages/gwibber/accounts.py", line 89, in setup_account_tree
        icon = self.get_icon(name)
      File "/usr/lib/python2.7/site-packages/gwibber/accounts.py", line 143, in get_icon
        return gtk.gdk.pixbuf_new_from_file(icf)
    glib.GError: Failed to open file '/usr/share/gwibber/ui/icons/breakdance/16x16/sina.png': Permission denied

只是些图片，把权限放低些再运行就好了。

    $ sudo chown greatghoul:users /usr/share/gwibber/ui/icons/breakdance/16x16/*
    $ gwibber-accounts

可以在列表中选择 sina 了，可以添加帐户点击 Authorize 时，控制台报错

    Traceback (most recent call last):
      File "/usr/share/gwibber/plugins/sina/gtk/sina/__init__.py", line 64, in on_sina_auth_clicked
        self.consumer = oauth.OAuthConsumer(*sina.utils.get_sina_keys())
      File "/usr/share/gwibber/plugins/sina/utils.py", line 14, in get_sina_keys
        SINA_OAUTH_KEY = data["SINA_OAUTH_KEY"]

看来这个 `/usr/share/gwibber/plugins/sina/data/sina` 文件中保存的是认证的一些信息，但是下载的安装包安装后并没有这
个文件，导致认证失败。

于是在网上找了个 [ubuntu 的包][3]，从里面取出来这么个文件放在相应目录下再运行，就可以认证并正常添加用户了。但是并不
是一切都 OK了，这个插件在打开访问新浪微博时，十分的卡，尤其是在正在更新微博的时候，滚动条基本上拖不动，鼠标滚轮也几
乎没用，用起来很不不爽，和直接浏览网页的体验差太远了。

![gwibber](http://pic.yupoo.com/greatghoul_v/BLyEZOlC/9Qh2X.png)

[1]: http://aur.archlinux.org/packages.php?ID=24544
[2]: https://launchpad.net/gwibber-service-sina
[3]: http://pkgs.org/ubuntu-11.10/ubuntu-main-i386/gwibber-service-sina_0.9.1-0ubuntu2_all.deb.html
