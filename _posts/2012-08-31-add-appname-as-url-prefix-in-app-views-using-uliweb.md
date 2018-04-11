---
layout: post
title: uliweb中为app指定url前缀
slug: add-appname-as-url-prefix-in-app-views-using-uliweb
date: 2012-08-31 13:57
tags: [python, uliweb]
---

使用 uliweb 时，如果使用 `@expose` 设置 `url` 映射时，并不会在生成的 `url` 
前添加 `appname` 作为 url 的前缀

如果需要为 `app` 显式添加 `url` 前缀，需要手动配置。

比如我们有一个 `app` 名为 `services` `/project_root/apps/services/`

如果要访问 `services` 下的 `/home` 地址，即 `http://<host>:<port>/services/home`

需要在 `/project_root/apps/settings.ini` 中添加` [URL]` 的 配置

    [URL]
    services = '/services'

在 `views` 中， `@expose('/home')` 将被解释为 `http://<host>:<port>/services/home`

[Uliweb官方文档][1]中似乎没有这样配置的说明

[1]: http://uliweb.readthedocs.org/en/latest/url_mapping.html
