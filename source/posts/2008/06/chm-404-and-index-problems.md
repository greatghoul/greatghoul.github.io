---
title: CHM文件内容无法查看及无法索引的解决方法
slug: chm-404-and-index-problems
date: 2008-06-18 13:29
tags: [windows]
---

我装的是英文版的 windows xp，有好几次出现了chm文件无法打开的问题。

第一次是没有把语言设置成中文，导致 `hh.exe` 无法打开中文文件名的 `chm` 文件。

第二次是中文和英文的都无法打开。在网上终于搜到了方法。分享给大家。

> HH.EXE 用的是 ms-its 等协议，这些协议应该是由某个 DLL 文件提供服务的。问题是，是什么 DLL 呢？于是再用 Google 
> 搜索 **ms-its** 协议。终于找到了，原来是一个 `itss.dll` 在做服务。不过网上查到的解决方案是修改注册表。看着那一堆
> 注册表项就头痛，还是先试试偷懒的办法吧——重新注册DLL： `regsvr32 itss.dll`

再试，嘿，好了，chm 又可以正常打开了。

至于 chm 不能打开的原因，据网上说，多半是因为 Microsoft 修复的一个关于 HTML Help 的漏洞有关系。不过我机器上的状况
不太符合特征，管它呢，反正我又能阅读  chm 了。

对于出现的无法对索引进行搜索的问题,已经找到了解决方案

`hhctrl.ocx` 等文件出现了问题，可以尝试

    regsvr32 hhctrl.ocx
    regsvr32 itss.dll
    regsvr32 itircl.dll //这个很重要，是关于全文搜索的。

