---
slug: 7-play-diablo2-on-linux
date: '2011-09-16'
layout: post
title: Linux 下玩 Diablo 2 的环境设置
tags:
  - Linux
  - Game
issue: 7
---

一直对 diablo2 这款游戏情有独钟，即使在 linux 平台上，也不愿将它舍弃，本文介绍 linux 下玩暗黑破坏神2（战网）的配置方法

Requirements:

1.  wine <http://www.winehq.org/>
2.  winegame <http://code.google.com/p/winegame/>
3.  diablo2 (带 D2Loader 的版本)
4.  d2hackmap（没有它你还不如去玩单机）
5.  战网注册表 （推荐 [http://www.impk.net](http://www.impk.net/)）

wine 和 winegame 的安装就忽略了，这里直接到运行暗黑配置。

1\. 导入注册表：

COPY

```
sudo wine regedit impk.reg

```

2\. 启动暗黑（自动挂在d2hackmap）

编写 sh 文件如下：

COPY

```
echo 'launching diablo2 with map hacked...'
cd /path/to/diablo2
sudo wine D2Loader.exe -pdir M

```

其中 `cd /path/to/diablo2` 这一步很关键，如果不 `cd` 到 `diablo2` 目录，很可能 d2hackmap 挂载不上。

然后，就玩游戏吧！

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/5b10904f-55b8-4085-a852-a714fd4ecb35)

