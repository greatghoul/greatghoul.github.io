---
layout: post
title: Chrome 扩展 Tower.im Plus 发布
slug: rlease-crx-tower-1-0
date: 2014-02-24 11:22
tags: [chrome-extension, remote-working]
---

## Tower.im 富文本编辑器的缺陷

最近与朋友合作开发一些小东西，作为远程工作的体验，工具嘛，选择了国内的一个协作工具 [Tower.im]

**Tower** 的确是一个非常不错的协作工具，[彩程]一贯的好设计，任务、讨论及上传文件都很方便。

因为 Tower 不是专门为开发人员设计的，所以并没有全面的支持 Markdown 编辑，而是使用了传统的
富文本编辑器，而这个富文本编辑器的功能还相当基础，支持的功能也比较少。

![](http://pic.yupoo.com/greatghoul_v/DyQocvHL/13jHYK.png)

甚至不支持为选中的文字插入链接，虽然 Tower 为自己内部的地址做了短链接，但学是感觉不方便，
尤其是一些带有中文的链接，直接贴在正文里简直无法直视。我曾经向 Tower 反馈过这个问题，
我有向他们反馈过这个问题，但 Tower 更新的速度自然没有办法满足我的预期的，于是就自己动手了。

## 编辑器功能增强

目前实现了以下的扩展功能：

- 添加插入链接的功能
- 添加缩进和取消缩进的功能
- 为讨论的编辑器中也添加水平分豁线的功能

此扩展仅是暂时补完一些 Tower.im 目前不完善的功能，希望彩程能够慢慢的把 Tower.im 做的更好，
这个扩展的也将功能越来越少。

![讨论](http://pic.yupoo.com/greatghoul_v/DyQqQtfQ/13SIdi.png)

![文档](http://pic.yupoo.com/greatghoul_v/DyQqO9oR/olc2x.png)

## 安装与反馈：

在 Webstore 中安装：

<https://chrome.google.com/webstore/detail/twoerim-plus/dfhmgoomjkcdlfclkpjpmhjgpdakijke>

安装后打开 [Tower.im] 就可以使用了，本扩展只是一个内容增强脚本，
所以并不会在你浏览器中占据一个图标的位置。

本扩展是开源的：

<https://github.com/GDG-Xian/crx-tower>

有问题欢迎在 Issue 中提出。

[Tower.im]: https://tower.im
[彩程]: http://mycolorway.com/