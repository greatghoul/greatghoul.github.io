---
slug: 125-server-tomcat6-was-unable-to-start-within-45-seconds
date: '2012-06-29'
layout: post
title: Server Tomcat6 was unable to start within 45 seconds
tags:
  - Java
issue: 125
---

使用 eclipse开发 java web 应用的童鞋在启动 tomcat 时可能经常会遇到这样的错误：

> **'Starting Timcat6' has encountered a problem.**  
> Server Tomcat6 was unable to start within 45 seconds. If server requires more 
> time, try increasing the timeout in the server editor.

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/24a6296c-82fc-4492-b1d9-a204b89c0bd4)


根据提示，打开 Eclipse Menu -> Window -> Show View -> Servers

双击的 Tomcat，打开 Server Editor，在 Timeouts 单元中将启动超时时间改长一些就好了。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/37bec17e-6ed3-4361-9d34-8824f73883a1)

