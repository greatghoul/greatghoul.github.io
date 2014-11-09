---
title: tomcat启动失败:Failed creating java jvm.dll
slug: tomcat-failed-creating-java
date: 2011-01-19 03:02
tags: [java, jvm, tomcat]
---

在启动 tomcat6 时失败，错误信息是：

    [2011-01-12 17:20:54] [174 javajni.c] [error] 找不到指定的模块。
    [2011-01-12 17:20:54] [994 prunsrv.c] [error] Failed creating java D:\Java\jre1.6.0_10\bin\client\jvm.dll
    [2011-01-12 17:20:54] [1269 prunsrv.c] [error] ServiceStart returned

原因很纠结，可能是重装了 java 导致安装版的 tomcat 配置出错。

有一个简单的解决办法是将 jdk 的 `bin` 目录下的 `msvcr71.dll` 复制到 tomcat 的 `bin` 目录下，重启 tomcat 即可，原理未明。
