---
slug: 57-python-threading-ping
date: '2011-02-09'
layout: post
title: python并发的应用：ping一个网段，并列出结果
tags:
  - Python
issue: 57
---

年前大多数外地的同事都提前请假回家，我家是西安的，所以一直上班到2月1号，其实后来那几天人已经很少了。闲得实在无聊，
于是就想看看网段中有多少机子开着机，但是手头又没有现成的 LAN 工具。于是打算用 python 玩一下。

我工作在 windows 系统下，不知道 python 中有没有现在的 ping 模块，不过也懒得找，打算直接 `os.popen()` 执行 `ping` 命令，
根据返回结果来得知是否 ping 得通。

通常 cmd 下 ping 成功 的结果如下：

    Pinging 127.0.0.1 with 32 bytes of data:

    Reply from 127.0.0.1: bytes=32 time&lt;1ms TTL=128
    Reply from 127.0.0.1: bytes=32 time&lt;1ms TTL=128
    Reply from 127.0.0.1: bytes=32 time&lt;1ms TTL=128
    Reply from 127.0.0.1: bytes=32 time&lt;1ms TTL=128

    Ping statistics for 127.0.0.1:
    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
    Approximate round trip times in milli-seconds:
    Minimum = 0ms, Maximum = 0ms, Average = 0ms

ping 命令默认会发送 4 个数据包，为了保险起见，我手动指定为 4 个

    ping -n 4 <IP_ADDRESS>

起始我是一个 IP 一个 IP 的 ping ，不过这样速度很慢，大多数时间都用在等待上面了，显然得上 [threading][1] 了。

    class Ping(threading.Thread):
        def __init__(self, ip_address):
            threading.Thread.__init__(self)
            self.ip_address = ip_address

        def run(self):
            # ping 指定的IP地址，并返回丢失的包数
            result = os.popen('ping -n 4 %s' % self.ip_address).read()
            match = RESULT_PATTERN.search(result)
            lost_count = match and int(match.group(1)) or 0

            if lost_count == 0:
                print 'ping %-15s      stabled' % self.ip_address
            elif lost_count == 4:
                print 'ping %-15s      timeout' % self.ip_address
            else:
                print 'ping %-15s      unstable' % self.ip_address

指定网段循环的 ping 了下，结果打印出来的结果一片混乱（事实上在多线程中直接在屏幕上打印信息是个很愚蠢的作法），
看来得在打印这部分上做一些处理，于是就得用上 [Lock][2]

    lock = threading.Lock()

    # ...

    lock.acquire()
    if lost_count == 0:
        print 'ping %-15s      stabled' % self.ip_address
    elif lost_count == 4:
        print 'ping %-15s      timeout' % self.ip_address
    else:
        print 'ping %-15s      unstable' % self.ip_address
    lock.release()

完整的代码：

    # coding: utf-8
    """
    ping一个网段，并列出结果
    """

    import os, re, threading

    RESULT_PATTERN = re.compile(r'Lost\s=\s(\d)', re.M)

    class Ping(threading.Thread):
        def __init__(self, ip_address):
            threading.Thread.__init__(self)
            self.ip_address = ip_address

        def run(self):
            # ping 指定的IP地址，并返回丢失的包数
            result = os.popen('ping -n 4 %s' % self.ip_address).read()
            match = RESULT_PATTERN.search(result)
            lost_count = match and int(match.group(1)) or 0

            # 加锁以防止屏幕打印混乱
            global lock
            lock.acquire()
            if lost_count == 0:
                print 'ping %-15s      stabled' % self.ip_address
            elif lost_count == 4:
                print 'ping %-15s      timeout' % self.ip_address
            else:
                print 'ping %-15s      unstable' % self.ip_address
            lock.release()

    def bulk_ping(ip_prefix, start=0, end=255):
        print 'pinging ip addresses from %s.%d to %s.%d' % (ip_prefix, start, ip_prefix, end)
        for i in range(start, end):
            ping_thread = Ping('%s.%d' % (ip_prefix, i))
            ping_thread.start()

    if __name__ == '__main__':
        global lock
        lock = threading.Lock()
        bulk_ping('10.144.114')</pre>

[1]: http://docs.python.org/library/threading.html
[2]: http://docs.python.org/library/threading.html#lock-objects
