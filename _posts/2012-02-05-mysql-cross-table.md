---
layout: post
title: 使用SQL实现交叉表
slug: mysql-cross-table
date: 2012-02-05 23:03
tags: [mysql, sql, report]
---

年前去面试时，被问到这样一个 sql 题目：

> 有张表，统计了 部门、月份、盈利这三个主要数据，要求仅使用 SQL 作出一张以部门和月份为分组的交叉表。

显然俺是被难住了，之前看项目组里一个大牛有写过，但也没有去记住细节，这个问题，要是把 12 个月份作为字段写死，其实倒
还挺容易解决，不过意义不大，自然是要寻求一个能够通用的解决方法了。

要想数据库中的值动态地构造列，使用简单的 sql 自然是无法达到的，必须得借助变量循环什么的才靠谱，几经摸索，搞出了 mysql 
的实现。

    set @sql:= 'select department ';
    select @sql:=concat(@sql, ', sum(if(month=\'', month, '\', income, 0)) as \'', month, '\'')
    from (select distinct month from test order by month) t1;
    set @sql:=concat(@sql, ' from test group by department;');
    prepare statement from @sql;
    execute statement;

查询结果：

![mysql 交叉表](http://pic.yupoo.com/greatghoul_v/BIOCAdYV/xxhdA.png)

没有在大数据量的情况下测试效率如何，不过如果要大量使用交叉表，还是借助专业的报表工具比较保险一些。

