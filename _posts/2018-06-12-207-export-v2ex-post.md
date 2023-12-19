---
slug: 207-export-v2ex-post
date: '2018-06-12'
layout: post
title: 我为 V2ex 写了个 Pdf 导出工具，方便保存撕逼帖子
tags:
  - UserScript
issue: 207
---

05 年的时候，正是我最喜欢逛 V2EX 的时候，那段时间撕逼反转的剧情特别多，就心血来潮建立了一个 [Awesome List](https://github.com/greatghoul/sibi/)，V2SB ( Way to Si Bi )，后来更名为 sibi，因为撕逼本来就比较有话题性，现在这个列表已经有 1000 多的 star 了。

然而撕逼事件看得多了，慢慢的也就觉得无趣了，到 07 年的时候，逐渐推动了热情，不再积极维护这个列表了。然后断断续续还有网友提交 PR 和 Issue，所以这个列表到今天，仍然会有一些更新。

因为一些撕逼帖子比较敏感，站长把它移动到了非公开节点，需要登录 V2EX 账户才能查看，还有一些帖子可能就直接删帖了，导致撕逼的证据丢失，所以网友 [yingziwu](https://github.com/yingziwu) 提出一些备份建议，并写了一个指南，也就是在 <https://archive.org/> 无法归档网站的时候，利用浏览器的保存网页、截图或保存 PDF 功能，将页面备份到 Github 仓库中，这样虽然解决了删帖后材料无法便捷访问的问题，[但也一些弊端](https://github.com/greatghoul/sibi/issues/50)。

-   保存的网页有图片、样式等文件，非常零乱，很多文件和主题完全没有关系
-   HTML 文件在 Github 上不能像 Markdown 那样直观的查看
-   截图会比较大，很占空间，这样不方便 Fork 后协作编辑
-   如果帖子分页很多，保存非常麻烦

[Github 建议占用的存储空间不要超过 1GB](https://help.github.com/articles/what-is-my-disk-quota/), 但我保存的一个有 4 页的帖子仅 [PDF 文件就有 5M 左右](https://github.com/greatghoul/sibi/blob/b2630d6d7057ec4e73128090d77af6a2e57bb1ff/v2ex/465592-github%20%E5%8F%88%E6%8C%82%E4%BA%86%E6%88%91%E7%9C%9F%E6%98%AF%E8%89%B9%E4%BA%86%20TG%20%E7%9A%84%E4%BB%99%E4%BA%BA%E4%BA%86.pdf)，这样仓库的体积增长会很快，并且，Github 并不适合存储 PDF、大图之类的文件，不但 clone 很慢，在线预览的速度和体验也很成问题。所以我在[如何添加撕逼事件](https://github.com/greatghoul/sibi/wiki/%E5%A6%82%E4%BD%95%E6%B7%BB%E5%8A%A0%E6%92%95%E9%80%BC%E4%BA%8B%E4%BB%B6)的 Wiki 中推荐使用 <https://www.pdf-archive.com> 来归档保存的 PDF，这个网站从 [2010](https://www.pdf-archive.com/2010/) 年运营至今，服务应该是比较稳定的，官方的 [FAQ](https://www.pdf-archive.com/faq/) 中说，除非不可抗事件或者触犯法律条款，文件可以一直保存，虽然要托管 PDF 文件必须要注册成为网站的用户（免费的）不那么文件，但这已经是我目前能找到的最好的方案了。如果你知道更好的方案，不妨留言告诉我。

方案有了，接下来就是怎么方便的把帖子保存成 PDF 了。V2EX 热门的帖子往往会分页，这样浏览器原生的保存网页或者打印对话框保存 PDF 的功能就不那么方便了，而且 V2EX 保存 PDF 时，样式会坏掉。

![V2EX 保存 PDF 时样式失效](https://github.com/greatghoul/greatghoul.github.io/assets/208966/fae51315-5672-4e37-8010-6c5e049cfaaf)

为了解决分页和样式的问题，我写了一个简单的[油猴脚本](https://zh.wikipedia.org/wiki/Greasemonkey)，你可以在下面的网址下载到。

<https://github.com/greatghoul/sibi/raw/master/tools/save-v2ex.user.js>

如果你的 Chrome 浏览器安装了 [Tampermonkey](https://chrome.google.com/webstore/detail/tampermonkey/dhdgffkkebhmkfjojejmpbldmpobfkfo) 扩展，它会自动识别 .user.js 的链接结尾的链接，并自动安装脚本。

这个脚本会在 V2EX 帖子的页面添加一个保存按钮。

![新增的保存按钮](https://github.com/greatghoul/greatghoul.github.io/assets/208966/4f07979a-7489-423c-9f66-ba6cf593b2c7)

点击这个按钮后，它会修正网页打印样式，移除和主题无关的页面元素，获取所有回复分页并合并到同一页中，然后触发打印对话框。

![优化后的 PDF 效果](https://github.com/greatghoul/greatghoul.github.io/assets/208966/b988f933-e849-4531-836e-1049b5e260e1)

点击保存，就会得到一个有完整分页内容的 PDF 文件了。

* * * * *

工具准备好了，如果你热衷于分享撕逼事件，欢迎给[这个列表](https://github.com/greatghoul/sibi/)提交 Pull Request，如有必要，请使用这个辅助脚本并反馈意见，如果你愿意帮忙改进，也非常欢迎。
