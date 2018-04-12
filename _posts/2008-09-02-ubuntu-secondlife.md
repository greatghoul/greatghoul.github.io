---
layout: post
title: Ubuntu下安装secondlife中断后无法继续安装
slug: ubuntu-secondlife
date: 2008-09-02 19:24
tags: [game, ubuntu]
---

一直听说 secondlife 非常好玩，就在 [getdeb][1] 下载了 secondlife 的[安装包][2]，安装过程中不小心关闭了，
后来重新安装时就提示

    E: The package secondlife-install needs to be reinstalled, but I can't find an archive for it.

以至于连其它的包也无法安装，Google 了很久，终于找到了解决方案。而且也是在安装 secondlife 时问题，不知道是凑巧还是什么。

方法如下 ：

    sudo gedit /var/lib/dpkg/status

找到类似如下 的信息，删除之

    Package: secondlife-install
    Status: install reinstreq half-installed
    Priority: extra
    Section: games
    Version: 1.20.15-0~getdeb1

保存后重新安装 secondlife，问题解决。

参考： <https://answers.launchpad.net/ubuntu/+question/27375>

不幸的是，当我运行游戏时，提示，您 的计算机配置可能无法流畅运行 secondlife，晕死，只好卸载了。晕死。

[1]: http://www.getdeb.net/
[2]: http://www.getdeb.net/release/3124 "secondlife-install_1.20.15-0~getdeb1_i386"
