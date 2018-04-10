---
title: 在使用 suds 开发 webservices 客户端时禁用缓存
slug: disable-cache-in-suds-webservice-client
date: 2012-05-10 18:51
tags: [pyton, webservice]
---

最近由于工作需要，需要使用 [rpclib] 和 [suds] 开发 webservice 应用，因为开启阶段需要经常调试，
接口变化比较频繁，导致在利用 suds 访问 webservice 时经常找不到方法或者参数不正确，经观察发现
是缓存问题，suds 默认是开启了缓存的。

因为 rpclib 是动态生成 wsdl 的，如果每次都重新生成一次，是相当浪费资源的，一旦一个接口稳定了，
wsdl 就不会变化了，所以缓存的作用还是相当重要的，但是在开发的过程中会对调试造成不便，所以在开
发时，最好不要开启缓存。

    client = Client('http://127.0.0.1:9797/?wsdl', cache=None)

为了便于调试，最好打开日志

    import logging
    logging.basicConfig(level=logging.INFO)
    logging.getLogger('suds.client').setLevel(logging.DEBUG)

[rpclib]: https://github.com/arskom/rpclib
[suds]: https://fedorahosted.org/suds/
