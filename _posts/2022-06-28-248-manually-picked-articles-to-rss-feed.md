---
slug: 248-manually-picked-articles-to-rss-feed
date: '2022-06-28'
layout: post
title: 手工维护文章列表并生成 RSS 订阅
tags:
  - RSS
issue: 248
---

[GDG 西安](https://gdgxian.org/)的微信群中，经常会有群友发一下原创技术文章，作为技术社区，我们也是鼓励这样的行为的。

![微信群分享技术文章](https://github.com/greatghoul/greatghoul.github.io/assets/208966/324cf5a9-b493-456f-a000-43812a3cfb14)

正好我最近找到一个不错的 [RSS 阅读器](https://feedreader.com/)（有当年 Google Reader 的感觉），于是心血来潮，想着手工整理这些文章，然后输出 RSS 链接，以供同样喜欢使用 RSS 的朋友订阅。

微信群难受一些，但是 Telegram 群组是可以很方便的订阅 RSS 的，这样可以多多少少给文章传播起到一些推动作用。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/3a331045-cf81-43f6-853e-964eef0129db)

## RSS.APP

我首先找到的是 [RSS.APP](https://rss.app/) 这个服务，操作体验非常棒，甚至可以自定义 RSS 条目的作者和发布时间，

![RSS.APP Collection 管理截图](https://github.com/greatghoul/greatghoul.github.io/assets/208966/011db0b1-63fc-40a7-bf2c-83c92196eb9e)

本来高兴坏了，太棒了这个服务，但是突然发现我的账号是试用版，于是仔细阅读了下价目表，好家伙，不但不支持 Collection，甚至还不能直接链接到文章原文，试用期过后，我这刚建立的 RSS 就废了。

![免费版使用限制](https://github.com/greatghoul/greatghoul.github.io/assets/208966/bb84af1b-a779-4c0c-ba4b-6a784a8cb400)

即使最低档的付费版，Collection 中也只能加 25 个文章，并且开启原文链接功能，那还玩个毛线呀，只能拿来当 Demo。

![付费版使用限制](https://github.com/greatghoul/greatghoul.github.io/assets/208966/6982773e-0911-4436-b5d6-d6d97c47eae5)

这本就是个业余的事情，实在没必要掏这份钱，而且掏了钱也达不到需求，只能寻求其它路子了。

## Notion 加自建服务

于是我考虑到了 Notion，自定义非常方便，无非就是需要有个服务来读取 Notion 内容然后生成 RSS 链接。

我之前有使用过 Notion API 做一些应用，也[使用过 Runkit 服务生成过自定义 RSS](https://github.com/liyang5945/liyang5945.github.io/issues/2)，两者结合，一定是能走得通的。

万不得已还可以用这种方式，就在准备尝试一下的时候，发现了一个书签管理服务竟然自带 RSS 功能。

## Raindrop IO

[Raindrop](https://raindrop.io/) 这是一个书签管理服务，可以使用 Collection 来整理书签并且分享。

![Raindrop Collection](https://github.com/greatghoul/greatghoul.github.io/assets/208966/844c1e39-e4df-4871-91e3-74e7f1024951)

收集文章也很方便，官方有各种应用以及浏览器 Bookmarklet

![Bookmarklet 收集文章](https://github.com/greatghoul/greatghoul.github.io/assets/208966/53a45cfc-f4a7-4288-998f-dea931809659)

最方便的是支持生成 RSS，简直零代码有木有，甚至支持生成[开放网页](https://raindrop.io/greatghoul/a-25593443)，以及多人协作编辑，以后有想要一起维护列表的朋友了，可以很方便的邀请。这样功能强大的服务，免费版本还没有数量限制，太良心了。

![分享 Collection](https://github.com/greatghoul/greatghoul.github.io/assets/208966/38ad4da5-b428-42ad-9624-efa50b5683ad)

![价目表](https://github.com/greatghoul/greatghoul.github.io/assets/208966/38ec44a0-c8c2-4659-aaf6-25e297a6221c)

如果你也是西安的开发者，并且喜欢使用 RSS，欢迎订阅。

https://raindrop.io/collection/25593443/feed


