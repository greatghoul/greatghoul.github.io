---
slug: 244-filter-gmail-spam-in-google-app-script
date: '2022-01-21'
layout: post
title: 使用 Google App Script 过滤 Gmail 中的垃圾邮件
tags:
  - Google Apps Script
issue: 244
---

最近几个月，Gmail 总是收到很多垃圾邮件，来自不同地址，标题五花八门，无论 Mark as Spam 多少次，Gmail 依然无法自动识别这些邮件。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/4a6b90e2-648a-48aa-acf6-4069fb6fef65)

每次标记垃圾邮件没有效果，只能自己想办法了，我发现这些邮件大多都来自很少见后缀的域名，.biz, .nl, .uk 等等，并且都有着 webmaster, admin 这样的前缀。

首先尝试使用 Gmail 内建的过滤器，结果 Gmail Filter 中使用通配符的效果差强人意，你可以使用类似这样的关键词进行搜索过滤。

```
in:anywhere from:(contact*@*.uk OR @*.nl)
```

但是想要更精细一些，就效果不太好了，于是想到了 [Google App Scripts](https://developers.google.com/apps-script)，简单的学习之后，写了一个初始的脚本。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/9d422409-1dff-4489-aa71-b438465b1732)

这样其实就可以挡住很多发件地址特征很明显的垃圾邮件了，但是还有一些，没有那么好识别，于是我对脚本又做了一些改进，设置了邮件标题和发件地址的组合标记。

```javascript
const EMAILS = {
  spam: [
    /webmaster@.*\.uk/i,
    /admin@.*\.uk/i,
    /.*winner.*@.*\.biz/i,
  ],
  warn: [
    /.*@.*\.biz/i,
    /.*@.*\.nl/i,
    /.*@.*\.uk/i,
  ]
}

const SUBJECTS = {
  spam: [
    /GEICO/i,
  ],
  warn: [
    /credit/i,
    /score/i,
    /arrived/i,
    /health/i,
  ]
}
```

如果 Subject 和 From 任何一个命中 spam 规则，就标记垃圾邮件，如果同时命中 warn 规则，也标记为垃圾邮件。这样又干掉了一大批。

但是仍然剩下一些顽疾的邮件，处理不掉，他们的标题和域名都没有特别明显的特征。

比如下面这种通篇就一个大图加一个文字链接，有的甚至没有文字，只在图片上面放了链接。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/c4908b25-c460-4a87-9981-5bddb583c663)

这种正文这么明显的，Google 都无法识别也是醉了。通过查看邮件原始内容，发现了一些端倪。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/b20e56f9-e691-4368-9629-5ba13ee71467)

以红线作为分割，上面的是邮件显示的内容，下面的是隐藏的内容，看似是一片有内容的邮件，实则暗藏玄机。

这样就好处理了， `<object>` 标签正经邮件谁会去用呀，于是我又给脚本追加了一条判断规则：正文同时包含隐藏内容
