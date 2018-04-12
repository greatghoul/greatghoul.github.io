---
layout: post
title: 使用rpclib编写webservice时注意使用unicode注释
slug: rpclib-webservice-with-unicode-document-comment
date: 2012-07-26 11:54
tags: [python, webservice, rpclib]
---

[rpclib] 是一个非常好用的 python webservice 库，可以动态的生成 wsdl，
不过这个项目已经基本停止，并被一个新的项目取代 [spyne]，由于旧的项目
工作已经比较稳定，所以我没有贸然升级到 spyne。

我在 rpclib 编写 service 方法时，遇到一个奇怪的错误：
访问 wsdl (http://localhost:9898/?wsdl) 页面，返回 `502 Bad Gateway`。

在日志中看到如下错误信息：

    ValueError: All strings must be XML compatible: Unicode or ASCII, no NULL bytes or control characters

我检查了代码，对比了之前可以工作的版本，发现并没有什么不对的地方。

    @srpc(RequestModel, _returns=Unicode)
    def shenzhen(request):
        """
        根据传入的token、车牌号及车驾号，以及验证码
        查询该车辆的违章记录
        """
        logging.info(request)
        query = ShenZhenQuery(request)
        return query.query_car_records()

但就是没有正确生成 wsdl，后来我删除了方法内所有的内容（包括注释），只留下一条返回 unicode 
字符串的语句，然后就工作正常了，但是当我加入了方法的文档注释后，又出来了之前的错误，于是我
怀疑到了注释上：中文的注释，却没有使用 unicode 字符串，于是使用 `u"" 中文注释 """` 后，一切正常！

查看生成的 wsdl，发现原来原来 rpclib 使用注释生成了

    <wsdl:documentation>

根据传入的token、车牌号及车驾号，以及验证码
查询该车辆的违章记录

    </wsdl:documentation>

难怪一遇到中文注释就会出错！

[rpclib]: https://github.com/arskom/rpclib
[spyne]: https://github.com/arskom/spyne
