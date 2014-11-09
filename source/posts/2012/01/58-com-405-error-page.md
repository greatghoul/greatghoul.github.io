---
title: 58同城联系客服页面的405错误
slug: 58-com-405-error-page
date: 2012-01-16 19:29
tags: [tomcat]
---

由于 [CSDN事件][1]，[58同城][2]客服发来邮件提示更改密码，于是前往修改，但由于我的新设定的密码包含了字母、数字及
划线以外的字符，在58同城上不能修改成功，于是我放弃了修改，记忆太多组密码是痛苦的，而自己又不怎么信任第三方密码
理工具 。

![58-0](http://pic.yupoo.com/greatghoul_v/BFKBt1pc/cgmvV.png)

58同城现有的密码规则不足以增强我之前密码的强度，于是前往[客服页面][3]联系解决。

然后遗憾的是，当我填写了所有信息提交(我把手机号的文本框架误埴成了邮箱)后，出现了 [405][4] 错误的页面

![58-1](http://pic.yupoo.com/greatghoul_v/BFKBtsLS/GP5aT.png)

![58-2](http://pic.yupoo.com/greatghoul_v/BFKBvBlk/eXIBR.png)

经过反复试验后，发现填写中文也可以顺利提交问题。如果填写次数多后，会提示输入验证码，但验证码无法验证通过。

更夸张的是，连 [404][5] 页面都用的是 tomcat 自带的。

**屎一样的网站，广告做的再多也是垃圾。**

[1]: http://coolshell.cn/articles/6193.html
[2]: http://www.58.com/
[3]: http://about.58.com/online-kefu.html
[4]: http://zh.wikipedia.org/wiki/HTTP%E7%8A%B6%E6%80%81%E7%A0%81#405
[5]: http://about.58.com/abc.html
