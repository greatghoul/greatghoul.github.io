---
layout: post
title: 清除twitter脚本，在本地顺畅浏览bootstrap文档
slug: batch-remove-twitter-widgets-js-in-bootstrap-doc-files
date: 2012-07-10 12:32
tags: [bootstrap]
---

在本地下载了 [bootstrap 的文档]，便于开发时查阅，但是文档的 html 文件中有引用 
`http://platform.twitter.com/widgets.js` 但因为在镇上的关系，没有翻墙的情况下，
这个文档必须等到 `widgets.js` 这个请求 `404` 后才能正常使用（在中国做开发者悲剧呀）。

所以只要我们把每个 html 中的这个引用都删除掉就 ok 了，在 linux 终端中进入文档所在
目录，输入下面的命令即可

    sed -ie 's/^.*twitter\.com\/widgets\.js.*$//g' *.html

然后，正常的使用 bootstrap 文档吧

[1]: https://github.com/twitter/bootstrap/zipball/master
