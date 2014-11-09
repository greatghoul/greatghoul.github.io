---
title: pidgin 使用 ssh 代理连接Google Talk
slug: pidgin-access-gtalk-through-ssh-proxy
date: 2012-08-06 10:10
tags: [google, gtalk]
---

最近 gtalk 总是不给力，经常断掉，所以不得不使用代理，我使用自己的 VPS 通过 SSH 代理上网

如果使用 pidgin 上 gtalk，配置起来很简单，因为只有 gtalk 无法连接，所以在 pidgin 的 
**Account** 中只编辑 gtalk 就可以了。

打开目录 **Account** -> **你的gtalk** -> **Edit Account**，切换到 **Proxy** 标签页

**Proxy Type** 选择 **Socket5**，然后填上代理地址（127.0.0.1）和端口，重新连接即可。

当然，你需要先开启 ssh 代理

    ssh -D 9527 your_user_here@some_ssh_server

![pidgin](http://pic.yupoo.com/greatghoul_v/CazvmTrf/H3VHH.png)

详细可以参考这个网址：<http://cudge.org/files/Tunneling-Pidgin>
