---
title: 跳过Google搜索结果链接安全检查的Chrome扩展 Direct LINK
slug: chrome-extension-direct-link
date: 2012-07-03 07:31
tags: [chrome-extension, direct-link-crx, google]
---

大家在 Google 搜索时经常遇到搜索结果的链接打不开吧，直接在 `http://www.google.com/url?` 或者 
`http://www.google.com.hk/url?` 安全检查这一步就被重置了，如果你急着看搜索结果，这是非常让人恼火的。

这个扩展就是跳过安全检查直接打开目标网址滳。

因为使用了 [webRequest API][1]，为了安全性等原因，提交至 webstore 可能需要十天的检查期，所以没有办法立即给出安装链接，
果感兴趣的话，可以自己在 github 上面下载，[本地安装][2]。

事实上 webRequest API 可以做很多事的，比如我们访问 [Bootstrap Document][3] 时，如果没有翻墙，
<http://platform.twitter.com/widgets.js> 这个文件一直会加载很长时间然后才失败，导致 bootstrap 插件的 demo 要过十几秒
能看，如果用 webRequest API，则可以让这些被墙的东东立即就失败。


项目地址：<https://github.com/greatghoul/direct-link.crx>

[1]: http://code.google.com/chrome/extensions/webRequest.html
[2]: http://code.google.com/chrome/extensions/getstarted.html#load-ext
[3]: http://twitter.github.com/bootstrap/javascript.html

