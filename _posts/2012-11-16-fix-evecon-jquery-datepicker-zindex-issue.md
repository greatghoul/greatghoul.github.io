---
title: 解决eyecon的jQueryDatepicker被浮动层遮盖的问题
slug: fix-evecon-jquery-datepicker-zindex-issue
date: 2012-11-16 18:02
tags: [datepicker, javascript, jquery]
---

eyecon 出的 [jQuery Datepicker][1] 是大家广泛使用的一个可以支持多日历时间选择控件，但是这个控件有一个 bug, 就是在
弹出层中使用该控件时，控件会被弹出层遮盖，导致无法使用。

![控件被遮盖](http://s.yunio.com/public/previews/token/V13dew/size/700/?r=a.jpg)

控件的样式中并没有设置控件的 `z-index` ，那么选择器很容易就会被高 `z-index` 的元素遮盖了。

    div.datepicker {
        position: relative;
        font-family: Arial, Helvetica, sans-serif;
        font-size: 12px;
        width: 196px;
        height: 147px;
        position: absolute;
        cursor: default;
        top: 0;
        left: 0;
        display: none;
    }

修改方法其实很简单，直接修改 `datepicker.css` 中的 `div.datepicker` 样式，增加 `z-index: 9999;` 即可解决。

或者使用 javascript 动态修改：

    $('.datepicker2').DatePicker({
        date: '2008-07-31',
        current: '2008-07-31',
        calendars: 1,
        starts: 1,
        onBeforeShow: function(picker) {
            $(picker).css('z-index', 9999);
        }
    });

使用 `onBeforeShow` 事件，在控件显示前动态更新其 `z-index` ，也可以达到与修改 css 文件相同的效果。

查看示例： <http://jsfiddle.net/greatghoul/yEkyj/>

[1]: http://www.eyecon.ro/datepicker/#about
