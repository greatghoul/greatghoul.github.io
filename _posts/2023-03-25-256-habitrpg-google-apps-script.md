---
slug: 256-habitrpg-google-apps-script
date: '2023-03-25'
layout: post
title: HabitRPG 奶妈自动治疗脚本（Google Apps Script）
tags:
  - Google Apps Script
issue: 256
---

我在之前的[电鸭访谈](https://anl.gg/eleduck-interview-working-remotely-for-8-years)中，简单介绍过我日常使用的 GTD 服务 [Habitica](https://habitica.com/)，最近加入了一个新的冒险小队，这个小队人比较多，所以在打副本时，难免因为某个队员忘记做自己的每日任务，导致团队重伤，治疗不及时的话，可能会丧命，以至于损失所有金币。

我之前的职业是战士，好几次都得自己花钱嗑药，虽然团队中有奶妈，但是可能因为大家时区不同，每日结算时间也不一样，治疗没有那么及时。所以我萌生了转职为奶妈的想法。

之前构想过一个自动治疗的方案，就是在 Google Apps Script 上面托管一个脚本，然后定时执行，自动释放全员治疗法术 [Blessing](https://habitica.fandom.com/wiki/Healer#Blessing)，参考了 [Apps Script 文档](https://developers.google.com/apps-script/reference/url-fetch/url-fetch-app?hl=zh-cn)和 [Habitica API](https://habitica.com/apidoc/) 后，心理大概有了设计。于是果断转生，在重新到达10级后，转职为奶妈。

在闲暇时间，几经改进和调试，终于完善了脚本。

https://github.com/greatghoul/gs-habitica-auto-blessing 

将 main.gs 中的 `USER_ID` 和 `USER_TOKEN` 换成自己的就可以了。

```javascript
const USER_ID = '<your id>';
const USER_TOKEN = '<your token>';
```

这两个东西可以在[设置页面](https://habitica.com/user/settings/api)找到

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/f6f03cb4-3ac6-494f-b13b-47162b34aacc)

在 Apps Script 里面安装后，可以[用 Triggers 设置每半个小时执行一次](https://www.youtube.com/watch?v=MiWfaCNRzsA)。

效果图

![](https://github.com/greatghoul/greatghoul.github.io/assets/208966/65b900b4-370d-4303-8a0d-76e777e00345)

Apps Script 里面也有有运行日志，可以参考。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/404711ea-15a5-49ef-8cce-dfffbc2fb0c2)
