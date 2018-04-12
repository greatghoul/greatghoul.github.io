---
layout: post
title: Chrome下Google Reader访问异常
slug: failed-loading-google-reader-in-chrome
date: 2010-12-01 18:11
tags: [google, google-reader]
---

今天在使用 Chrome 正式版7.0.517  访问 [Google Reader][gr] 时无法加载

![Google Reader](http://pic.yupoo.com/greatghoul_v/AFe0yKdt/medium.jpg)

查看控制台发现加载的控制滚动条的样式和脚本文件访问异常。

    https://www.google.com/reader/ui/2847889407-en-scroll.css?hl=en
    https://www.google.com/reader/ui/485118933-en-scroll.js?hl=en

不过在IE下一切正常，不知道哪里出了问题，不知道大家有没有遇到这样的问题。

**update:** gmail也出现了类似的问题  
**update:** google reader http 访问正常

[gr]: https://reader.google.com/
