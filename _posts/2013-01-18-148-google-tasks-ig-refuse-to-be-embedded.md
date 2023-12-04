---
slug: 148-google-tasks-ig-refuse-to-be-embedded
date: '2013-01-18'
layout: post
title: 'Google Tasks 不再允许别家网站iframe嵌入 '
tags:
  - UserScript
issue: 148
---

最近写了 [Google Tasks for Pomotodo][gp] 的油猴脚本，来将 [Google Tasks][gt] 嵌入到[蕃茄土豆][p]中使用，
不过今天早上打开蕃茄土豆发现 iframe 加载失败。

> Refused to display document because display forbidden by X-Frame-Options.

通过 Chrome Developer Tools 查看 Google Tasks 的 ``HTTP Response Header`` 发现如下配置

![Google Tasks IG](https://github.com/greatghoul/greatghoul.github.io/assets/208966/8ac9d733-28bc-4572-88bf-5482ded930ac)

关于 ``X-Frame-Options`` 的设置，查看 [MDN][mdn]

显然 Google 官方已经阻止了非自家网站对 <https://mail.google.com/tasks/ig> 的嵌入，这个更改应该是昨天晚上
发生的， Google 貌似近来变得[自私][evil]起来，开始大力度的排外，虽然后来又有了些[改观][noevil]。

这次针对 Google Tasks 的调整，不知道是基于什么原因，不过希望日后 Google 能够再改回来，如果这么好的一个
工具只能在 Google 自家网站上嵌入使用，那也太操蛋了。

[gp]: https://anl.gg/post/147-google-tasks-for-pomootodo-0-3
[gt]: https://mail.google.com/tasks/ig
[p]: http://pomotodo.com/
[mdn]: https://developer.mozilla.org/en-US/docs/HTTP/X-Frame-Options
[evil]: http://www.guao.hk/posts/google-maps-has-never-been-accessible-on-internet-explorer-mobile-now-blocked-on-windows-phone.html
[noevil]: http://www.guao.hk/posts/google-enabling-maps-access-for-windows-phone-after-uproar.html
