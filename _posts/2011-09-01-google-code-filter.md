---
title: 油猴脚本Google Code Filter发布
slug: google-code-filter
date: 2011-09-01 02:35
tags: [google, google-code-filter, userscript]
---

我经常会在 [Google Code][ga] 上寻找一些开源项目，不过并不是所有项目都有比较高的活跃度，于是我最初写了一个 bookmarklet 
于去除活跃度较低的项目。

今天，我将这个脚本写成了 userscript，以便用在 firefox(需要安装 [Greasemonkey][gm]) 或者 chrome 上面，用于在搜索结果中
滤不同活跃度的开源项目。

我将这格脚本放在了 github 上供大家使用，希望能够喜欢： [GoogleCodeFilter@github][gcf]

Google Code Filter 简介
-----------------------

Google Code Filter 是一个 userscript 脚本，用于按照项目活跃度，过滤 google code 项目托管的搜索结果，目前可以过滤四种
跃度：Hight、Media、Low 和 None

![p1](http://pic.yupoo.com/greatghoul_v/BkNvQXZG/medium.jpg)

安装 Google Code Filter
-------------------------

下载 [google-code-filter.user.js][1]

 - firefox 下安装：[Beginner Guide for Greasemonkey Scripts in Google Chrome][2]
 - chrome 下安装：[The Beginner’s Guide to Greasemonkey User Scripts in Firefox][3]

改进计划
----------

 - 记忆过滤选项的状态，页面跳转时不需要重新点击过滤
 - 在工具栏中以下拉框的形式按照项目的被收藏数过滤
 - 根据项目的活跃度，为搜索结果条目设置不同的背景色

[gc]: http://code.google.com/hosting/
[gm]: http://www.greasespot.net/
[gcf]: https://github.com/greatghoul/GoogleCodeFilter

[1]: https://github.com/greatghoul/GoogleCodeFilter/raw/master/google-code-filter.user.js
[2]: http://www.howtogeek.com/howto/24790/beginner-guide-for-greasemonkey-scripts-in-google-chrome/
[3]: http://www.howtogeek.com/howto/16470/replace-extensions-with-user-scripts-in-firefox/
