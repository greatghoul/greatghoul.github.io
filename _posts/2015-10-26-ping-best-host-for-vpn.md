---
title: 通过 PING 选取连接最快的 VPN 服务
date: 2015-10-26 22:04 CST
cover: http://greatghoul.b0.upaiyun.com/1510/Hg_xujlDoCDtE.png
tags:
  - vpn
  - gfw
  - python
---

作为一个程序员，尤其是一个[远程工作]的程序员，翻墙的技术可以说是立身之本，作为一个常年翻墙者，
Shadowsocks 和 VPN 那都得备着，SS 是自己搭建的，只有一个服务器可以用，没有什么最快的概念，
这里我讲讲 VPN。

VPN 我使用的是[云梯]的服务，用了两年左右了，以前还写过一个[批量创建 VPN 配置][1]的文章,
不过自从入了 MBP 后，官方有 OSX 一键安装的脚本，方便多了。

没有哪个翻墙服务是一一直稳定的，云梯也是一样，虽然有多个服务器可以切换，但一个个试也比较烦，
于是有了今天这篇文章（我需要一个能找出连接相对稳定的服务器的脚本）

因为我自己并不懂 ping 的原理，所以这里用了一个[别人写好的脚本][2]修改而来，

<https://gist.github.com/greatghoul/24b093637e39f0bd3df3>

原理是对每个 ip 执行发四个包，平均咱就时间最快的就认为最稳定，你需要准备一个 `hosts.txt` 文件，
每行写一个服务器地址，和下载的脚本 `check_vpn.py` 放在同一目录：

    a1.examplevpn.com
    a2.examplevpn.com
    a3.examplevpn.com
    a4.examplevpn.com
    a5.examplevpn.com

然后在断开 VPN 的情况下以 sudo 执行以下命令

    sudo python check_vpn.py

会得到平均响应时间由低到高排列的结果列表：

    host                  lost/total  avg/min/max
    a3.examplevpn.com     0/4         108.0587/82.1869/161.1369
    a2.examplevpn.com     0/4         108.8945/84.0471/178.5910
    a4.examplevpn.com     0/4         118.3317/113.8020/124.9740
    a5.examplevpn.com     0/4         143.3793/137.8958/146.4632
    a1.examplevpn.com     0/4         164.5067/153.4820/187.5679

然后就可以选择靠前的这几个 VPN 来连接了，相对会比较流畅一些。


[远程工作]: http://yizaoyiwan.com/ "一早一晚社区"
[云梯]: http://igetvpn.com/?r=1de76f73ead0413e "云梯VPN"

[1]: http://g2w.me/2014/01/batch-create-vpn-config-files-with-python/
[2]: https://gist.github.com/pklaus/856268
