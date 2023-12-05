---
slug: 161-chrome-secure-shell-colors
date: '2013-07-13'
layout: post
title: Chrome Secure Shell 配色
tags:
  - Chrome Extension
issue: 161
---

最近经常在 Windows 下连接 ssh，不太想下载 putty 等客户端，于是就开始使用 Chrome 的扩展 [Secure Shell]，
发现这完全就是个神器呀。

       .--~~~~~~~~~~~~~------.
      /--===============------\
      | |```````````````|     |
      | |               |     |
      | |      >_<      |     |
      | |               |     |
      | |_______________|     |
      |                   ::::|
      '======================='
      //-"-"-"-"-"-"-"-"-"-"-\\
     //_"_"_"_"_"_"_"_"_"_"_"_\\
     [-------------------------]
     \_________________________/

它支持一些很爽的特性：

 - 跨平台（这个很方便）
 - 自定义配置 Profile
 - 配置自动同步(这个应该和你的 Google 帐户是绑定的，不过不清楚是什么机制）
 - 鼠标选中自动复制内容
 - 鼠标右键粘贴剪贴板内容
 - `Ctrl+Shift+C` 和 `Ctrl+Shift+V` 复制和粘贴

使用 Secure Shell 来管理你的 ssh 连接非常方便，但是 Secure Shell 默认的配色不太好看，所以在网上找到了
一个不错的 [solarized] 配色（我的 vim 也是这人配色）

![screenshot-dark](https://github.com/greatghoul/greatghoul.github.io/assets/208966/252b4713-bb69-466a-8fc6-ed905ed34291)

![screenshot-light](https://github.com/greatghoul/greatghoul.github.io/assets/208966/43cb3fab-bba1-4f2f-af9b-df3667aa5454)

不过 Secure Shell 配置页面中精确设置颜色比较困难，不过得益于[这篇文章][1]提到的方法，能够通过 js 方便的
执行配置了。

`solarized-dark.js`

    term_.prefs_.set('color-palette-overrides', {"0":"#073642","1":"#dc322f","2":"#E4E465","3":"#b58900","4":"#268bd2","5":"#d33682","6":"#2aa198","7":"#eee8d5","8":"#002b36","9":"#cb4b16","10":"#586e75","11":"#657b83","12":"#839496","13":"#6c71c4","14":"#93a1a1","15":"#fdf6e3"});
    term_.prefs_.set('background-color', '#002b36');
    term_.prefs_.set('cursor-color', '#eee8d5');
    term_.prefs_.set('foreground-color', '#eee8d5');

`solarized-light.js`

    term_.prefs_.set('color-palette-overrides', {"0":"#073642","1":"#dc322f","2":"#859900","3":"#b58900","4":"#268bd2","5":"#d33682","6":"#2aa198","7":"#eee8d5","8":"#002b36","9":"#cb4b16","10":"#586e75","11":"#657b83","12":"#839496","13":"#6c71c4","14":"#93a1a1","15":"#fdf6e3"});
    term_.prefs_.set('background-color', '#eee8d5');
    term_.prefs_.set('cursor-color', '#002b36');
    term_.prefs_.set('foreground-color', '#002b36');

gist: <https://gist.github.com/greatghoul/5984813>

使用方法很简单，在 Secure Shell 图标上右键点击 Options，打开设置页面后，通过 `Ctrl+Shift+J` 打开开发人员
工具，然后在 Console 中执行上面 gist 中的配色中的代码即可。

执行后刷新页面即可看到效果了。

当然，你自己也可以定制更多的配色的。

[Secure Shell]:  https://chrome.google.com/webstore/detail/secure-shell/pnhechapfaindjhompbnflcldabbghjo?utm_source=chrome-ntp-launcher
[solarized]: https://github.com/yuex/chrome-secure-shell-solarized
[1]: http://www.puritys.me/docs-blog/article-151

