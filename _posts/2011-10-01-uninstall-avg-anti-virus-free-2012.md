---
layout: post
title: AVG杀毒2012无法卸载的解决方法
slug: uninstall-avg-anti-virus-free-2012
date: 2011-10-01 13:08
tags: [anti-virus, windows]
---

![AVG Antivirus Free 2012](http://pic.yupoo.com/greatghoul_v/BpqYYrqI/wodku.jpg "AVG Antivirus Free 2012")

由于之前 wow 账号被盗（事实上由于自己比较穷，也没有什么好偷的），在我哥哥的PC上更换了杀毒软件，安装了 
[AVG杀毒2012免费版][1]，但是这款杀软广告所占的空间实在太大，还是换回[金山毒霸][2]比较好，话说现在的免
杀软真是越来越多了呀。

当我试图卸载 AVG 时，问题出现了，卸载不成功，返回如下图的错误，**无法删除服务“AVGIDSAgent”**，重试了
多次都无济无事，包括在安全模式下面，本来以为是安装程序不完整，重新安装或者修复后依然是老样子。

![卸载AVG FREE 2012 (1)](http://pic.yupoo.com/greatghoul_v/BpqSb7F5/U3kil.png)

网上搜了下，那些什么用优化大量强力卸载的方法纯粹都是扯蛋，还是自己动手比较靠谱，既然知道是服务无法删除，
就把服务禁用掉吧，然后再试，于是禁用了 AVG 相关的两个服务：AVGIDSAgent 和 AVG WatchDog。

![卸载AVG FREE 2012 (2)](http://pic.yupoo.com/greatghoul_v/BpqSbtun/iAPW4.png)

重试后再次尝试卸载，很顺利就卸载完成了（AVG卸载程序的进度条就是个渣，根本提示不了进度，一直是保持在0%
位置，不用去管它）。

![卸载AVG FREE 2012 (3)](http://pic.yupoo.com/greatghoul_v/BpqSbvl9/NPssA.png)

[1]: http://www.avg.com/cn-zh/china-avg-antivirus-free "AVG杀毒2012免费版"
[2]: http://www.ijinshan.com/duba/index.shtml "金山毒霸"
