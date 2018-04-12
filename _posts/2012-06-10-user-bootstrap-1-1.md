---
layout: post
title: Bootstrap定制页面的chrome插件
slug: user-bootstrap-1-1
date: 2012-06-10 11:43
tags: [bootstrap, chrome-extension, user-bootstrap]
---

最近公司的项目中在使用 bootstrap，需要根据需要[重新调整配色等][1]，但 bootstrap 的调整不像 
jqueryui 那样可以立即看到效果，因为就写了这个插件。

用于保存和恢复、导出的配置，也算是前段时间 [《Chrome扩展开发入门》][2] 的成果。

![user-bootstrap](http://pic.yupoo.com/greatghoul_v/C1UwPLRr/QpgJP.png)

扩展地址：<https://chrome.google.com/webstore/detail/jikanalbeapjalgednpjjcmmfnpiijih>

项目地址：<https://github.com/greatghoul/user-bootstrap>

定制页面：<http://twitter.github.com/bootstrap/download.html>

如果大家用得上的话，欢迎测试并[反馈][3]

PS: 由于 [chrome bug][4] 的关系，暂时没有想到方法在 popup 页面使用文件选择控件来导入导出的配置

[1]: http://twitter.github.com/bootstrap/download.html
[2]: http://www.slideshare.net/greatghoul/chrome-12527101
[3]: https://github.com/greatghoul/user-bootstrap/issues
[4]: http://crbug.com/104222
