---
slug: 121-restore-mysql-sock
date: '2012-05-16'
layout: post
title: 找回 /tmp/mysql.sock
tags:
  - Database
issue: 121
---

在清理服务器文件时，误删除了 `/tmp/mysql.sock` 结果导致 php无法连接 mysql

    Can't connect to local MySQL server through socket '/tmp/mysql.sock' (2)

解决方法很简单，重启 mysql 即可

    $ /etc/rc.d/init.d/mysqld stop
    $ /etc/rc.d/init.d/mysqld start
