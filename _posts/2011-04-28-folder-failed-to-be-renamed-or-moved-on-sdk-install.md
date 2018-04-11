---
layout: post
title: folder failed to be renamed or moved on Android SDK install
slug: folder-failed-to-be-renamed-or-moved-on-sdk-install
date: 2011-04-28 00:18
tags: [android, android-sdk]
---

在 winxp sp3 下面安装 android sdk 时，遇到了很缠人的bug:

![android sdk 安装失败](http://pic.yupoo.com/greatghoul_v/B1CJSqfo/d1Kl.png)

尝试关闭了杀毒软件，未果，于是找到了 这个 [issue][1] 并在里面找到了一个比较靠谱的 [解决方案][2]。

> 1. Run the SDK setup
> 2. Wait for the error message
> 3. Disable anti virus
> 4. Install this unlocker program <http://download.cnet.com/Unlocker/3000-2248_4-10493998.html>
> 5. Run the unlocker program
> 6. select the tools directory to unlock it
> 7. select yes in the installer.

解锁后再重新进行更新，就可以正常更新了。

[1]:  http://code.google.com/p/android/issues/detail?id=4410 "Issue 4410: folder failed to be renamed or moved on SDK install"
[2]: http://code.google.com/p/android/issues/detail?id=4410#c41
