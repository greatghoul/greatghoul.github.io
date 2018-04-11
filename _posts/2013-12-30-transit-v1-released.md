---
layout: post
title: Chrome 划词翻译扩展 TransIt
slug: transit-v1-released
date: 2013-12-30 10:22
tags: [chrome-extension, crx-transit, veaku, release]
---

## 无间断阅读 

在 [西安 GDG DevFest 2013][1] 活动中，我和 [andy] 聊到了目前我们用的 Chrome 翻译扩展进行划词翻译
后都会在最**显眼位**置弹出翻译结果的浮层，甚至你还要手动关闭它，从而**打断了阅读**。

我们只是想知道这个词的意思然后继续我们的阅读而已，甚至都不关心它怎么发音。所以，我们两个都需要一
个对阅读打扰比较小的翻译扩展，正好 [david] 也有兴趣，所以后来我们专门聚了下，准备一起用业务时间做
一个翻译扩展 **TransIt**

## TransIt

**TransIt** 是一款简单的划词翻译扩展，它的目的是划词翻译时尽可能的减小对阅读的影响。 

TransIt 目前的特性：

- 划词后在页面右上角显示简单的翻译结果，指定时间后自动消失
- 支持连续对多个单词进行划词翻译，翻译结果会顺序显示在页面上
- 在超链接上按住 Shift 键可以临时禁用该链接，方便对链接中的文本进行划词翻译
- 本地缓存已查询过的单词，再次查询时能够迅速返回翻译结果
- 可能通过设置开启/禁用页面划词、链接划词，也可以设置翻译结果显示的时间
- 更新设置后立即生效，不用再刷新页面

扩展截图：

![1](http://pic.yupoo.com/greatghoul_v/DqjjwTvE/glx96.png)

![2](http://pic.yupoo.com/greatghoul_v/Dqjjw7WC/nzSYi.png)

![3](http://pic.yupoo.com/greatghoul_v/Dqjjvl2w/UUts0.png)

扩展已经发布在 Webstore 上面

<https://chrome.google.com/webstore/detail/transit/pfjipfdmbpbkcadkdpmacdcefoohagdc?utm_source=chrome-ntp-icon&gl=CN&hl=zh-CN>

欢迎试用，目前 TransIt 还有许多问题，我们会不断的改进它，如果你觉得它给你带来了便利或者它还有哪些缺陷，
都欢迎在 Webstore 上进行反馈。

## 我们的团队

为了开发这个扩展，我们成立了**微酷团队(Veaku)**，以后还会给大家带来更多好用的小工具。

[andy]: http://weibo.com/yorzi "西安 Rubyists 组织者"
[david]: http://weibo.com/kingheaven "西安 GDG 组织者"

[1]: https://plus.google.com/u/0/events/gallery/cbsicog4jbmbj12rircq5d9hg4c

