---
layout: post
title: WP插入代码插件 Prettify Button 发布
slug: prettify-button
date: 2010-11-19 20:10
tags: [php, wordpress, wordpress-plugin]
---

刚刚建起自己的WP没有多久，许多东西还都不熟悉，寻找了很多代码高亮效果，最后觉得[google-code-prettify][^1]的高亮效果最好。

不过似乎大部分高亮插件都没有提供一个比较好用的插入代码的按钮，有些提供了，却要弹出一个对话框，说实话，[TinyMCE][^1]的虚拟对话框真的很慢。

关于 Prettify Button
--------------------

偶然看到了一篇[开发WP编辑器按钮插件的教程][^3]，下定决心准备自己做一个插件，折腾了几个小时之后，插件就出炉了(一赞这篇教程写的好，二赞WP的扩展开发的灵活)。

> **插件名称：** Prettify Button  
> **插件介绍：** 为 TinyMCE 增加一个按钮，点击后将编辑器中选中的内容用 `<pre class="prettyprint"></pre>` 包裹起来。
> 本插件只提供插入代码功能，不提供高亮功能，要使用 `google-code-prettify` 高亮，
> 还需要安装其它插件（推荐 [Code Block Enabler][^4]）。  
> **下载地址：** <http://www.uudisc.com/user/greatghoul/file/3700479>

上传插件激活后即可使用

使用效果截图
------------

![Prettify Button 插件使用效果图](http://pic.yupoo.com/greatghoul_v/ADpE4zO9/6bn8R.png)

一些遗憾
---------

最新版的WP会过滤掉HTML标签里面的一些属性，比如pre标签里面的class属性，这导致最初插入的脚本不能显示高亮，因为css类名prettyprint丢失了。

后来找到了[解决方法][^5]，但却带来了[副作用][^6]，在 Webkit 内核的浏览器里面粘贴纯文本时，纯文本会被粘贴两次，第二次排版混乱，查看源代码发现文字被贴上了 `<div id="_mcePaste">XXXX</div>` 标签。对 Chrome 死忠的我来说，这的确有些让人难以接受，求助解决方法。

[^1]: http://code.google.com/p/google-code-prettify/ "Google Code Prettify  Google Code"
[^2]: http://tinymce.moxiecode.com/ "TinyMCE主页"
[^3]: http://brettterpstra.com/adding-a-tinymce-button/ "ADDING A TINYMCE BUTTON TO WORDPRES"
[^4]: http://wordpress.org/extend/plugins/code-block-enabler/ "Code Block Enabler WP插件"
[^5]: http://www.engfers.com/2008/10/16/how-to-allow-stripped-element-attributes-in-wordpress-tinymce-editor/ "How To Allow Stripped Element Attributes in WordPress’ TinyMCE Editor"
[^6]: http://wordpress.org/support/topic/wp-admin-issue-with-chrome-and-pasting-plain-text-in-visual-view "Topic: Why is Tiny MCE adding mce_style and mce_href tags?  "


