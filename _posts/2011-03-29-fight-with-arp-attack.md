---
layout: post
title: 遭遇arp攻击
date: 2011-03-29 22:47
slug: fight-with-arp-attack
tags: [arp, linux, ubuntu]
---

晚上加完班回到住处，发现上不了网，但室友的网却很快，查看后发现 ip 为 104 的家伙在对我进行 arp 攻击。

系统 ( ubuntu ) 上没有安装防止 arp 攻击的软件，好辛苦。

尝试安装 [arpon][1] 

    $ sudo apt-get install arpon

失败，手动下载也无果，只好求助室友帮忙下载后传给我（[下载地址][2]）

安装后运行命令

    $ sudo arpon -d

进行自动管理。

有网的感觉真好~~~

arpon 项目的主页 <http://arpon.sourceforge.net/>

[1]: http://arpon.sourceforge.net/
[2]: http://us.archive.ubuntu.com/ubuntu/pool/universe/a/arpon/arpon_2.0-2_i386.deb
