---
layout: post
title: VC6 对话框编辑器在预览时显示乱码
slug: vc6-dlg-editor-encoding
date: 2009-10-25 19:11
tags: [MFC, VC6]
---

我安装的是英文版 vc6，结果在新建 MFC 工程时资源文件的语言支持里面并没有中文的选项。

这样导致在建立的对话框的中的中文全部显示为乱码。

![乱码](http://pic.yupoo.com/greatghoul_v/BdBJN59s/mJCYr.jpg)

其实解决之道很简单，下载 [appwzchs.dll][1]，拷备到 `D:\Microsoft Visual Studio\Common\MSDev98\Bin\IDE` 目录下，重新
建立工程，就可以建立中文支持的项目了。(安装路径可能有所不同)

![正常](http://pic.yupoo.com/greatghoul_v/BdBJLJuB/V3wtc.jpg)

[1]: http://www.uushare.com/user/greatghoul/file/2155415
