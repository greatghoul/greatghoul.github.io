---
slug: 33-xt800-qq-remote-assistance
date: '2010-11-14'
layout: post
title: XT800搭配QQ主动远程协助
tags:
  - Tool
  - Windows
issue: 33
---

做项目时经常需要远程维护客户的机器，如果该计算机可以通过IP在外网访问，还可以使用windows自带的远程桌面，
否则用的最多的，大概就只有QQ的远程协助最方便了。不过QQ的远程桌面必须需要对方发起，并且要确认后才能连接，
如果客户那边没有人的话，就很不方便了。

我找了许多能够主动进行连接的软件，虽然能够达到客户机上无人职守的要求，不过连接的效果却欠佳，不是很卡，
就是画面质量很差。不过既然qq连接效果这么好，那搭配起来用不就能解决问题了嘛。

最关键的是选一个做初始连接的软件，试用了 [PCAnyWhere][1] 和 [XT800][2] 这两款软件，还是感觉 XT800 效果要好一些。
国产而且速度不错，如果要求不高，甚至 XT800 已经足够做基本维护了。

XT800 和 QQ 搭配进行远程维护其实很简单。

配置被控机
----------

 1. 下载安装 [XT800个人版][2]
 2. 运行 XT800，打开**设置窗口**，在 **常规** 选项卡中，勾选 **当计算机启动后自动运行**。  
    ![配置常规选项卡](https://github.com/greatghoul/greatghoul.github.io/assets/208966/e7cf3bcf-653e-49c1-9b32-7cd6016f4bd5)
 3. 在 **安全策略** 选项卡中，勾选 **允许远程用户访问我的计算机**，勾选 **设置私密授权码**，
    设置一个固定授权码，方便主控机连接。  
    ![配置安全策略选项卡](https://github.com/greatghoul/greatghoul.github.io/assets/208966/6f2f4ab5-7eb3-4734-b2ee-f63dc79dad10)
 4. 点击 **确定** 保存设置。
 5. 下载安装 QQ，设置随 windows 启动，用帐号A登陆并记住帐号密码并设置自动登陆。

配置主控机
----------

 1. 下载安装 [XT800个人版][2]
 2. 下载安装 QQ，用 **帐号B** 登陆（**帐号A** 和 **帐号B** 需要互为好友）。
 3. 运行 XT800，填写被控机 XT800 的帐号，使用 **通过授权码控制对方计算机** 开始连接。
    （被控机帐号可以在被控机的 XT800 主界面的 **我的帐号** 处获得）
 4. 打开远程桌面后控制客户机的 QQ 向主控机 QQ 发起远程协助邀请，连接成功后关闭 XT800 即可。

也许还有其它比较好的主动远程协助的方案，欢迎大家探讨。

[1]: http://www.symantec.com/zh/cn/business/pcanywhere
[2]: http://xt800.cn/download
