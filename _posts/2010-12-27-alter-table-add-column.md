---
layout: post
title: Alter Table Add Column
slug: alter-table-add-column
date: 2010-12-27 18:19
tags: [sql, sqlserver]
---

非常反感客户在项目后期还不停要加东西，比如经常需要增加字段，之前都是用可视化的数据库管理工具，
没有在 Sql Server 中直接使用 sql 向表中添加过字段，语句什么的吧，自然是记不住了，
Google了一下 ，发现很多文章中都这样写：

    ALTER TABLE PM_PROJECT ADD COLUMN PROJECTINCOMETYPE_ VARCHAR(255) NULL

结果总是报 

    ADD COLUMN 附近有语法错误 

莫名其妙，还以为是之后的语句有问题呢，再次Google后才在[一篇文章][^1]中看到原来语句中不加 `COLUMN` 的。

**正确的用法：**

    ALTER TABLE PM_PROJECTADD PROJECTINCOMETYPE_ VARCHAR(255) NULL

如果是添加多个字段，用逗号隔开：

此段代码摘录自： <http://sqlserverplanet.com/sql/alter-table-add-column/>

    CREATE TABLE dbo.Employees
    (
        EmployeeID int IDENTITY (1,1) NOT NULL PRIMARY KEY NONCLUSTERED
    )
    GO
    ALTER TABLE dbo.Employees
    ADD
        FirstName varchar(50) NULL
        ,LastName varchar(50) NULL
        ,SSN varchar(9) NULL CONSTRAINT ssn_unique UNIQUE
        ,IsTerminated bit NOT NULL DEFAULT 0
        ,DateAdded datetime DEFAULT GETDATE()
        ,Comments varchar(255) SPARSE NULL
        
[^1]: http://sqlserverplanet.com/sql/alter-table-add-column/ "Alter Table Add Column - SQLServerPlanet"
