---
layout: post
title: 油猴脚本Google Code Filter更新至0.2版
slug: google-code-filter-update-0-2
date: 2011-11-29 01:13
tags: [google-code-filter, userscript]
---

之前写过一个 [Google Code Filter][1] 的 userscript 脚本, 用于按照项目活跃度，过滤 [Google Code Hosting][2] 中开源项目
搜索结果。

第一版的功能非常简单, 不支持记忆功能，本次的 0.2 版本，加入了记忆功能，设置的过滤项状态会保存下来，下次打开网站会自动
上次的配置对搜索结果进行过滤,让你在搜索 [Google Code Hosting][2] 中的开源项目时,不用再去关注那些活跃度低的项目,提高搜
效率.

![Google Code Filter截图](http://pic.yupoo.com/greatghoul_v/BkNvQXZG/dy0TK.png)

**项目地址:**

<http://userscripts.org/scripts/show/119604>

**本次更新:**

 * 更改过滤项后自动保存状态,下次打开项目搜索页面时自动按上次设置进行过滤
 * 同时支持 Firefox 的 Greasemonkey 和 Google Chrome 浏览器下的 userscript 

[1]: http://www.g2w.me/2011/09/google-code-filter/ "油猴脚本Google Code Filter发布"
[2]: http://code.google.com/hosting "Google Code Hosting"
