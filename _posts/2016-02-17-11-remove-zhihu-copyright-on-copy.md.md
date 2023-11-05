---
slug: 11-remove-zhihu-copyright-on-copy.md
date: '2016-02-17'
layout: post
title: 移除复制知乎回答内容时的版权说明
tags:
  - UserScript
issue: 11
---

无聊的时候，经常会在知乎看一些精彩的回答，如果回答太长，就懒得自己看，一般会选中文字然后 `Option+ESC` 用 OSX 自带的文本转语音工具来进行朗读，但自从知乎启用了版权说明后，复制时会在复制的文本前添加一些版权信息，OSX 的朗读功能应该是调用的复制功能，所以每次都要把版权信息读很久，极不方便。

说实话这功能真的防君子不防小人，我不晓得自己是君子还是小人，但这个功能真的妨碍到我了，所以我决定干掉它 😈

Google 一番就知道这个功能是[如何实现](https://www.zhihu.com/question/38685128)的了，利用的是 [copy 事件](http://www.w3schools.com/jsref/event_oncopy.asp)，要注销掉这个事情不太容易，但要避开它却很简单，阻止冒泡就好了。

知乎的这个事件是绑定在回答区域的，那么在回答的子元素上捕获 copy 事件，然后[阻止向上冒泡](https://api.jquery.com/event.stoppropagation/)就可以了，这里我用了 jquery，因为我比较懒。

    $('.zm-editable-content').on('copy', function(evt) {
        evt.stopPropagation();
    });

像上面这样，捕获到这个事件不作任何处理，仅阻止冒泡，就可以避开。

![说明](https://github.com/greatghoul/greatghoul.github.io/assets/208966/1f09c705-74dc-4f77-893d-7e251dc6393c)

完整的代码

    // ==UserScript==
    // @name         禁用知乎版权信息
    // @namespace    http://g2w.me/
    // @version      0.1
    // @description  彬知乎版权信息
    // @author       greatghoul
    // @match        https://www.zhihu.com/*
    // @grant        unsafeWindow
    // @require      http://cdn.bootcss.com/jquery/1.12.0/jquery.min.js
    // ==/UserScript==
    /* jshint -W097 */
    'use strict';

    $('.zm-editable-content').on('copy', function(evt) {
        evt.stopPropagation();
    });

----

在 Chrome 中，可以使用 [Tampermonkey](https://chrome.google.com/webstore/detail/tampermonkey/dhdgffkkebhmkfjojejmpbldmpobfkfo) 来管理 userscripts，我也仅仅在这个平台上测试过。
