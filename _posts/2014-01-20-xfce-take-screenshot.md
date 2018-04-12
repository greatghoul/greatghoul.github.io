---
layout: post
title: 在 XFCE 中使用截图工具
slug: xfce-take-screenshot
date: 2014-01-20 10:09
---

在 Ubuntu 中，我一直以来都是使用的 [Shutter] 作为主要的截图工具，它拥有超级多的截图方案，
还内置了非常棒的图片编辑工具，可以方便的添加标注。但公司的机器比较垃圾，我甚至从 GNOME 
换到了 XFCE，所以尽量去挑选一些比较精致的工具来使用，而且我对 Shutter 大部分的功能也用不上，
于是卸载了 Shutter，准备换成 XFCE 的截图工具。

![xfce-screenshoter](http://pic.yupoo.com/greatghoul_v/DtuPMKvA/E04y9.png)

在安装 XFCE 截图之前，先卸载掉 Shutter 和 GNOME 自带的截图工具

    sudo apt-get purge shutter
    sudo apt-get purge gnome-screenshot

然后顺手安装 XFCE 截图工具

    sudo apt-get install xfce4-screenshooter-plugin

XFCE 并没有默认的截图快捷键绑定，需要我们自己配置，可以使用 **Application Finder** 打开
**Keyboard** 工具，在 **Application Shortcuts** 选项卡下添加下面的配置：

    xfce4-screenshooter -f  Print
    xfce4-screenshooter -w  Ctrl + Print
    xfce4-screenshooter -r  Shift + Print

![shortcuts](http://pic.yupoo.com/greatghoul_v/DtuSqK1t/10D55b.png)

**参考资料：**

 * [take a screenshot under XFCE](http://ubuntuforums.org/showthread.php?t=1716649)
 * `xfce4-screenshooter -h`

[Shutter]: http://alternativeto.net/software/shutter/
