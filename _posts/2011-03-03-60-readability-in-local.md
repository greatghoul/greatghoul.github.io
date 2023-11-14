---
slug: 60-readability-in-local
date: '2011-03-03'
layout: post
title: 内网中使用Readability
tags:
  - Python
  - Tool
  - JavaScript
issue: 60
---

[Readability][1] 这个 bookmarklet 是一个好东西，能够很好的改善我们的阅读体验。这个服务现在已经现在改版了，更加漂亮，
定制更加容易，不过我不是喜欢原来的，觉得更加简单轻便。

![Readability 效果图](https://github.com/greatghoul/greatghoul.github.io/assets/208966/9725b07b-2f72-44e1-b565-76f24dcdcbec)

工作是在华为外包，所以只能接触很少一部分外网，如 [javaeye][2] 什么的，不过还是能抽出空来阅读几篇文章，阅读长篇的文章，
比较习惯用 readability 先清洁下页面，读起来比较舒服，但是华为里面无法访问 readability 的服务器，所以起初只好自己写了
个类似的效应着用（功能相当弱小），改来改去都不是很满意，最后就放弃了，寻思着把 readability 搬到局域网里面用，因为 
readability 是用 javascript 实现的，所以搬到内网里面就变得相当容易。

下载了 readability 的相关代码，作了些小修改，就拿来用了，因为都是静态文件，布署起来非常简单。

**1. 下载 [readability文件包][1]，解压到任意目录 比如 `E:\wwwroot\readability\` ，得到如下文件：**

    readability.css
    readability-print.css
    sprite-readability.png
    readability.js
    readability.txt

**2. 使用 python 的 `SimpleHTTPServer` 建立 readability 服务：**

**windows系统**

在 `E:\wwwroot\readability\` 所在目录建立 bat 文件 `startup.bat`，内容如下：

    @echo off
    if not "%1" == "h" mshta vbscript:createobject("wscript.shell").run("python -m SimpleHTTPServer",0)(window.close)&amp;&amp;exit
    pause

给 `startup.bat` 创建快捷方式，将快捷方式放在开始菜单中的 启动 中，让它随机启动。

**linux系统**

参考 [Run Any Program During System Startup In Ubuntu Linux][4] （ubuntu 下的，别的我也不会）

**3. 在浏览器中添加书签 [Readability][5]**

    javascript:(function(){readConvertLinksToFootnotes=false;readStyle='style-novel';readSize='size-large';readMargin='margin-x-narrow';_readability_script=document.createElement('script');_readability_script.type='text/javascript';_readability_script.src='http://localhost:8000/js/readability.js?x='+(Math.random());document.documentElement.appendChild(_readability_script);_readability_css=document.createElement('link');_readability_css.rel='stylesheet';_readability_css.href='http://localhost:8000/css/readability.css';_readability_css.type='text/css';_readability_css.media='all';document.documentElement.appendChild(_readability_css);_readability_print_css=document.createElement('link');_readability_print_css.rel='stylesheet';_readability_print_css.href='http://localhost:8000/css/readability-print.css';_readability_print_css.media='print';_readability_print_css.type='text/css';document.getElementsByTagName('head')[0].appendChild(_readability_print_css);})();

**4. enjoy it.**

[1]: https://www.readability.com/bookmarklets/
[2]: http://www.javaeye.com/
[3]: http://note.sdo.com/u/444860682#/n/qx0Aa~jm_OOpnM00E000lw
[4]: http://www.addictivetips.com/ubuntu-linux-tips/run-any-program-during-system-startup-in-ubuntu-linux/
[5]: javascript:(function(){readConvertLinksToFootnotes=false;readStyle='style-novel';readSize='size-large';readMargin='margin-x-narrow';_readability_script=document.createElement('script');_readability_script.type='text/javascript';_readability_script.src='http://localhost:8000/js/readability.js?x='+(Math.random());document.documentElement.appendChild(_readability_script);_readability_css=document.createElement('link');_readability_css.rel='stylesheet';_readability_css.href='http://localhost:8000/css/readability.css';_readability_css.type='text/css';_readability_css.media='all';document.documentElement.appendChild(_readability_css);_readability_print_css=document.createElement('link');_readability_print_css.rel='stylesheet';_readability_print_css.href='http://localhost:8000/css/readability-print.css';_readability_print_css.media='print';_readability_print_css.type='text/css';document.getElementsByTagName('head')[0].appendChild(_readability_print_css);})();
