---
title: \\[Microsoft\\]\\[SQLServer 2000 Driver for JDBC\\]Error establishing socket.
slug: sqlserver-2000-error-establishing-socket
date: 2011-01-19 03:11
tags: [sqlserver]
---

又遇到了 [Sql Server 2000的经典问题][^1]：`[Microsoft][SQLServer 2000 Driver for JDBC]Error establishing socket.`

老规矩，检查版本：

    select @@version

如果 `8.00.760` 以下，就赶紧[打sp3的补丁][^2]吧。

**注意：** 这个补丁下载后，你双击运行它只是解压的过程，安装还需要你进入解压后的文件夹，执行 `Setup.exe`

sqlserver 200 sp3 补丁下载地址：<http://goo.gl/UUXxk>

[^1]: http://topic.csdn.net/u/20070601/08/b5692bef-76c0-4e6a-98a9-a05c2b373d88.html
[^2]: http://www.microsoft.com/downloads/details.aspx?familyid=90DCD52C-0488-4E46-AFBF-ACACE5369FA3&amp;displaylang=zh-cn
