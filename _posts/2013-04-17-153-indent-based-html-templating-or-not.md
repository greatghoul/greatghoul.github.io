---
slug: 153-indent-based-html-templating-or-not
date: '2013-04-17'
layout: post
title: '讨论基于缩进的HTML模板引擎 '
tags:
  - Ruby on Rails
issue: 153
---

本文讨论一下基于缩进的HTML模板引擎的适用性，例如 [jade][], [slim][], [haml][] 等。

什么是缩进式的模板引擎
----------------------

现在在 ruby/js/python 的社区中流行一些采用类 python 式的缩进语法的HTML模板引擎，语法简洁，以缩进来严格控制页面的层次结构，需要通过编译来转换成传统的 HTML 以用于展示。

来看看两个模板语言的区别 `erb` 和 `haml`

erb

```erb
<section class=”container”>
  <h1><%= post.title %></h1>
  <h2><%= post.subtitle %></h2>
  <div class=”content”>
    <%= post.content %>
  </div>
</section>
```

haml

```haml
%section.container
  %h1= post.title
  %h2= post.subtitle
  .content
    = post.content
```

缘由
--------

发起这篇讨论有两个原因。

1. 一同事坚持一公司项目中使用 slim （之前是使用 Haml，含泪劝说后竟然又改成了 slim，现在是项目中是 slim 和 erb 混用）
2. SegmentFault 上一个[关于 jade 的讨论][sf]

讨论
-------

我们先来看看这类模板引擎能够带来哪些好处？

 * 结构清晰：使用缩进来严格控制 DOM 层次，每个人写出来的页面都结构清晰，易于阅读
 * 语法简洁：可以用更少的代码快速的开发页面
   - 省略了闭合标签和 `<`, `>` 代码看起来更干净
   - 常用元素属性，例如 `id` 和 `class` 写法类似 CSS，简单高效
   - ....

看起来这类模板引擎开发还是挺方便的，不过仍然无法接受，理由如下：

 * 前端人员难以接受：以于公司的前端和设计，它们有时需要为我们调整页面，不要指望他们会喜欢这种语法，
   如果她们同步静态原型和动态页面的修改，将会非常麻烦（项目中开始的原型是最终定稿的情况非常少）
 * 语言支持太少：各 IDE 或者编辑器对它的语法高亮和缩进，补全等的支持有限，虽然我们使用 vim 能比较好的支持，
   但我不强制别人也用 vim
 * 太过小众：即便同样是开发，也不见得大家都会习惯这种语法
 * 调试困难：如果页面中某部分出了问题，首先前端会通过 firebug 定位问题出在哪里，如果是普通模板，
   直接就找到源码中的目标位置了，如果使用了此类模板，好吧，先用脑子翻译成这种模板，然后再去找目标位置，
   如果页面复杂，这种转换需要的时间也就更长。

总之做团队的项目，大家语言模板上一定要统一，这种自己喜欢玩 Geek 的人，会给后面别人维护时带来无穷无尽的麻烦。
**简化开发是好事，但是过犹不及。**

当然，如果项目成员都对这种模板有较高的接受度，书写简单，结构优美，开发快速，为什么不用呢？

其它讨论
------------

 * [用haml呼唤huacnlee(我已决定使用SLIM替代HAML和ERB)][^1]
 * [Fashion Runway: ERb vs. Haml][^3]
 * [jade这种js模板真的好吗？][sf]

[jade]: http://jade-lang.com/
[slim]: http://slim-lang.com/
[haml]: http://haml.info/
[sf]: http://segmentfault.com/q/1010000000182353

[^1]: http://ruby-china.org/topics/634
[^2]: http://segmentfault.com/q/1010000000182353#a-1020000000184633
[^3]: http://robots.thoughtbot.com/post/159805300/fashion-runway-erb-vs-haml
