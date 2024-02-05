---
slug: 257-navigate-telegram-web-messages-using-jk
date: '2024-02-05'
layout: post
title: Telegram Web 使用快捷键 j & k 浏览频道中的消息
tags:
  - UserScript
  - JavaScript
  - Telegram
issue: 257
---

日常使用 [Telegram Web](https://web.telegram.org/) 比较多一些，浏览频道中比较长的消息时，滚动鼠标总觉得很累，心血来潮写了个小的油猴脚本，可以使用 `j` 和 `k` 来切花下一条和上一条消息。

![1](https://github.com/greatghoul/greatghoul.github.io/assets/208966/677c4e81-75ad-48cd-b2c1-95a9a7b885f0)

确保你有安装类似 [Tamermonkey ](https://chrome.google.com/webstore/detail/tampermonkey/dhdgffkkebhmkfjojejmpbldmpobfkfo) 的浏览器扩展。

> [点击这里安装 User Script](https://gist.github.com/greatghoul/e32a5f253ddf59f15127dcb8df4e9aed/raw/42fb3653b3fdd7cdada7fb9ea9984744d635c65f/tgmsg-nav.user.js)

```js
// ==UserScript==
// @name         Telegram Channel Message Navigation
// @namespace    https://anl.gg/
// @version      0.1
// @description  Navigate next/prev message by pressing j & k
// @author       greatghoul
// @match        https://web.telegram.org/*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=telegram.org
// ==/UserScript==

(function() {
  'use strict';

  var message = null;

  document.addEventListener("keydown", function(event) {
    if (!hasInputText()) {
      if (event.code == "KeyJ") {
        activeNextMessage(1);
      } else if (event.code == "KeyK") {
        activeNextMessage(-1);
      }
    }
  });

  function hasInputText() {
    return document.querySelector("#message-input-text");
  }

  function activeNextMessage(offset) {
    if (message) {
      message = findNextMessage(message, offset);
    } else {
      message = findFirstVisibleMessage();
    }

    message && activeMessage(message);
  }

  function activeMessage(message) {
    message.scrollIntoView({behavior: "smooth"});
  }

  function findNextMessage(currentMessage, offset) {
    const messages = document.querySelectorAll('.message-list-item');
    const currentIndex = Array.from(messages).indexOf(currentMessage);
    if (currentIndex == -1) {
      message = findFirstVisibleMessage();
      return findNextMessage(message, offset);
    }

    const nextIndex = currentIndex + offset;
    if (nextIndex >= 0 && nextIndex < messages.length) {
      return messages[nextIndex];;
    } else {
      return null;
    }
  }

  function findFirstVisibleMessage() {
    var messageList = document.querySelector(".MessageList");
    var messages = document.querySelectorAll(".message-list-item");

    for (var i = 0; i < messages.length; i++) {
      var message = messages[i];
      var rect = message.getBoundingClientRect();
      if (rect.top >= 0 && rect.top < messageList.clientHeight) {
        return message;
      }
    }
    return null;
  }

})();
```

https://gist.github.com/greatghoul/e32a5f253ddf59f15127dcb8df4e9aed
