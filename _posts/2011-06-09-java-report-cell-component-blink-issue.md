---
layout: post
title: 设置华表Cell插件外观时的“闪烁”问题
slug: java-report-cell-component-blink-issue
date: 2011-06-09 13:39
tags: [java, report]
---

使用[华表Cell][1]插件时，经常要对插件的外观进行设置，比如说隐藏滚动条和页签什么的，这样就有一个问题了。

在设置生效以前，插件的外观是默认的，设置使外观发生变化（一般是在文档加载完成时），插件会“闪”一下。

解决这个问题有个比较简单的方法，就是初始时将插件设为隐藏

    <OBJECT id="Cell" classid="clsid:3F166327-8030-4881-8BD2-EA25350E574A"
        style="HEIGHT: 100%; WIDTH: 100%; DISPLAY: NONE"></OBJECT>

等设置完毕后，用js让它显示就行了。

    // ......
    // ......
    Cell.ShowSideLabel(0, 0);
    // 单元格A1获取焦点
    Cell.MoveToCell(1, 1);
    // 禁止修改数据
    Cell.ProtectSheet(0, '');
    // 设置完后再调用显示
    Cell.style.display = 'block';

[1]: http://www.cellsoft.cc/
