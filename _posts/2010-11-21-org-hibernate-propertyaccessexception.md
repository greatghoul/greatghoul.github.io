---
layout: post
title: 奇怪的org.hibernate.PropertyAccessException错误
slug: org-hibernate-propertyaccessexception
date: 2010-11-21 15:13
tags: [hibernate, java]
---

在一个实体中添加了两个新属性，手动改了表结构，重启服务后，进行查询时就碰到了这种错误

> Caused by: org.hibernate.PropertyAccessException: **could not set a field** value by reflection setter of .... BookMealRule.startMinute

然而奇怪的是，我只是进行查询而已，起初还以为是修改后的实体没有布署的原因，更新布署文件后重试，结果错误依旧。这下可头疼了。问题不在实体和映射上，难道是数据的问题？

打开数据库一查，因为是手动改的表结构，以前还有一条数据并没有删除，新加的那两个字段的数据值都为NULL，问题会不会在这里？在里面填上合适的值后，再重新查询。问题解决了！

有趣的是，[hibernate][^1]有一些错误提示不但不能够为你提供有用的信息，还要误导你。

[^1]: http://www.hibernate.org/ "Hibernate官方网站"
