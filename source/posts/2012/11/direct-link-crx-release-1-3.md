---
title: 喜迎某大，Chrome扩展Direct Link更新至1.3
slug: direct-link-crx-release-1-3
date: 2012-11-13 13:37
tags: [chrome-extension, direct-link-crx, google]
---

最近是非常时期，Direct Link 因为在 [1.2][1] 版本时设定为只在页面出错时才会直接跳转到目标网站，但因为国内的环境，这个
安全检查的页面速度很慢，所以虽然可以匹配很多国家的 Google 搜索地址了，但扩展的功能基本不可用。

想要加快跳转速度，还需要手动中断安全检查的请求（在地址栏里敲回车，会中断当前请求，会触发错误跳转功能），非常麻烦，所以
这一版增加了一个设置项，来允许直接跳过检查，在安全检查请求发现前就直接强制导向目标页面，加快搜索结果打开速度，当然这样
就**牺牲了安全性**，Google 没有办法统计到搜索结果的点击情况，同时也**无法向你提供目标网址的安全建议**。

Google安全检查例子 [点击这里][2]

    http://www.google.com.hk/url?sa=t&amp;rct=j&amp;q=&amp;esrc=s&amp;source=web&amp;cd=1&amp;cad=rja&amp;ved=0CC4QFjAA&amp;url=http%3A%2F%2Fbaike.baidu.com%2Fview%2F917695.htm&amp;ei=GNyhUNHdGqSQiAfA34DADQ&amp;usg=AFQjCNGyRS1s0m3_WG-PQHipdfaGU0TxTA

![direct-link](http://pic.yupoo.com/greatghoul_v/CpEvSlrL/JFTJU.png)

项目地址：<https://github.com/greatghoul/direct-link.crx>

猎豹版本：<https://github.com/greatghoul/direct-link.crx/tree/liebao> ~~猎豹版的尚未更新，稍候会放出~~ 
++猎豹版已经在 猎豹 `v1.5.9.2888` 下测试通过++。

商店地址：<https://chrome.google.com/webstore/detail/aahdhhnjejcpknidbdjcbiooekmldflf?hl=en-US">

[1]: http://www.g2w.me/2012/09/direct-link-crx-release-1-2/
[2]: http://www.google.com.hk/url?sa=t&amp;rct=j&amp;q=&amp;esrc=s&amp;source=web&amp;cd=1&amp;cad=rja&amp;ved=0CC4QFjAA&amp;url=http%3A%2F%2Fbaike.baidu.com%2Fview%2F917695.htm&amp;ei=GNyhUNHdGqSQiAfA34DADQ&amp;usg=AFQjCNGyRS1s0m3_WG-PQHipdfaGU0TxTA
