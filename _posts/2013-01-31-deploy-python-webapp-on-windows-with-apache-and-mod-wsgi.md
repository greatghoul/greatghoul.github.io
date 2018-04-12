---
layout: post
title: windows下apache+mod_wsgi部署python web应用
slug: deploy-python-webapp-on-windows-with-apache-and-mod-wsgi
date: 2013-01-31 09:34
tags: [python, flask, apache, mod-wsgi]
---

最近开发了一个 [Google Analytics][ga] 相关的应用，但需要在 Windows 下部署，结合网上的相关经验，最终选择了 
``apache+mod_wsgi`` 这样的配置。

## 修改python应用 

> Note that mod\_wsgi requires that the WSGI application entry point be called 'application'. If you want 
> to call it something else then you would need to configure mod\_wsgi explicitly to use the other name.  
> *(via: [wiki][mqc])*

因为 mod\_wsgi 默认要求入口名称为 ``application`` 所以我们需要对自己的 python web 应用做一些修改。

假设我们使用 [flask][flask] 搭建的应用，而默认的入口名称为 ``app``， 建立一个 ``wsgi_handler.wsgi``

    import sys, os
    sys.path.insert(0, os.path.dirname(__file__)) 
    from application import app as application

## 下载安装 httpd

应用的入口修改好之后，就需要安装 apache 和 mod\_wsgi 了，**我使用的是32位的系统，64位系统下载的安装包可能
与32位的不同。**

打开页面 <http://apache.dataguru.cn//httpd/binaries/win32/>，下载 ``httpd-2.2.22-win32-x86-no_ssl.msi``，
下载后运行程序，按提示安装，具体过程这里不详述。

## 安装并配置 mod\_wsgi

目前 Windows 下对 python 支持的最好的应该就是 [mod\_wsgi][mw] 了。

下载 <https://code.google.com/p/modwsgi/downloads/detail?name=mod_wsgi-win32-ap22py27-3.3.so>

将下载的文件重命名为 ``mod_wsgi.so`` 后移动到 apache 的 ``modules`` 目录:

在 ``conf/httpd.conf`` 中加入如下配置 

    LoadModule wsgi_module  modules/mod_wsgi.so

## 配置应用 vhost

在 ``conf/httpd.conf`` 中启用 vhosts 配置文件

    # Virtual hosts
    Include conf/extra/httpd-vhosts.conf

编辑 ``conf\extra\httpd-vhosts.conf`` 删除无效的示例代码，并加入应用的配置 

    NameVirtualHost *:5000
    <VirtualHost *:5000>
        ServerName localhost 
        WSGIScriptAlias / E:\Projects\ga-data\wsgi_handler.wsgi
        <Directory E:\Projects\ga-data>
                Order deny,allow
                Allow from all
        </Directory>
    </VirtualHost>

其中 ``E:\Projects\ga-data`` 替换成应用真实的路径，**尽量避免将应用放在中文或者有包含空格的路径中**

接下来启动 Apache 并访问 <http://localhost:5000> 即可。

## 参考资料

 * [Flask Documentation - mod\_wsgi (Apache)](http://flask.pocoo.org/docs/deploying/mod_wsgi/)
 * [mod\_wsgi wiki - Installation On Windows](https://code.google.com/p/modwsgi/wiki/InstallationOnWindows)
 * [mod\_wsgi wiki - Quick Configuration Guide](https://code.google.com/p/modwsgi/wiki/QuickConfigurationGuide)


[ga]: http://www.google.com/analytics/
[mqc]: https://code.google.com/p/modwsgi/wiki/QuickConfigurationGuide "Quick Configuration Guide"
[flask]: flask.pocoo.org
[nw]: https://code.google.com/p/modwsgi/
