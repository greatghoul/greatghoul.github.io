---
slug: 9-new-dwz-bookmarklet
date: '2016-06-15'
layout: post
title: 新的短网址小书签应用
tags:
  - Python
  - Tool
  - Flask
issue: 9
---

之前发布过一个[小书签](https://zh.wikipedia.org/wiki/%E5%B0%8F%E4%B9%A6%E7%AD%BE)应用《[百度短网址应用](http://ghoulmind.com/2015/02/baidu-dwz-port/)》，部署在 [Coding.net](https://coding.net/) 的演示平台上面的，但后来这个演示平台越来越不靠谱，最早是纯静态页面都整天挂，后来改成一个 PHP 单页，挂得更频繁了，现在干脆收费了，看来演示平台是玩不成了。

自己的 VPS 只是单纯的部署了个博客，有些浪费，于是就把这个短网址服务用 Python 重写，并发布到自己的 VPS 上面了。

访问网站 <http://dwz.ghoulmind.com/> 或者把小书签 <a href="javascript:(function(){window.open('http://dwz.ghoulmind.com?url='+encodeURIComponent(location.href),'_blank','width=450,height=260');})()" class="label label-success">缩短网址</a> 拖动到书签栏使用。 

![小书签界面](https://github.com/greatghoul/greatghoul.github.io/assets/208966/7991f5ad-15cb-4c8d-9845-7d16ae17b33c)

## 更换了短网址的服务

之前版本的短网址使用的是百度的 API，但百度的短网址虽然不需要 API\_KEY 就能调用，但有很多缺陷，比如一些 https 的网址或者新注册的域名，它便不能转换，谁知道它拿网址干什么了，转换个短链竟然会失败。

![百度短网址服务](https://github.com/greatghoul/greatghoul.github.io/assets/208966/93fb3cc8-b197-460f-939a-f6782f66eb21)

国内开放 API 的短网址服务非常少，有的文档做的很烂，有的限制很多，有的还给你套一层 iframe，找来找去，找到了一个 3023.com 的 API 服务，托管在 百度 [ApiStore](http://apistore.baidu.com/) 上面，转换服务应该是代理的的新浪的短网址服务。

<http://apistore.baidu.com/apiworks/servicedetail/1466.html>

## 开放源代码

这次重写，我把这个小书签应用开源在了 Github 上面 ，希望能够得到大家的关注及反馈。

<https://github.com/greatghoul/dwz>

