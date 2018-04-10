---
title: 用 Remarkjs 和 Markdown 写幻灯片
date: 2014-11-21 17:55
tags: markdown, slides
---

## 什么是 RemarkJS

[RemarkJS] 是一个直接使用网页渲染 [Markdown] 内容的幻灯片写作工具。
这需要安装庞大的软件，也不需要通过命令行工具来执行 Markdown 转换的过程。
你所需要的只是一个广本编辑器和一个支持 HTML5 的浏览器。

## 一个例子

先来看一个例子

    class: center, middle
    
    # Title
    
    ---
    
    # Agenda
    
    1. Introduction
    2. Deep-dive
    3. ...
    
    ---
    
    # Introduction
    
    bala bala bala

上面的 Markdown 内容经过 RemarkJS 的渲染，会变成下面的样子。

<iframe src="https://tripu.github.io/remark/remarkise?url=https%3A%2F%2Fgist.githubusercontent.com%2Fgreatghoul%2Fea4e72a819fe764efafc%2Fraw%2Fa48bd467e6eca3cca7e2ba0598cdf70cb793d442%2Fslide.md" frameborder="0" width="100%" height="400"></iframe>

具体的用法可以参考 [RemarkJS Wiki][1]

## RemarkJS 的优势

优秀的幻灯片软件很多，但 RemarkJS 的小巧让人格外的喜爱，同时，它还有如下的特性：

- 使用 Markdown 写作，可以专注于内容
- 支持语法高亮，程序员做幻灯片这个可不能少
- 自动适配各种屏幕，移动设备上也可以播放
- 支持触摸屏手势，比如手指滑动就是跳页
- 使用纯文本文件写作，方便与他人协作编辑（比如，通过 git)
- 静态文件方便分享，Dropbox, JSFiddle, Github Pages 等等
- 借助 Chrome 浏览器的打印功能，可以方便的将幻灯片保存为 PDF 文档
- 当然，它是开源的 <https://github.com/gnab/remark>

## 相关的服务

- Markdowner - <http://www.markdowner.com/>  
  一个使用支持 RemarkJS 的在线 Markdown 编辑器

- Remarks - <http://remarks.sinaapp.com/>  
  一个播放 Github 仓库或者 Gist 中的 Markdown 幻灯片的服务

- Remarkise - <http://tripu.github.io/remark/remarkise>  
  一个播放给定网址的 Markdown 文件的幻灯片服务，**本文的示例就是使用的这个服务**。

## 其它类似的工具

- DeckJS - <http://imakewebthings.com/deck.js/>
- HTML5 Presentation - <http://slides.html5rocks.com/>
- Cleaver - <https://github.com/jdan/cleaver>
- ImpressJS - <https://github.com/bartaz/impress.js/>
- LandSlide - <https://github.com/adamzap/landslide>
- MarkdownPresenter - <https://github.com/jsakamoto/MarkdownPresenter>
- KeyDown - <https://github.com/infews/keydown>


[RemarkJS]: http://remarkjs.com/
[Markdown]: http://daringfireball.net/projects/markdown/syntax

[1]: https://github.com/gnab/remark/wiki