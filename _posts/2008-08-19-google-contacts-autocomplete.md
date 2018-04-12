---
layout: post
title: 在Google站外使用Gmail联系人列表
slug: google-contacts-autocomplete
date: 2008-08-19 13:53
tags: [gmail, google, userscript]
---

如果你是Gmail用户，许多Google服务会访问你的联系人列表，而你可以轻松的通过[联系人选择器][1]的自动完成功能添加联系人地
址。但如果你想在非Google站点上使用Gmail联系人列表该怎么办呢？很多新闻站点都有发送链接给好友的功能，而且很多情况下，这
比登录Gmail复制链接地址要方便得多。

[Google Contacts Autocomplete][2] 是一个可以让你在任何网站使用Gmail通讯录的 [Greasemonkey][3] 脚本。该脚本会根据你输入
的好友名字或邮箱地址出现提示信息。

![Google Contacts Autocomplete](http://pic.yupoo.com/greatghoul_v/Bii4M1xM/vDlfV.png)

目前，该脚本只支持单地址输入,但我相信这个问题应该不难修正。与Gmail不同，该脚本根据字母顺序对匹配结果排序, 而不是靠
[热度][4]。

原文：<http://googlesystem.blogspot.com/2008/07/portable-gmail-contacts.html>

[1]: http://googlesystem.blogspot.com/2007/07/faster-way-to-invite-contacts-to.html
[2]: http://userscripts.org/scripts/show/29604
[3]: https://addons.mozilla.org/en-US/firefox/addon/748
[4]: http://googlesystem.blogspot.com/2006/12/affinity-between-you-and-your-gmail.html
