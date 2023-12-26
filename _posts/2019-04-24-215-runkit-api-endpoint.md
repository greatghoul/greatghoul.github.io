---
slug: 215-runkit-api-endpoint
date: '2019-04-24'
layout: post
title: RunKit - 免费的公共 API 托管服务
tags:
  - Tool
  - Node.js
  - Serverless
issue: 215
---


**RunKit** - <https://runkit.com/>

有点标题党，今天要要推荐的这个工具，最让我心动的点：**它可以在线运行 nodejs 代码并且把它生成一个可以调用的 API Endpoint**

荐哥玩过的在线运行代码的服务太多了，比如 [CodePen] ( js, html, css )，[REPL] ( 几乎所有主流语言和框架 )，[SQLFiddle]（PG, Oracle, ...） 等，后面有机会会一一介绍。

不过 RunKit 是让我觉得有奇用的一个，我先列一下他的主要功能

* 在线运行 nodejs 代码
* 支持 npm 库
* 支持简单的文件读写
* 支持绑定 API Endpoint

前三点，别的工具比如 REPL 也有提供，不过只有 API 这个，是 RunKit 实现的最简单优雅的。

只需要 export 一个 endpoint 即可。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/fff62cf3-7533-4a6a-b1c3-998d840fe7bc)

然后就可以用类似这样的地址去访问了。

https://hello-world-vtxchmctesux.runkit.sh/

想动手尝试一下可以访问下面的地址

https://runkit.com/greatghoul/hello-world

那么，这个工具能用来做什么事情呢？

**自动化！**

无论是电脑上还是手机上，我们都可以找到一些自动化工具（比如 IFTTT）提高我们的效率，比如荐哥最近在玩的 Android 上面的 [Automate](https://llamalab.com/automate) 和 iOS 上面的[快捷指令](http://sharecuts.cn)。

但这些工具提供的功能是有限的，或者有缺陷的，拿 iOS 上面的快捷指令来举例，它处理大列表的速度非常慢，这样你在处理一个几百项的列表时，速度简直无法忍受，丝毫没有”捷径“的感觉，这时候，你可以用 RunKit 写一个简单的 API，把处理大列表的操作交给 API 来执行，然后享用处理好的结果就行了。

如果没有 RunKit，要定制一个 API，你可能需要自己有个 VPS 或者使用一些 Serverless 服务。

**相关阅读：**

- [QCloud 云函数踩坑记之异步调用返回结果为 null](https://anl.gg/post/209-qcloud-serverless)

[CodePen]: http://codepen.io
[REPL]: https://repl.it
[SQLFiddle]: http://www.sqlfiddle.com/
