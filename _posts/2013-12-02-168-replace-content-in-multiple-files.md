---
slug: 168-replace-content-in-multiple-files
date: '2013-12-02'
layout: post
title: 多文件内容批量替换
tags:
  - Linux
issue: 168
---

刚休完婚假回来，准备尽快投入工作，但毕竟半个多月没有摸代码了，所以准备整理出一些公司项目中小的问题
加以改进，慢慢进入状态。

公司开发的后台系统中导航路径使用 &raquo; 作为路径分隔符，但是因为是多人协作开发，难免有不一致的地方，
有的人在 &raquo; 两端加了空格，而有的却没有，导出不同页面中导航路径的风格不一致。我决定拿这个问题下手。

一开始是一个页面一个页面改，改了三四个页面后，觉得我真不配做一个优秀的程序员，这种重复工作竟然还笨到
手工撸代码，简直弱爆了。于是赶紧放弃，几十个页面，一个个检查一次我这一早上别干别的事儿了。

作为一个程序员，当然要用程序的方式解决了，于是自然想到了 `sed` 和 `grep`

我的目的是在所有的 &raquo; 两侧都加入一个空格的间隔，以作为标签的路径分隔，效果类似这样

> 当前位置：车辆管理 &raquo; 车辆加油记录

    sed -i "s/\s*&raquo;\s*/ \&raquo; /g" `grep '&raquo;' app/views/ -rl`
                             ^

这样会将 `app/views/` 目录下所有文件中的 `&raquo;` 两侧都加上空格，保持路径之间有一定留白，比较美观。

注意标记位置里面的 `\` 是为了转义 `&`，不然替换结果会不正确。

上面的方法，一行代码就解决了所有页面的修改，简单又方便，但其实算不上一个好方法，更加推荐的方法是，将
这个分隔符统一成配置，这样只需要修改一处，所有地方都修改了，不需要做文件指替换这样危险的事。

比较这样 `t('helpers.seperator')` 这样在 i18n 文件中指定分隔符的形式就可以了。
