---
layout: post
title: Markdown幻灯片服务Remarks更新：支持自定主题
slug: remarks-add-theme-support
date: 2013-04-25 10:13
tags: [remarks, slides]
---

[**Remarks**][^1] 是一款基于 [remark][^2] 的幻灯片工具，它允许你在 gist 或者 github 仓库中使用 markdown 来写幻灯片，
然后通过 remarks 的服务自动生成幻灯片并演示，让你更关注于幻灯片的写作，提高效率．

![remarks](http://pic.yupoo.com/greatghoul_v/COqxV52P/koeIi.png)

现在 Remarks 支持自定义幻灯片主题啦，默认情况下，remarks 会使用官方演示幻灯片的样式作为默认主题．

如果不想使用默认的主题，可能通过 `theme` 属性指定

    title: 这是纪灯片标题
    theme: mytheme.css

或者

    theme: ../themes/mythemes.css

或者

    theme: http://www.mydomain.com/static/mytheme.css

具体示例可以参考：

 * Repo版本： <https://github.com/greatghoul/slides>
 * Gist版本： <https://gist.github.com/greatghoul/5123482>

Remarks 是开源软件，目前布署在 sae 上面： <https://github.com/greatghoul/remarks>

 * 项目地址： <https://github.com/greatghoul/remarks>
 * 提交问题： <https://github.com/greatghoul/remarks/issues>
 * Gurudigger: <http://gurudigger.com/ideas/590>

[^1]: http://www.g2w.me/2013/04/intro-remarks/
[^2]: https://github.com/gnab/remark

