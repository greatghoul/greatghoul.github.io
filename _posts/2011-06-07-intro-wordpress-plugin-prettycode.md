---
layout: post
title: Wordpress代码高亮插件 PrettyCode
slug: intro-wordpress-plugin-PrettyCode
date: 2011-06-07 22:37
tags: [php, prettycode, tinymce, webkit, wordpress, wordpress-plugin]
---

使用 wordpress 后，由于经常需要贴代码，[尝试过很多种语法高亮插件][^1]，都不怎么满意。要么是太过庞大，要么功能太过单一，或者贴代码不怎么方便。使用非IE的浏览器时，代码贴到编辑器中，往往缩进就被破坏了。基于在we­bkit内核的浏览器中，粘贴纯文本还经常出现让人蛋疼的 [#\_mcePaste][^2] 问题。

我需要这样一款插件
------------------

对于语法的着色，我没有什么太高的要求，因为经常访问[Google Code][gc]的关系，比较喜欢 [google-code-prettify][gcp] 这个着色工具。小巧灵活，加载快。

作为程序员，贴代码的时候，经常还会对代码中的函数或者语句作一些解释，我之前都是用加粗或者高亮色。不过一些专业的程序设计的网站都是使用 code 标签设置单独的样式。而目前我所接触的高亮插件中，并没有提供这些我需要的功能。于是冲动之下，[快速学习了wordpress plug­in的相关教程][^3]，并[参考了一些插件结构][^4]，对之前开发的 [prettybutton][pb] 进行了改进，制作了新的 wordpress 语法高亮插件 － PrettyCode。

这所以命名命名 **PrettyCode** ，是因为使用了 [google-code-prettify][gcp] 着色工具。

Pretty­Code介绍
---------------

**PrettyCode** 是一款 wordpress 代码高亮插件，可以方便的插入 Code Block 和 Inline Code ，使用 google-code-prettify 进行代码着色。它具有以下特性：

 * 基于 google-code-prettify 的代码高亮，无需指定语言类型，小巧方便。
 * 支持点击 tinymce 工具栏按钮弹出层来插入代码片断，免去非IE内核浏览器在 tinymce 的 visual 
   模式中粘贴代码失丢失缩进格式的问题
 * 支持点击 tinymce 工具栏按钮 选中单词或短句增加 Inline Code 的高亮效果，以蓝色等宽字体显示。
 * 支持对粘贴的 HTML 转义字符自动转义。
 * 编辑文章时，对加入的代码块增加边框效果，与其它文本区分。
 * 自动在页面中加入google-code-prettify的脚本和样式，并在文档加载完成后触发着色，无需手动编辑主题文件。

PrettyCode 的 tinymce 效果图
----------------------------

![PrettyCode](http://pic.yupoo.com/greatghoul_v/B7QGJu3X/medium.jpg)


如何安装 PrettyCode
-------------------

 1. 从 github 下载 PrettyCode ，地址： <https://github.com/greatghoul/PrettyCode>
 2. 解压后将 PrettyCode 文件夹放置在 wordpress 的 `wp-content/plugins/` 目录下即可。
 3. 在 wordpress 的 plugins 中激活 Pretty­Code。


关注 PrettyCode
---------------

PrettyCode 是一款开源的插件，你可以从下面的地址获取代码和相关的更新

 * Github - <https://github.com/greatghoul/PrettyCode>
 * Blog - <http://www.g2w.me/tag/PrettyCode/>



[gc]: http://code.google.com/intl/zh-CN/
[gcp]: http://code.google.com/p/google-code-prettify/
[pb]: http://www.g2w.me/2011/06/intro-wordpress-plugin-PrettyCode/

[^1]: http://paranimage.com/7-wordpress-syntax-highlight-plugin/
[^2]: http://wordpress.org/support/topic/paste-plain-text-with-28
[^3]: http://codex.wordpress.org/Plugin_Resources
[^4]: http://tinymce.moxiecode.com/wiki.php/Plugin:paste
