---
slug: 254-bulk-remove-telegram-channel-members
date: '2022-10-26'
layout: post
title: 使用 Chrome DevTools 批量删除 Telegram 群组成员
tags:
  - JavaScript
  - Automation
  - Telegram
issue: 254
---

我有一个[远程工作相关的 Telegram 频道](https://t.me/remote_cn)，用于发布一些网上找到的远程工作机会和文章等资源，为了方便讨论，绑定了一个群组作为评论区。

最近一段时间，群组中有大量版聊，而且和主题并没有太大相关，有点头疼。看到 [TG Geek](https://t.me/TGgeek) 的频道的评论群组很干净，而且会使用一个自动踢人的 bot 来阻止新成员加入，基本上只是作为一个评论区使用，这正符合我的需求，于是我也在远程工作者的群组中加入了 `@auto_kickout_bot` 这个 bot，效果还不错。

然而我的群组已经有 500 多名成员了，爱好版聊的依然在版聊，本想自己做一个 bot 来批量删除所有群组普通成员，但是找了一圈，发现 [Telegram Bot API](https://core.telegram.org/bots/api) 并不支持遍历成员、消息以及删除一个已有成员。[Telegram API](https://core.telegram.org/methods) 虽然支持，但是本身鉴权略显麻烦，不想那么费事。

## 批量删除成员

因为成员数据其实也不算太大，所以我想到用 JavaScript 模拟点击来实现删除成员的方法，简单实验后，发现可行。

脚本代码如下：

```javascript
(function () {
  function findFirstMember() {
    return document.querySelector('.Management .ListItem');
  }

  function rightClickMember(member) {
    try {
      const memberInfo = member.querySelector('.ChatInfo .info')
      memberInfo.dispatchEvent(
          new MouseEvent('contextmenu', {
              bubbles: true,
              cancelable: false,
              view: window,
              button: 2,
              buttons: 0,
              clientX: memberInfo.getBoundingClientRect().x,
              clientY: memberInfo.getBoundingClientRect().y,
          })
      );
    } catch (e) {}
  }

  function clickRemove(member) {
    try {
      const removeBtn = member.querySelector('.icon-stop').parentNode;
      removeBtn.dispatchEvent(
          new MouseEvent('click', {
              bubbles: true,
              cancelable: false,
              view: window,
              button: 2,
              buttons: 0,
              clientX: removeBtn.getBoundingClientRect().x,
              clientY: removeBtn.getBoundingClientRect().y,
          })
      );
    } catch (e) {}
  }

  function confirmRemove() {
    try {
      const removeBtn = document.querySelector('.confirm-dialog-button');
      removeBtn.dispatchEvent(
          new MouseEvent('click', {
              bubbles: true,
              cancelable: false,
              view: window,
              button: 2,
              buttons: 0,
              clientX: removeBtn.getBoundingClientRect().x,
              clientY: removeBtn.getBoundingClientRect().y,
          })
      );
    } catch (e) {}
  }

  function isReserved(member) {
    const userStatus = member.querySelector('.user-status');
    const fullName = member.querySelector('.fullName');

    // admin
    if (fullName.textContent.indexOf('greatghoul') !== -1) {
      return true;

    // bot user
    } else if (userStatus && userStatus.textContent.indexOf('bot') !== -1) {
      return true;

    } else {
      return false;
    }
  }

  function performRemove() {
    const member = findFirstMember();
    // 如果是管理员，则只是简单的删除元素，忽略遍历
    if (isReserved(member)) {
      member.remove();
      setTimeout(performRemove, 1000);
    // 如果是普通成员，则模拟以后流程
    // 鼠标右键 → 点击 Remove From Group → 点击对话框的 Remove 按钮
    } else {
      rightClickMember(member);
      setTimeout(() => {
        clickRemove(member);
        setTimeout(() => {
          confirmRemove();
          setTimeout(performRemove, 2000);
        }, 2000);
      }, 2000); 
    }
  }

  performRemove();
})();
```

要使用这个脚本，需要确保在网页版 Telegram 中打开群组的成员管理页面。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/4c0ad9f9-4ac5-4777-b77c-ebcab0ff66b9)

然后打开 [Chrome 开发人员工具](Open Chrome DevTools - Chrome Developers - https://developer.chrome.com/docs/devtools/open/)，将上面的代码粘贴进去（管理员昵称可以根据需要修改），然后提交运行即可。

按下来要做的就是耐心的等待了。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/105aa7a0-6a18-4dbf-80b7-ebc120ddd19a)
https://youtu.be/vlVNNN6DG-w

## 批量 Unblock 成员

经频道用户反馈，发现即使是从频道进去评论群组，也无法发言。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/ed319db9-376e-4369-a9d9-8a7904855601)

我检查后发现是上面删除脚本的副作用，被 admin 移除的成员相当于被拉黑，不能再发言，需要再写一个脚本批量 unblock.

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/b4107c1a-5005-40a2-b0f8-d25ab8e28fdc)

同样的运行方式，只是页面有所不同，脚本如下。

```javascript
(function () {

  function findFirstMember() {
    return document.querySelector('.Management .ListItem');
  }

  function rightClickMember(member) {
    try {
      const memberInfo = member.querySelector('.ChatInfo .info')
      memberInfo.dispatchEvent(
          new MouseEvent('contextmenu', {
              bubbles: true,
              cancelable: false,
              view: window,
              button: 2,
              buttons: 0,
              clientX: memberInfo.getBoundingClientRect().x,
              clientY: memberInfo.getBoundingClientRect().y,
          })
      );
    } catch (e) {}
  }

  function clickUnblock(member) {
    try {
      const removeBtn = member.querySelector('.icon-delete').parentNode;
      removeBtn.dispatchEvent(
          new MouseEvent('click', {
              bubbles: true,
              cancelable: false,
              view: window,
              button: 2,
              buttons: 0,
              clientX: removeBtn.getBoundingClientRect().x,
              clientY: removeBtn.getBoundingClientRect().y,
          })
      );
    } catch (e) {}
  }

  function performUnblock() {
    const member = findFirstMember();
    rightClickMember(member);
    setTimeout(() => {
      clickUnblock(member);
      setTimeout(performUnblock, 1000);
    }, 1000);
  }

  performUnblock();
})();
```


