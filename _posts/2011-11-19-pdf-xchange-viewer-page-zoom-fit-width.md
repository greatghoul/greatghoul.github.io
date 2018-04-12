---
layout: post
title: PDF-XChange Viewer固定页面缩放方式为适应宽度
slug: pdf-xchange-viewer-page-zoom-fit-width
date: 2011-11-19 20:41
tags: [software]
---

看了[善用佳软的介绍][1]，用上了 [PDF-XChange Viewer][2]，这个软件的UI真是漂亮，非常喜欢，不过默认配置下，页面缩放方式
是“适应宽度”，即便手动设置后，点击书签后，还会恢复为默认设置 。

要固定为自动适应宽度，通过菜单 **Edit » Preferences** 打开设置窗口，切换 **Categories** 到 **Page Display** 标签页。

![PDF-XChange Viewer Preferences](http://pic.yupoo.com/greatghoul_v/BwT8Mp9z/V6DG4.png)

如图，设置 **Default Page Zoom** 为 **Fit Width**，再勾选 **Forbid the change of the current Zoom factor during 
xecution of 'Go to Destination' actions (these actions can be launched from bookmarks, hyperlinks, java-scripts).**

[1]: http://xbeta.info/pdf-xchange-viewer.htm
[2]: http://www.pdfxviewer.com/
