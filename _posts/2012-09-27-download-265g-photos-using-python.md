---
title: python批量下载265g美图
slug: download-265g-photos-using-python
date: 2012-09-27 22:50
tags: [python, crawler]
---

看到同事看某游戏网站的[游戏MM宣传][1]，尺度很大，不过现在的这些图集的帖子，一般都是多多分页来拉流量，
一页就只能看一两张图，很是麻烦，于是打算使用 python 抓取 <http://bg.265g.com/yxmn/> 中的美图。

对于图片抓取，其实过程很简单：

 1. 抓取第一页，获取标题及当页图片
 2. 获取下一页地址，下载该页源码并获取图片
 3. 重复步骤2直至最后一页

因为是单文件脚本，所以不打算非 python 标准库，所以只能使用文件分析利器 -- [正则表达式][2]

代码：
------

<script src="https://gist.github.com/3789320.js?file=265g_pics.py"></script>

<https://gist.github.com/3789320>

用法：
-------

    $ python 265g_pics.py http://bg.265g.com/1209/114289.html

注意：
--------

此段仅在 ubuntu 下测试过，如果没有安装 [nautilus][3]，将如下代码注释即可。

    os.system('nautilus "%s"' % dirname.encode('utf-8'))

[1]: http://bg.265g.com/1209/114289.html
[2]: http://deerchao.net/tutorials/regex/regex.htm
[3]: http://projects.gnome.org/nautilus/
