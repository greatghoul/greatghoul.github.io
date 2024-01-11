---
slug: 239-batch-unsubscribe-youtube-channels
date: '2024-01-11'
layout: post
title: 批量取消订阅 Youtube Channels
tags:
  - JavaScript
issue: 239
---

看到 [如何批量取消你的 B 站关注和 Youtube 关注 - 白宦成](https://www.ixiqin.com/2024/01/04/how-to-cancel-your-bilibili-and-youtube-followers-in-bulk/) 这篇文章，不过没有给出自动取消订阅 Youtube Channel 的解法，我时常做这种事情 ，找到了以前写的脚本，稍微修改修改，做了一个批量取关 Youtube Channels 的脚本。

```js
(function () {
  function clickElement(element) {
    return new Promise((resolve, reject) => {
      const event = new MouseEvent("click", { bubbles: true, cancelable: true });
      element.dispatchEvent(event);
      setTimeout(() => resolve(element), 500);      
    });
  }

  async function start() {
    const channel = document.querySelector("ytd-channel-renderer");
    if (!channel) return;

    const buttonLeave = channel.querySelector("ytd-subscribe-button-renderer .yt-spec-touch-feedback-shape__fill");
    await clickElement(buttonLeave);
    const buttonConfirm = document.querySelector("tp-yt-paper-dialog #confirm-button .yt-spec-touch-feedback-shape__fill");
    await clickElement(buttonConfirm);
    channel.remove();

    setTimeout(start, 1000);
  }

  start();
})();
```

这个脚本，需要打开 [Youtube Channels](https://www.youtube.com/feed/channels) 之后，打开开发人员工具粘贴代码到控制台里面执行。如果你有很多 Channel, 那最好手工滚动到所有内容都加载后再执行。

![1](https://github.com/greatghoul/greatghoul.github.io/assets/208966/28e79cb2-539c-43b1-bc1f-68efb2733ea7)



