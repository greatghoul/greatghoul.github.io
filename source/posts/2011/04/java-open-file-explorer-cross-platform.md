---
title: java打开资源管理器的跨平台解决方法
slug: java-open-file-explorer-cross-platform
date: 2011-04-28 00:51
tags: [java]
---

在 [Stack Overflow][1] 上看到个 java 打开资源管理器的跨平台解决方法，很简单，不需要指定 explorer.exe 什么的。

    java.awt.Desktop.getDesktop().open(new java.io.File("/tmp"));

So easy! 有木有！

[1]: http://stackoverflow.com/
