---
layout: post
title: 谨慎使用 python 全局日志
slug: take-care-of-python-root-logger
date: 2012-08-09 15:08
tags: [logging, pysimplesoap, python, soap, uliweb, webservice, werkzeug]
---

在使用 uliweb 开发 soap webservice 后，启动 uliweb 时，werkzeug 的日志莫名其妙丢失了。

正常的日志：

    [INFO]  * Loading DebuggedApplication...
    [INFO]  * Running on http://localhost:8000/
    [INFO]  * Restarting with reloader
    [INFO]  * Loading DebuggedApplication...

异常的日志：

    [INFO]  * Loading DebuggedApplication...
    [INFO]  * Loading DebuggedApplication...

事实上， werkzeug 相关 INFO 及其以下级别的日志全部都看不到了，这太诡异了，于是果断提交了 [issue][1]

而且我创建一个新的项目和 app 后，并没有日志丢失的问题，于是我怀疑是因为我从 uliweb 0.1.3 升级到 0.1.4 
导致的，我的项目是使用 0.1.3 创建的，之前也没有注意过日志的问题，但是得到 limodou 的答复后，我否定了这一点

> uliweb在创建项目时不会生成象 Django 一样的 manage.py 之类的东西，就是 settings.py 等一些配置文件和启动文件，
> 都是和版本无关的。

仔细想想，我的项目和新创建的项目的区别在于 `settings.ini` 丰富了一些，然后用了 pysimplelib，好吧，从源码追踪吧。

我看了 uliweb 内置的 zerkzeug 代码，创建日志这里很明确

`uliweb/lib/werkzeug/serving.py`

    112         if not logging.root.handlers and _logger.level == logging.NOTSET:
    113             _logger.setLevel(logging.INFO)
    114             handler = logging.StreamHandler()
    115             _logger.addHandler(handler)

当全局 `logging.root` 中已经定义了 `Handler` 或者 werkzeug 没有定义日志级别，werkzeug 会将其 logger 的日志级别
设置为 `info`，而打印 werkzeug 日志的地方，恰巧用了 `info` 级别

    [INFO]  * Running on http://localhost:8000/
    [INFO]  * Restarting with reloader

也就是说，因为已经定义其它 logging handler 的原因，导致无法输出 werkzeug 日志

grep pysimplelib 下的结果

    ./client.py:33: logging.basicConfig(format='%(levelname)s:%(message)s', level=logging.WARNING)
    ./simplexml.py:27:logging.basicConfig(format='%(levelname)s:%(message)s', level=logging.WARNING)
    ./transport.py:30:logging.basicConfig(format='%(levelname)s:%(message)s', level=logging.WARNING)

好吧，果然是这家伙在作祟，注释掉这三行代码后，werkzeug 日志正常输出

说起来，这不应该算是 uliweb 的问题，pysimplesoap 的库修改的全局设计，似乎应该给它提个 issue 才是，
这个 issue 应该可以关闭了。

这里有个 workaround，在 `apps/settings.ini `中添加

    [LOG.Loggers]
    werkzeug = {'propagate':0, 'level': 'info', 'format':'format_simple'}

当然，建议 limodou 将 `default_settings.ini` 中的 zerkzeug 的日志级别默认设置成 `info`，因为这个问题实
在太诡异了，毕竟 werkzeug 中的默认日志级别就是 `info`。

好了，回顾一下，pysimplesoap 中因为覆盖了全局日志级别，导致 werkzeug 无法输入低于 `warning` 的日志，所以，
如果我们在开发开放 python 库的时候，还是将日志打在自己的命名空间下吧，不要去碰全局的 logging 设置，这样
会对别人造成困扰。

[1]: https://github.com/limodou/uliweb/issues/2
