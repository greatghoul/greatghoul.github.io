---
slug: 30-vc6-dlg-editor-encoding
date: '2009-10-25'
layout: post
title: VC6 对话框编辑器在预览时显示乱码
tags:
  - Windows
  - MFC
issue: 30
---

我安装的是英文版 vc6，结果在新建 MFC 工程时资源文件的语言支持里面并没有中文的选项。

这样导致在建立的对话框的中的中文全部显示为乱码。

![乱码](https://github.com/greatghoul/greatghoul.github.io/assets/208966/db5464ca-76e6-4b68-8a77-58c33273f54c)

其实解决之道很简单，下载 [appwzchs.dll][1]，拷备到 `D:\Microsoft Visual Studio\Common\MSDev98\Bin\IDE` 目录下，重新
建立工程，就可以建立中文支持的项目了。(安装路径可能有所不同)

![正常](https://github.com/greatghoul/greatghoul.github.io/assets/208966/9d38a9cc-a16f-494c-8fb5-1ac37faeedae)

[1]: http://www.uushare.com/user/greatghoul/file/2155415
