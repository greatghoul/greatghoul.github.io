---
slug: 195-zapier-to-gmail-diary-workflow
date: '2017-12-05'
layout: post
title: 使用 Zapier 实现用邮件写日记
tags:
  - Tool
  - Automation
issue: 195
---

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/517eab8e-f349-477f-a720-49db67c1cdcb)

年前，我写过一篇文章《[记日记：从 ohlife 到 littlememo](https://anl.gg/ohlife-littlememo)》，记录我所使用的写日记的服务。

我喜欢使用邮件写日记，因为它有下面的一些好处。

* 方便：不需要安装额外的软件，只要有邮件客户端，哪里是网页版邮箱都可以记日记。
* 私密：日记都保存在自己的邮箱中，非常安全（尤其你使用的是 Gmail 的话）。
* 搜索：使用邮件的全文搜索，很方便回顾过往的日记。
* 稳定：只要你使用的是靠谱的公司的邮箱，基本不用担心数据会丢失或者服务关闭。

最早我使用 ohlife，后来它关闭了，我又迁移了到了 littlememo 这个平台，它可以像 ohlife 一样，每天早上给我发一封邮件，我只要回复邮件，回复的内容就会自动追加到今天的日记。想到点什么，记上去，整个记日记的过程行云流水。

但最后我还是离开了 littlememo 这个平台，因为不能坚持每天都写日记，littlememo 隔段时间，自动发送邮件的机制就会关闭，需要重新登录服务来激活，非常麻烦。所以我转为纯手工的方式：想写日记了，自己给自己写一封以今天日期命名的邮件，然后加上 Diary 的标签，方便搜索和回顾。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/393c62a1-309b-418c-ac85-143ba14685a7)

然而我是个非常懒的人，这样一天两天，感觉还行，天天要自己新建邮件，就感觉挺麻烦了，即使我设置了快捷键自动在邮件标题中插入今天的日期，依然觉得很麻烦。有没有更好的解决方案呢？

我看了些类似 littlememo 的服务以及专业的日记应用。

* [dayjot](https://dayjot.com/ ) - 一个开源的 ohlife 替代品，界面简洁，如果你自己不懂得部署应用的话，可以购买它的线上服务，每月 $3，看了下 github 上开源的项目，几年没有更新了，感觉不值（类似的服务还有很多，比如 [maildiary](https://maildiary.net/v2/), [dailydiary](https://www.dailydiary.com/)，但都有一些限制，而且不知道哪天说不定服务就关闭了）
* **Day One** - 非常知名的日记应用，但是不支持 Android，我不可以每次只在 Mac 上面写日记，而且要安装应用。
* **MailChimp** - 类似的邮件服务很多，但都没有特别方便的自动触发机制，需要写代码，太折腾。

没有特别满意的，直到最后我发现了 Zapier 这个神器：[Send daily emails with Gmail](https://zapier.com/apps/gmail/integrations/schedule/2809/send-a-daily-email-with-gmail)

这是一个类似 IFTTT 的服务，不但可以定制每天发送邮件的时间，还可以利用变量生成包含日期的邮件标题，很好的满足了需求。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/ce9aee3f-e140-4378-823e-26471d0136cb)

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/0d5a42c7-dc2e-4495-be69-4dd30deb2fdd)

唯一的遗憾是不能像 littlememo 那样，在每天发送的日记邮件中随机包含一篇过往的日记，这样写新的日记中，顺便缅怀一下以前的种种，可能会有些不一样的感受。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/523272cb-518e-4c7b-bd85-50cd12e70fbb)

虽然有些遗憾，但事事追求完美，反而会有些不美。
