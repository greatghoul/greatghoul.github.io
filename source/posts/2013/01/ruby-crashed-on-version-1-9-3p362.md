---
title: 升级到ruby-1.9.3p362后服务间隙崩溃
slug: ruby-crashed-on-version-1.9.3p362
date: 2013-01-05 09:10
tags: [rails, ruby]
---

在新的服务器上安装部署 rails 应用后，页面一会正常，一会儿显示502, 没有什么规律，这种情况，
自然不是应用业务逻辑上面的问题，于是去扫了日志
 
    [Sun Dec 30 10:48:51 2012] [error] [client xx.xx.xx.xx] Premature end of script headers: groups, referer: http://server:port/locations   
    [ pid=5715 thr=139650060986112 file=ext/apache2/Hooks.cpp:841 time=2012-12-30 10:48:51.279 ]: The backend application (process 5684) did not send a valid HTTP response; instead, it sent nothing at all. It is possible that it has crashed; please check whether there are crashing bugs in this application.  
    **/usr/local/rvm/gems/ruby-1.9.3-p362/gems/activerecord-3.2.8/lib/active_record/relation.rb:241: [BUG] Segmentation fault**  
    ruby 1.9.3p362 (2012-12-25 revision 38607) [x86_64-linux]  
    ...   
    [NOTE]   
    You may have encountered a bug in the Ruby interpreter or extension libraries.   
    Bug reports are welcome.   
    For details: http://www.ruby-lang.org/bugreport.html   

错误记录中提示说是 ruby 解释器的 bug，因为服务在另一台服务器上运行正常，所以顺便查了下两个
服务器的 ruby 版本。 运行正常的服务跑在 `1.9.3p327`, 而出错的这个版本是 `1.9.3p362`

上网找了下 `1.9.3p362` 这个错误的记录，发现已经有人遇到过。

 * <https://github.com/gitlabhq/gitlabhq/issues/2436>
 * <http://permalink.gmane.org/gmane.comp.lang.ruby.core/50473>

既然 `1.9.3p327` 没有问题，那最简单的方法就是使用 `1.9.3p327` 版本了

    rvm install '1.9.3-p327'
    rvm '1.9.3-p327' --default

当然, gem 什么的，必要的话，最好重新装一下。
