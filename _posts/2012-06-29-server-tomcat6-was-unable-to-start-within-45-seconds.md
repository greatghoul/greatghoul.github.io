---
layout: post
title: Server Tomcat6 was unable to start within 45 seconds
slug: server-tomcat6-was-unable-to-start-within-45-seconds
date: 2012-06-29 16:06
tags: [tomcat]
---

使用 eclipse开发 java web 应用的童鞋在启动 tomcat 时可能经常会遇到这样的错误：

> **'Starting Timcat6' has encountered a problem.**  
> Server Tomcat6 was unable to start within 45 seconds. If server requires more 
> time, try increasing the timeout in the server editor.

![tomcat6](http://pic.yupoo.com/greatghoul_v/C4Pe1W2O/whr5s.png)

根据提示，打开 Eclipse Menu -> Window -> Show View -> Servers

双击的 Tomcat，打开 Server Editor，在 Timeouts 单元中将启动超时时间改长一些就好了。

![修改超时时间](http://pic.yupoo.com/greatghoul_v/C4Ps4QdC/WVEUS.png)
