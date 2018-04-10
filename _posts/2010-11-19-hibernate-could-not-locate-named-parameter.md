---
title: Hibernate could not locate named parameter
slug: hibernate-could-not-locate-named-parameter
date: 2010-11-19 00:30
tags: [hibernate]
---

今天遇到一个特别奇怪的问题，执行以下查询时Hibernate报异常 

> Hibernate: could not locate named parameter[state]


    ::java
    this.session.createQuery("from " + Project.class.getName() + " project where project.state = :state").setParameter("state", state).list();

然而奇怪的是，很明显参数设置正常，苦恼地去向Google娘寻找答案，最近在[这里][^1]找到了答案：

> So to summarize, when you attempt to make a query on a non-entity, Hibernate will not complain that it is not an entity – it will complain about other things.

原来是因为我之前重建表结构时，屏蔽了无关实体的映射，后来忘记恢复了，在 `hibernate.cfg.xml` 中恢复实体映射，问题解决。

粗心是程序员的大忌呀！

[^1]: http://techblog.bozho.net/?p=131 "Hibernate: could not locate named parameter"
