---
slug: 130-java-noclassdeffounderror
date: '2012-07-19'
layout: post
title: java NoClassDefFoundError
tags:
  - Java
issue: 130
---

遇到一个非常奇怪的错 `java.lang.NoClassDefFoundError: org/apache/commons/lang/StringUtils`

但事实上我的 commons-lang 是能够被引用到的，我将工程A的代码通过 Link Source 引用到  B 中，
B工程中是有引用这个 jar 包的，但实际使用 jar 包的代码却是在 A 工程中，恰恰 A 工程中没有引入
这个 jar 包。

这就导致了工程启动时没有报错，在运行时才会抛出这个 [NoClassDefFoundError][1]，注意不是 
[ClassNotFoundException][2]。

> The searched-for class definition existed when the currently executing class was compiled, 
> but the definition can no longer be found.

引用的类在工程编译时存在，但运行时无法被引用到，尤其是在 web 工程中，没有加入到 `WEB-INF/lib` 
的包，虽然在本地能够引用到，但工程发布后无法引用。

见这帖：<http://www.coderanch.com/t/425135/java/java/ClassNotFoundException-org-apache-commons-lang#1884896>

[1]: http://docs.oracle.com/javase/7/docs/api/java/lang/NoClassDefFoundError.html
[2]: http://docs.oracle.com/javase/7/docs/api/java/lang/ClassNotFoundException.html
