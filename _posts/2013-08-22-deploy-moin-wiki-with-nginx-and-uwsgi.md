---
layout: post
title: CentOS下使用Nginx和uwsgi部署MoinMoin
slug: deploy-moin-wiki-with-nginx-and-uwsgi-in-centos
date: 2013-08-22 10:48
tags: [centos, nginx, moinmoin, uwsgi, python]
---

在 CentOS 下使用 apache+mod\_wsgi 部署了 MoinMoin，但是编辑和保存页面很慢，于是准备使用 nginx+uwsgi 重新部署

本文假定已经按照官方指引 [Quick MoinMoin on CentOS][guide] 完成了 apache 和 mod\_wsgi 之外的基础安装

[guide]: http://moinmo.in/HowTo/CentOSQuick

安装 Nginx
------------

默认情况下，CentOS 下没有 nginx 的源，需要自己手动添加，访问 <http://nginx.org/en/linux_packages.html#stable>
下载 [CentOS 6] 的 rpm 包，并安装

    wget http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm
    rpm -ivh nginx-release-centos-6-0.el6.ngx.noarch.rpm

然后执行下面的命令安装 nginx

    yum install nginx

[CentOS 6]: http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm

安装 uwsgi
---------------

安装 python 包管理工具 pip

    yum install python-devel python-setuptools
    wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py -O - | python

通过 pip 安装 uwsgi (使用豆瓣的境像)

    pip install -v uwsgi -i http://pypi.douban.com/simple

使用 uwsgi 启动 moin
---------------------

创建 uwsgi 配置 `/etc/uwsgi/uwsgi.xml` 内容如下

    <uwsgi>
    <socket>/var/run/moin.sock</socket>                                                                                     
    <chmod-socket>666</chmod-socket>
    <limit-as>256</limit-as>
    <processes>6</processes>
    <memory-report/>
    <vhost/>
    <no-site/>
    </uwsgi> 

其中 `<chmod-socket>666</chmod-socket>` 这句是这了防止 nginx 访问 `moin.sock` 没有权限。

重命名 moin 的 wsgi 启动脚本，以被 uwsgi 识别

    cd /usr/local/share/moin
    mv moin.wsgi moin_wsgi.py

要启动 uwsgi 可以使用下面的命令

    uwsgi -x /etc/uwsgi/uwsgi.xml

配置 nginx 访问 uwsgi
----------------------

建立 `/etc/nginx/conf.d/moin.conf` 内容如下

    #  moinmoin 虚拟主机配置
    server {
        listen YOUR_SERVER_IP:80;
        server_name localhost;

        access_log /var/log/nginx/moin.access_log main;
        error_log /var/log/nginx/moin.error_log info;

        location ^~ / {
            include uwsgi_params;
            uwsgi_pass unix:///var/run/moin.sock;
            # uwsgi_param UWSGI_PYHOME /usr/local/lib/python2.6/; #site-packages/;
            uwsgi_param UWSGI_CHDIR /usr/local/share/moin/;
            uwsgi_param UWSGI_SCRIPT moin_wsgi;
            uwsgi_param SCRIPT_NAME /;
            uwsgi_modifier1 30;
        }

        location ^~ /moin_static193/ {
            alias /usr/local/lib/python2.6/site-packages/MoinMoin/web/static/htdocs/;
            add_header Cache-Control public;
            expires 1M;
        }
    }

运行 nginx

    nginx

运行及故障排除
---------------

接下来你可以通过浏览器访问 Wiki 了，但是发现编辑和保存页面依旧很慢，然后稍微 Google 了下就发现了
一篇解决这个问题的[文章][r1]，很快解决了慢的问题

编辑 `wikiconfig.py` 加入如下配置

    log_reverse_dns_lookups = False

重启 uwsgi 后再访问 Wiki，发现慢的问题解决了（为什么我之前没有找到这篇文章！）

参考资料
---------

- [运行在 nginx 与 uwsgi 之上的 moinmmoin](http://garfileo.is-programmer.com/2011/4/24/run-moinmoin-on-uwsgi-and-nginx.26347.html)
- [MoinMoin 与 Nginx, fastcgi 与 uwsgi 的配置](http://apt-blog.net/moinmoin-on-nginx-via-fastcgi-and-uwgi)
- [MoinMoin部署:Nginx+uwsgi](http://blog.csdn.net/cnweike/article/details/8103719)
- [CentOS配置nginx+uwsgi环境][r1]
- [解决MoinMoin编辑/保存反应慢的问题](http://rsjy.org/484.html)

[r1]: http://messense.me/nginx-and-uwsgi-install-on-centos.html
