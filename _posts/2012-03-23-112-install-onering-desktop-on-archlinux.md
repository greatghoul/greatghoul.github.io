---
slug: 112-install-onering-desktop-on-archlinux
date: '2012-03-23'
layout: post
title: Archlinux下安装onering-desktop
tags:
  - Python
  - Linux
issue: 112
---

[onering] 是一个以开发 web 应用的方式开发桌面应用的框架，使用 html5 和 css 构造UI，
使用python或者其它语言实现软件功能，使用一个封闭的js来操作 web 页与操作系统间的通信，
[豆瓣FM桌面版][fm]就是使用 onering 开发的。

官方的安装手册中没有 archlinux 的，只有 ubuntu ([wiki1][1], [wiki2][2]</a>)的，不过大同小异。

安装 onering
----------------

1) 安装 qt 和 qtwebkit

    $ sudo pacman -S qt qtwebkit

2) 下载 onering 源代码 (没有 [hg] 的自行下载)

    $ hg clone https://code.google.com/p/onering-desktop/

3) 安装 onering

    $ cd onering-desktop
    $ mkdir build
    $ cd build
    $ qmake ..
    $ make

make 成功后拷备 onering 库到系统目录

    $ sudo cp libOneRing.so /usr/lib/libOneRing1.so
    $ sudo cp libOneRing.so.1 /usr/lib/libOneRing.so.1

4) 安装python-binding

    $ cd bindings/python
    $ sudo python setup.py install --record=setup.log

运行 Demo
------------

1) 安装依赖

    $ sudo easy_install web.py
    $ sudo easy_install mako

2) 运行Demo

    $ cd demo
    $ python demo.py

Demo运行效果

![onering-desktop-demo](https://github.com/greatghoul/greatghoul.github.io/assets/208966/f875518a-e92d-4b7e-97f6-c9a34718732a)


资源
---------

 - [OneRing 项目地址][onering]
 - [OneRing讨论组][3] (加入讨论：向 [onering-desktop+subscribe@googlegroups.com][4] 发送任意内容的邮件订阅列表)
 - 类似技术：[pyjamas-desktop][pyjs]、[appcelerator][5]、[HTA][hta]
 - PPT: [OneRing @ OSCamp 2010][6]

[1]: http://code.google.com/p/onering-desktop/wiki/InstallationOnUbuntu
[2]: http://code.google.com/p/onering-desktop/wiki/RunDemo
[3]: https://groups.google.com/forum/?fromgroups#!forum/onering-desktop
[4]: mailto:onering-desktop+subscribe@googlegroups.com?subject=申请加入&amp;body=申请加入
[5]: http://www.appcelerator.com/
[6]: http://www.slideshare.net/hongqn/onering-oscamp-2010
[fm]: http://douban.fm/app#desktop
[hg]: http://mercurial.selenic.com/
[hta]: http://msdn.microsoft.com/en-us/library/ms536496(v=vs.85).aspx
[onering]: http://code.google.com/p/onering-desktop
[pyjs]: http://pyjs.org/
