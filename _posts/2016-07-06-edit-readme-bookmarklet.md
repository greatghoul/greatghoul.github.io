---
layout: post
title: 编辑 GITHUB README 的小书签
date: 2016-07-06 21:58 CST
tags:
  - Github
  - Bookmarklet
  - Awesome List
---

Github 上面有许多 [Awesome List]，我自己也有整理一些，整理的比较频繁的的，
是 [远程工作资料][remote-working]。

Github 上面的 Awesome List 一般都是使用 Markdown 来编写在项目的 `README.md` 文件中。
编辑这种单文件的项目，相比于下载到本地后编辑再推送，我更喜欢使用 Github 的在线编辑器，
虽然这个编辑器并不怎么好用。

要在线编辑 `README.md` 文件，通常需要在文件列表中点击 `README.md` 文件然后等待页面加载好
（在天朝通常很慢），然后在点击编辑按钮打开在线编辑器，然后就可以进行编辑了。

![](http://greatghoul.b0.upaiyun.com/1607/n3_Xu-QpLIzmk.png)
![](http://greatghoul.b0.upaiyun.com/1607/2MZwteEH9cpJk.png)

这个过程非常繁琐，一天要是多来几次就会受不了了，你当然可以把编辑 README.md 的网址存成书签，
但如果有多个项目要维护，你就得存很多书签，然后每次需要去找，并不是经济的解决方案，
于是我写了个[小书签](/tags/bookmarklet/)：

    javascript:document.location = document.querySelector('[property="og:url"]').content + '/edit/master/README.md';

Github 项目的页面源码中都会有这样一个标签。

    <meta content="https://github.com/username/repo-name" property="og:url" />

这个小书签正是用它来构造出编辑 `README.md` 文件的网址，然后跳转，没有什么技术含量，
但的确方便了我日常的操作，减少了很多次点击。不过这个小书签有个限制，
你的 README 文件必须命名为 `README.md`，不然它找不到。虽然有诸多限制，但还是希望大家能喜欢。

要使用这个小书签，将下面的链接拖动到书签栏，在需要编辑 README 的 Github 页面上点击即可编辑。

<a href="javascript:document.location = document.querySelector('[property=\'og:url\']').content + '/edit/master/README.md';" class="btn btn-success">Edit README</a>

----

最近在构思做一个专门用于编辑 Awesome List 的 Chrome 扩展，提供快速编辑按钮，失效 URL 检测，
生成 Table of Content，列表模板等实用的功能。

[remote-working]: https://github.com/greatghoul/remote-working
[Awesome List]: https://github.com/search?utf8=%E2%9C%93&q=Awesome&type=Repositories&ref=searchresults

