---
slug: 31-ignore-useless-fields-while-serialize-json-in-struts2
date: '2010-04-25'
layout: post
title: Sturts2 使用 json-plugin 序列化时屏蔽无关对象
tags:
  - Java
issue: 31
---

在使用 struts2 的 json-plugin 时，如果要序列化一个 Action ，应该屏蔽掉不需要序列化的属性，比如 dao 等。

尤其是 Dao ，如果不屏蔽，将会导致如下错误：

    org.apache.struts2.json.JSONException: java.lang.reflect.InvocationTargetException
    org.apache.struts2.json.JSONException: org.apache.struts2.json.JSONException: org.apache.struts2.json.JSONException: org.apache.struts2.json.JSONException: org.apache.struts2.json.JSONException: org.apache.struts2.json.JSONException: org.apache.struts2.json.JSONException: org.apache.struts2.json.JSONException: org.apache.struts2.json.JSONException: org.apache.struts2.json.JSONException: org.apache.struts2.json.JSONException: java.lang.reflect.InvocationTargetExceptionpache.struts2.json.JSONException:

屏蔽的方法很简单：不要给该要屏蔽的属性设置 getter

或者 在要屏蔽的属性的 getter 前加上注解 `@JSON(serialize = false)` 这种方法

    @JSON(serialize = false)
    public UserDao getUserDao() {
        return userDao;
    }

