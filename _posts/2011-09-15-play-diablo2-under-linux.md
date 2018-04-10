---
title: linux下玩Diablo2的环境设置
slug: play-diablo2-under-linux
date: 2011-09-15 23:22
tags: [game, diablo2, linux, wine]
---

一直对 diablo2 这款游戏情有独钟，即使在 linux 平台上，也不愿将它舍弃，本文介绍 linux 下玩暗黑破坏神2（战网）的配置方法

**Requirements:**

 1. wine <http://www.winehq.org/>
 2. winegame <http://code.google.com/p/winegame/>
 3. diablo2 (带 D2Loader 的版本)
 4. d2hackmap（没有它你还不如去玩单机）
 5. 战网注册表 （推荐 <http://www.impk.net>）

wine 和 winegame 的安装就忽略了，这里直接到运行暗黑配置。

**1. 导入注册表：**

    sudo wine regedit impk.reg

**2. 启动暗黑（自动挂在d2hackmap）**

编写 sh 文件如下：

    echo 'launching diablo2 with map hacked...'
    cd /path/to/diablo2
    sudo wine D2Loader.exe -pdir M

其中 `cd /path/to/diablo2` 这一步很关键，如果不 `cd` 到 `diablo2` 目录，很可能 d2hackmap 挂载不上。

然后，就玩游戏吧！

![linux下登录暗黑战网](http://pic.yupoo.com/greatghoul_v/Bn4ag51Y/medium.jpg)
