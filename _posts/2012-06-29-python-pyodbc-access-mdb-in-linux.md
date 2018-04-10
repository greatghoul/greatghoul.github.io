---
title: 在linux中通过python访问mdb数据库
slug: python-pyodbc-access-mdb-in-linux
date: 2012-06-29 09:25
tags: [database, python]
---

在 linux 系统中连接 mdb 数据库，直接连接的话，mdb 默认的驱动无法识别非 windows 的路径，
所以不能使用常规的连接方式

    DRIVER={Microsoft Access Driver (*.mdb)};DBQ=c:\\dir\\file.mdb

安装
-------

这里我们需要借助一些库来实现第三方的驱动

我们需要安装这些包：`mdbtools`, `unixODBC`, `libmdbodbc`

如果是支持 deb 的系统中，如果不能找到 `libmdbodbc` ，将以下路径加入到软件源列表中

    deb http://ftp.de.debian.org/debian squeeze main

更新源后即可可以安装 `libmdbodbc` 了

配置
-------

安装了需要的包后，需要做一些配置，才能支持 `libmdbodbc` 的驱动

`/etc/odbcinst.ini`

    [MDBToolsODBC]
    Description = MDB Tools ODBC
    Driver = /usr/lib/libmdbodbc.so.0
    Setup =
    FileUsage =
    CPTimeout =
    CPReuse =

`/etc/odbc.ini` 或者 `~/.odbc.ini`

    [test]
    Description = Microsoft Access Try DB
    Driver = MDBToolsODBC
    Database = /path/to/mdb/file/test.mdb
    Servername = localhost
    Username =
    Password =
    port = 5432

代码
------

配置好数据源后，就可以用于任何支持 odbc 访问的应用中了，这里以 [pyodbc][1] 为例

    #-*- coding: utf-8 -*-
    import pyodbc

    conn = pyodbc.connect('DSN=test');
    cursor = conn.cursor()
    cursor.execute('select * from "省"')
    for row in cursor.fetchall():
        print row.Name

**注：如果是操作名称中文的表或者字段等，需要将其包含在双引号中，不然会出错，当然，将表名做成中文这么二的做法，
还是不推荐使用的啦**

pyodbc 是个很不错的库，api 也很好用，不过对中文支持的并不好，它并没有默认以 unicode 处理数据，所以对于中文相关的应用，
编码问题无处不在，只得慢慢折腾了。

参考
-------

 - [pyodbc wiki: Getting Started][r1]
 - [unixODBC: Connect to .mdb in Linux?][r2]
 - [软件包: libmdbodbc (0.5.99.0.6pre1.0.20051109-7)][r3]


[1]: http://code.google.com/p/pyodbc/
[r1]: http://code.google.com/p/pyodbc/wiki/GettingStarted
[r2]: http://nikunjlahoti.com/2010/11/03/unixodbc-connect-to-mdb-in-linux/
[r3]: http://packages.debian.org/squeeze/libmdbodbc

