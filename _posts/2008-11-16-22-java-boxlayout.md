---
slug: 22-java-boxlayout
date: '2008-11-16'
layout: post
title: Java Swing BoxLayout 布局心得
tags:
  - Java
  - Swing
issue: 22
---

现在连去外面的世界方便了，偶尔还去自己以前 [blogger][1] 上的小站逛逛，看看以前一些稚嫩的文章，不过有一些也都是自己成长
的点滴，blogger 不能访问已经好久了，于是决定把一些文章发到自己的新博客上来，算是个纪念。

非常喜欢 java 的布局方式,但系统提供的寻几个基础布局方式太不强大,在使用时很不便.尤其是 `BoxLayout` 时,会改变添加到其中的
组件的大小,组件会因为容器大小的关系被撑得很难看.

经过反复实验,找到了一种解决方法 ---- **容器嵌套**

在应用了 `BoxLayout` 的容器外层套一个应用了 `BorderLayout`, 根据需要,将内层容器添加到外层容器的非 `center` 位置。
这样 `BorderLayout` 就可以限制内层容器到最合适的大小.

[1]: http://greatghoul.blogspot.com/
