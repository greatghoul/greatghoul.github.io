---
title: 用 Python 批量创建云梯 VPN 连接配置
slug: batch-create-vpn-config-files-with-python
date: 2014-01-29 09:12
tags: [yunti, vpn, python, linux]
---

## 缘起

大家都知道，最近的网络不怎么和谐，速度慢不说，VPN 还总断，好在[云梯][1] 提供了挺多的服务器可以切换，
但云梯的[服务器又挺多][2]，Linux 的 Network Manager 又不支持批量添加配置，甚至配置文件都不能复制新建，
每个服务器的配置都得手动加，非常麻烦。

当然，也可以每次切换时打开配置，光改地址，但是这也非常不方便。

作为一个合格的开发人员，当然会想到用程序批量生成配置，我选择使用 Python。

## 寻找配置文件的位置

要批量创建配置，首先得知道配置文件在哪里，比如自己的云梯 VPN 地址中包含 `example` 字样，这样找起来就方便了。

    grep 'example'  ~/.config -r
    grep 'example'  /etc/ -r

于是轻松的定位到了配置文件的位置

    grep: /etc/NetworkManager/system-connections/yunti.pptp.a: Permission denied
    grep: /etc/NetworkManager/system-connections/yunti.pptp.b: Permission denied
    grep: /etc/NetworkManager/system-connections/yunti.pptp.c: Permission denied

## 了解配置文件结构

拿一个配置文件出来看看：

    [connection]
    id=yunti.pptp.tw1
    uuid=063db9b5-5915-4f3e-8bb4-2fe58abf5be5
    type=vpn
    permissions=user:greatghoul:;
    autoconnect=false

    [vpn]
    service-type=org.freedesktop.NetworkManager.pptp
    gateway=tw1.example.com
    require-mppe=yes
    user=greatghoul
    refuse-chap=yes
    refuse-eap=yes
    password-flags=1
    refuse-pap=yes

    [ipv4]
    method=auto
    dns=8.8.8.8;8.8.4.4;
    ignore-auto-dns=true

显然，有这么几个部分需要动态生成的

 * `connection.id` 这个需要是唯一的
 * `connection.uuid` 就是 [uuid] 生成一个就好了
 * `connection.permissions` 要添加上你的用户名嘛
 * `vpn.gateway` VPN 服务器的地址
 * `vpn.user` VPN 服务的帐户名
 * `ipv4.dns` 按你喜好配置就好

既然了解了，就开工吧

## 准备配置信息及模板

首先，让我们准备好材料：

    VPN_SERVERS = [
        { 'id': 'yunti.pptp.a',  'gateway': 'a.example.com' },
        { 'id': 'yunti.pptp.b',  'gateway': 'b.example.com' },
        { 'id': 'yunti.pptp.c',  'gateway': 'c.example.com' },
    ]

配置中 `uuid` 需要动态生成了

    >>> import uuid
    >>> str(uuid.uuid1())
    '0621ba62-888a-11e3-805c-44334c786649'

至于 `connection.permissions`、`vpn.user` 和 `ipv4.dns` 直接写在配置模板中即可。

`tpl.cfg`

    [connection]
    id=%(id)s
    uuid=%(uuid)s
    type=vpn
    permissions=user:greatghoul:;
    autoconnect=false

    [vpn]
    service-type=org.freedesktop.NetworkManager.pptp
    gateway=%(gateway)s
    require-mppe=yes
    user=greatghoul
    refuse-chap=yes
    refuse-eap=yes
    password-flags=1
    refuse-pap=yes

    [ipv4]
    method=auto
    dns=8.8.8.8;8.8.4.4;
    ignore-auto-dns=true

## 生成 VPN 连接配置文件

剩下的事，就只有遍历 VPN 服务器信息，生成模板了

    def add_connection(tpl, conn_info):
        filename = os.path.join(CFG_DIR, conn_info['id'])
        print '  Creating file:', filename 
        out = open(filename, 'w')
        out.write(tpl % conn_info)
        out.close()
        os.chmod(filename, 0600)

    def create_all():
        tpl = open(os.path.join(CURRENT_DIR, 'tpl.cfg'), 'r').read()

        print 'Creating yunti connection files under', CFG_DIR
        for conn_info in VPN_SERVERS:
            conn_info.update(uuid=str(uuid.uuid1()))
            add_connection(tpl, conn_info)

我测试过，虽然 VPN 配置文件的文件名怎么写都行，但是如果在 NetworkManager 
中修改了该连接的信息，NetworkManager 会自动将该配置文件重命为 **Connection Name**
（也就是配置文件中 `id`），所以在创建文件时，还是保持文件名与 `id` 一致才好。

还有一个注意点是，连接配置文件必须属于 `root:root` 并且权限设置为 `600`，
因为我们需要通过 `sudo` 执行脚本，所以这里只需要控制 `chmod` 就行了。

    os.chmod(filename, 0600)

完整的脚本

<https://gist.github.com/greatghoul/9066705>

## 享受成果

修改 `tpl.cfg` 中相关的用户名为自己的，然后执行下面的命令。

    $ sudo python create_yunti_config.py 
    Cleaning up yunti connection files...
      Removing file: /etc/NetworkManager/system-connections/yunti.pptp.a
      Removing file: /etc/NetworkManager/system-connections/yunti.pptp.b
      Removing file: /etc/NetworkManager/system-connections/yunti.pptp.c
    Creating yunti connection files under /etc/NetworkManager/system-connections
      Creating file: /etc/NetworkManager/system-connections/yunti.pptp.a
      Creating file: /etc/NetworkManager/system-connections/yunti.pptp.b
      Creating file: /etc/NetworkManager/system-connections/yunti.pptp.c

开始使用云梯吧 :)

![连接](http://pic.yupoo.com/greatghoul_v/DxWDPVyu/Ve1PL.png)

**PS:** 第一次点击 VPN 连接会要求输入密码。

## 参考资料

 * [云梯帮助中心](https://www.yunti.me/admin/documents)
 * [Python 2.7 Library uuid](http://docs.python.org/2.7/library/uuid.html)
 * [Reference: Configuring a NetworkManager Wireless Connection without Graphics](http://newton.cx/~peter/2011/05/configuring-a-networkmanager-wireless-connection-without-graphics/)

[1]: https://www.yunti.me/
[2]: https://www.yunti.me/admin/servers
[uuid]: http://baike.baidu.com/view/1052579.htm
