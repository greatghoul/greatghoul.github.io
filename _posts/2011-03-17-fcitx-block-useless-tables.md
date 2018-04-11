---
layout: post
title: 屏蔽fcitx多余的码表
slug: fcitx-block-useless-tables
date: 2011-03-17 22:45
tags: [fcitx, linux]
---

众所周知 [fcitx][1] 是 linux 下一款相当棒的五笔输入法，带的码表很多，不过这也导致切换输入法时相当麻烦，要在二笔、
自然码、区位等码表过一圈是相当痛苦的，而这些码表我们平时根本就用不上，不如屏蔽掉省心。

fcitx 没有提供图表化配置程序， 不过对于打开编辑器就能做的事儿，安装一个图形配置程序实在是有些浪费。

我的 fcitx 版本是 `3.6.3`，配置文件默认是在 `/usr/share/fcitx/data`

编辑 `tables.conf` ，将用不上的码表注释掉，只保留 **五笔拼音、智能拼音、五笔字型** 即可。

fcitx 的托盘图标实在难看，也顺便关闭掉，编辑 `config` 文件

    [程序]
    ...
    ...
    使用托盘图标=0
    ...

保存后重启 fcitx

    $ killall fcitx
    $ fcitx &

享受清爽的 fcitx 吧。

[1]: http://www.fcitx.org/main/
