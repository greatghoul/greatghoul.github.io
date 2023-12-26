---
slug: 216-fake-data-chrome-extension
date: '2019-04-25'
layout: post
title: FakeData - 测试网页表单的好帮手
tags:
  - Chrome Extension
issue: 216
---

荐哥是一个程序员，具体点说，是一个写 Web 的程序员，这样难免要和一些表单打交道，写了一个表单，要测试时，因为有表单验证的关系，需要输入各种各样的资料。

当然了，大部分都是 asdf asdf 这样的无意义字符，尽管 asdf 很好输入，无脑滚键盘就可以达成，但是这样还是蛮累的，而且经常输入的数据还不正确。比如表单上面需要一个邮件地址， asdf 后你还要构思一个域名，这不是浪费时间嘛！

鉴于写自动化测试用到的 faker 工具，我找到了 Chrome 浏览器上一个快速输入测试数据的扩展 Fake Data。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/e85ed986-1609-4f83-9887-1b947eb76b4d)

这个扩展启用后，在输入框中按住 Cmd 或者 Ctrl 键双击鼠标，它就能根据表单输入框的 name 和 class 等属性，自动猜测内容的类型并填充，比如邮箱，电话，电话号码等等，如果它猜错了，你还可以在输入框上右键选择你期望的类型，选择后，它会对这个输入框记住你的偏好，下次自动填充。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/b752e908-79c5-4e8c-96fb-b3c076819057)

如果内置的类型不能满足你，你还可以在扩展设置里面写自己的生成器（你得会写几句 JS）

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/eef7a14e-8b84-414f-8290-dbc74bf13ceb)

除了逐个填充表单外，这个扩展扩展也支持一键填充整个表单，十分方便。

下载地址

<https://chrome.google.com/webstore/detail/fake-data-a-form-filler-y/gchcfdihakkhjgfmokemfeembfokkajj/>
