---
layout: post
title: 下载Chrome扩展安装包的Bookmarklet
slug: bookmarklet-to-download-chrome-extension-file
date: 2012-03-01 21:56
tags: [bookmarklet, chrome-extension]
---

由于墙的关系，有时候在 [chrome web store][1] 中安装扩展时，经常会下载失败，不过如果[直接下载 crx 文件][2]时，
成功率也会大得多，或者你会需要将 crx 文件拿到一个没有网的地方使用，比如说在华为里面做外包的程序猿。

于是，我写下了这个 bookmarklet ([什么是Bookmarklet?][3])

<a title="Download Chrome Extension File" href="javascript:(function() {try {var prefix = /^https?\:\/\/chrome\.google\.com\/webstore\/detail\//;if (!prefix.test(window.location.toString())) {throw new Error('Not a valid chrome extension page url.');}var crxId = window.location.pathname.split('/')[3];var crxUrl = 'https://clients2.google.com/service/update2/crx?response=redirect&amp;x=id%253D' + crxId + '%2526uc';window.location =  crxUrl;} catch (e) {if (confirm('Not a chrome extension page, contact author for help')) {document.location  = 'mailto:greatghoul@gmail.com?'+ 'subject=' + encodeURI('Need help for bookmarklet: downcrx')+ '&amp;body=' + encodeURI(document.location) + encodeURI('\nError: ' + e.message);}}})();void(0);">GetCrx</a> <span style="color: #888888;">Drag me to the bookmark bar.</span>

将上面的链接拖到书签栏，在扩展页面上点击这个书签就可以下载扩展文件了（[试一下][4]）

当然这种下载方法也许因为 google 改变了扩展页面的url结构就会失效了，如果URL不符合目前的结构，这个脚本会告诉你并
尝试给俺发邮件寻求帮助，俺收到邮件会尽快更新脚本的。

源码暂时放在 github 上面了，这里是[传送门][5]。

**ps: 如果是webapp，即使下载了 crx 文件也是无法安装的。**

++Update: 2012-06-04：Chrome默认下载crx的行为已经更改为直接安装，所以，用GetCrx的Bookmarklet，不能下载crx到本地，可以改用GetCrxUrl来获取包含下载地址的xml，然后使用下载工具手动下载。++

[1]: https://chrome.google.com/webstore/
[2]: http://xy7.cn/blog/post/63.html
[3]: http://en.wikipedia.org/wiki/Bookmarklet
[4]: https://chrome.google.com/webstore/detail/nckgahadagoaajjgafhacjanaoiihapd?utm_source=chrome-ntp-icon
[5]: https://github.com/greatghoul/G2WLab/tree/master/downcrx-bookmarklet
