---
title: Tower Plus V1.1 发布
date: 2015-04-01 08:06 CST
tags: chrome-extension
cover: http://greatghoul.b0.upaiyun.com/1503/2oir_HObz30v.png
---

总喜欢给自己喜欢的应用加点自己偏好的功能，[Tower.im][1] 是我用的比较多的国内的
团队协作的工具，于是也为它写了点儿增强功能的 Chrome 扩展。

我[以前有发布过这个扩展][2]，当时的扩展主要是增强 Tower.im 的编辑器功能，
但经过这么时间以后，Tower 的编辑器已经做的非常好了，而且还[开源][3]了。
于是我去除了以前的功能，新开发了一个新的增强功能：快速导航。

## 快速导航

过去参与的团队比较多，以前的公司，自己的一些开源项目，还有一些自己感兴趣的项目。
但是，Tower.im 切换项目，需要先切换团队，这样感觉很麻烦，于是在顶部加了一个
导航菜单，一级菜单为团队，二级菜单为团队下面的项目，这样切换起来会快很多。

![预览](http://greatghoul.b0.upaiyun.com/1503/2oir_HObz30v.png)

## 开发的一些事儿

受院一峰这篇《[使用 Make 构建网站][4]》的影响，我现在也倾向于使用 Makefile 来构建应用，
相比于 gulp 和 grunt 它的功能无疑弱很多，但是你要写点什么东西，也简单很多，而且没有什么
依赖，在写 Makefile 的同时，也巩固了不少命令的用法，应该说收益不小。

可以参考我另一个扩展 TransIt 的 [Gulpfile][5]，它太复杂了，而且它的 watch and build
的机制太多糟点，起手很困难。

项目地址在这里，欢迎交流和反馈：

<https://github.com/GDG-Xian/crx-tower>

## 安装扩展

<a href="https://chrome.google.com/webstore/detail/twoerim-plus/dfhmgoomjkcdlfclkpjpmhjgpdakijke"><img src="https://camo.githubusercontent.com/334b4f665751356b1f4afb758f8ddde55b9c71b8/68747470733a2f2f7261772e6769746875622e636f6d2f476f6f676c654368726f6d652f6368726f6d652d6170702d73616d706c65732f6d61737465722f74727969746e6f77627574746f6e5f736d616c6c2e706e67" border="0" style="max-width:100%;"></a>

[1]: https://tower.im
[2]: http://g2w.dev:4567/2014/02/rlease-crx-tower-1-0/
[3]: http://simditor.tower.im/
[4]: http://www.ruanyifeng.com/blog/2015/03/build-website-with-make.html
[5]: https://github.com/GDG-Xian/crx-transit/blob/master/Gulpfile.js
