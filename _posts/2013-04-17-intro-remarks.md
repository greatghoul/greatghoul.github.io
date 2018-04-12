---
layout: post
title: 基于remark和github的幻灯片工具 -- Remarks
slug: intro-remarks
date: 2013-04-17 10:49
tags: [remark, github, slides]
---

介绍 Remark Slides 之前，先来介绍下 [Remark](https://github.com/gnab/remark "Remark") 

**Remark** 是一个基于 markdown 语法的幻灯片制作工具，要运行它，只需要一个浏览器就足够了，不再需要其它的编译或者
转换工具。它通过 JS 版本的 Markdown 解释器来将 Markdown 动态渲染成 HTML 效果并在浏览器中呈现，支持以下功能。

- 使用 Markdown 编写，并支持一些语法扩展
- 语法高亮
- 完善的缩放设计，能够在各种设置上表现一致
- 支持智能手机和平板上的触摸事件

简言之，Remark 利用了 Markdown 的优势解放了你对于工具的依赖，使你可以专注于幻灯片内容的编写。

而 Remark Slides 则是专为 [Github](http://www.github.com) 用户而设计的，你可以在 [Gist](https://gist.github.com/) 
或者仓库中创建幻灯片的内容部分，而 Remark Slides 则负责提取你的幻灯片内容并填入预设的 HTML 文件中，你甚至可以切换
各种主题模板。

我已经SAE上面部署了应用的雏形 <http://remarks.sinaapp.com/>

## Demo

 * Gist版: <http://remarks.sinaapp.com/gist/5123482/>
 * Repo版: <http://remarks.sinaapp.com/repo/greatghoul/slides/google-oauth2-and-analytics-data-api/>

## 用法

slides 的源文件，需要写在 `slides.md` 中，其中为 remark 风格的 slides 源码（仅 markdown 部分)，不过需要额外的指定
一个 `title` 属性，以标明 slides 标题，如：

    title: 这是纪灯片标题
    name: inverse
    layout: true
    class: inverse
    ---
    ...

Gist适合用来存放比较独立的一些 slides，只需要在 gist 中建立一个 `slides.md` 文件，然后编写内容就可以了。写作完成后
可以通过 `http://remarks.sinaapp.com/gist/<gist_id>` 来访问.

如果有比较多的 slides，放在 gist 里面就比较零乱，这时候可以建立一个 github 仓库来管理 slides，结构如下

    /repo/path
      /slides-folder1
        /slides.md
        /picture1.png
        /picture2.png
      /slides-folder2
        /slides.md
        /picture1.png
        /picture2.png

如果将 slides 存储在 repository 中，还可以引用 slides.md 所在目录下的图片文件，不用再单独寻找图床了。

写作好的 slides 可以通过 `http://remarks.sinaapp.com/<owner>/<repo>slides-name` 来访问。比如 
`http://remarks.sinaapp.com/greatghoul/slides/slides-folder1/`。

如果 slides 没有在 master 分支上，还可以通过

`http://remarks.sinaapp.com/greatghoul/slides/slides-folder1/?branch=branch-name` 来访问

在 <http://remarks.sinaapp.com/> 上还提供了一个 Bookmarklet 来方便的把当前的 gist 或者 repository 通过 remarks 打开。

## 更新历史

**2013-04-16**
 
 * 新增：对 Github Repository 的支持
 * 更新：新的 Bookmarklet 以支持 gist 和 repo 方式打开
 * 更新：更新 <http://remarks.sinaapp.com> 的应用介绍

**2013-03-13**

 ＊ 新增了 Bookmarklet，可以在 gist 页面点击书签来播放幻灯片

## 开源

应用于的源码已经放在了 github 上面 ，使用 Flask 开发，都是很简单的代码。

<https://github.com/greatghoul/remarks>

如果有意见和建议，欢迎在 Issue 中提出。
