---
title: 更新Chrome扩展Direct Link至1.1
slug: direct-link-crx-release-1-1
date: 2012-07-28 17:01
tags: [chrome-extension, direct-link-crx, google]
---

我以前前发布的 Chrome 扩展 [Direct Link][1]，现在已经做了一些升级

现在做了对 Google 图片搜索的支持
--------------------------------

当使用 google.com 或者 google.com.hk 进行搜索图片时，点击搜索链接后打开的图片详情页面如果被重置，会跳转到原图的地址。

如果想看到图片的引用页面，暂时请自行打开扩展 background page 的 console 查看，以后会做成更方便的方式，或者增加设置
允许用户选择被重置后跳转到图片原图还是引用页面。

在下一版本中，还会支持 Google 图片搜索结果第一页后缩略图无法显示的问题。

对页面重定向方式的调整
----------------------

对于网页和图片搜索，现在改为只有在请求错误（一般来说，都是 CONNECTION RESET ）后才会跳转到最终地址。

对于[猎豹浏览器的分支][2]也进行了更新，需要的自己下载安装。

项目地址：<https://github.com/greatghoul/direct-link.crx>

商店地址：<https://chrome.google.com/webstore/detail/aahdhhnjejcpknidbdjcbiooekmldflf?hl=en-US>

[1]: http://www.g2w.me/2012/07/chrome-extension-direct-link/
[2]: https://github.com/greatghoul/direct-link.crx/tree/liebao
