---
layout: post
title: 利用VBScript在隐藏窗口中运行应用程序
slug: launch-app-in-hidden-window
date: 2010-07-26 20:39
tags: [windows]
---

**起因**

使用 [MoinMoin Desktop Edition][1] 已经有一段时间了，每次开机都得运行 `wikiserver.py`，而且总会有一个命令行的黑框，
很碍眼。折腾了半晌，终于可以干掉黑框，让 `wikiserver.py` 在后台运行了。

其实这种方法同样可以用于其它需要保持运行，但又不想看见窗口的软件。

**原理**

利用 VBScript 创建 `wscript.shell` 对象，运行一个应用程序，设置窗口为不可见。

    createobject("wscript.shell").run "要运行程序的路径",vbhide

**方案一：批处理BAT**

新建一个文件 `moin-start.bat`，编辑内容如下：

    @echo off
    if not "%1" == "h" mshta vbscript:createobject("wscript.shell").run("E:\\moin-1.9.2\\wikiserver.py",0)(window.close)&amp;&amp;exit

使用这种方式，命令行窗口会一闪而过，但之后可以达到隐藏窗口运行的目的。

**方案二：VBS脚本**

新建一个文件 `moin-start.vbs`，编辑内容如下：

    createobject("wscript.shell").run "E:\\moin-1.9.2\\wikiserver.py",vbhide
    wscript.quit

使用这种方式，不会出现控制台的窗口，可以完美得实现隐藏窗口运行。

**方案三：快捷方式**

建立一个快捷方式 `moin-start`，在【目标】一栏填写：

%windir%\system32\mshta.exe vbscript:createobject("wscript.shell").run("E:\\moin-1.9.2\\wikiserver.py",0)(window.close)

这种方式同样不会出现控制台窗口，推荐使用。

**开机自动运行**

将建立的文件丢在【开始】 -> 【所有程序】 -> 【启动】下面，下次开机，就可以自动在后台运行指定的程序了。

[1]: http://moinmo.in/DesktopEdition
