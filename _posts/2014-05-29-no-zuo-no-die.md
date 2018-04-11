---
layout: post
title: 不折腾
slug: no-zuo-no-die
date: 2014-05-29 00:34
tags: [story, ruby]
---

突然心血来潮，想要将博客从目前的 [Acrylamid] 迁移到 [Jekyll]，于是经历了一番折腾。

两个 [Static Site Generator][1] 所使用的文件结构和格式各不相同：

- **文件结构不同**
  Acrylamid 使用 `content/:year/:month/:slug.md` 的文件结构存储文章源文件，
  而 Jekyll 使用的是 `_source/:year-:month-:day-:slug.md` 的形式
- **YAML Front Matter 不同**
  Acrylamid 中会包含 slug 而 Jekyll 不会，而且 Jekyll 还要指定 layout

而 Acrylamid 又没有提供导出的功能，而手工修改肯定不是咱大程序员的作风呀，因为只能借助
脚本了，鉴于这两年来接触 Ruby On Rails 比较多，所以考虑使用 Ruby 脚本来操作迁移的过程。

<script src="https://gist.github.com/greatghoul/9b82ef0c0a4de0790b98.js"></script>

成功迁移！不过发现 Jekyll 编译的速度好慢呀，已经超出了忍受的界限，在编译速度上 Acrylamid 
处理的还是很赞的，只编译更改的部分，速度会快很多，尤其是在文章比较多的时候，尤为明显。

另外，我还需要移植我目前博客的皮肤，两个工具的模板引擎也不相同，要移植起来也不轻松。
这时候我突然又想移植到 [Middleman] 上面，因为前段时间看到 [叶玎玎][2] 的博客用的就是这个。

当然，又是一番折腾，结果发现 middleman 配置和移植起来也挺麻烦，静下以来吃个雪糕顺便想一想，
Acrylamid 已经满足我所有的需要了，我为什么要折腾，不如洗洗睡吧。

No Zuo No Die!

[Acrylamid]: https://github.com/posativ/acrylamid
[Jekyll]: http://jekyllrb.com/
[Middleman]: http://middlemanapp.com/

[1]: http://staticsitegenerators.net/
[2]: http://yedingding.com/
