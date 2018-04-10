---
title: 在 turbolinks 的页面中使用 contentscripts
slug: contentscript-on-turbolinks
date: 2014-01-13 08:57
tags: [chrome-extension, turbolinks]
---

很多网站升级到 Rails 4 以后，[turbolinks] 就成了标配，网站响应快了，
但为开发 Chrome 扩展的我，也带来了一些困扰。

## 问题

使用了 Turbolinks 的网站，并不会像传统网站那样，页面变化后，会有 `DOMContentLoaded` 这样的事件。

> With Turbolinks pages will change without a full reload, so you can't rely on `DOMContentLoaded`
> or `jQuery.ready()` to trigger your code. Instead Turbolinks fires events on `document` to provide
> hooks into the lifecycle of the page.
>
> 参考： <https://github.com/rails/turbolinks#events>

也就是说，在 turbolinks 的页面上，你点击链接跳转时，不会再触发 `jQuery.ready()`， 这样一来，初始化的一些
方法就失效了。如果你的 Chrome 扩展中使用了 content script，那里面通过 `DOMContentLoaded` 来执行的代码，
除非页面进行了 full reload，不然就不会触发了。

## 方案

Turbolinks 吃掉了 `DOMContentLoaded`，但也给我们留下了其它的接口来捕获页面加载的事件，不然很多依靠这个
状态的脚本都会失效。

> **Instead Turbolinks fires events on `document` to provide
> hooks into the lifecycle of the page.**
> 
> `page:load` is fired at the end of the loading process.

我们不是还有个 `page:load` 事件可以用。

如果之前使用的 jQuery，可能是这样做的。

    $(document).ready(function() {
        // initialize code here...
    });

只要增加下面的方式即可：

    $(document).on('page:load', function() {
        // initialize code on page load here...
    });

**注：之所以不直接替换，是因为如果是直接通过网址访问的，那会有一次 full reload，并不会触发 `page:load` 事件。**

## 参考资料

 * [Turbolinks 事件说明](https://github.com/rails/turbolinks#events)
 * [针对 Turbolinks 开发的 ContentScript: Ruby China for Chrome](https://github.com/GDG-Xian/ruby-china-chrome)
 * [应用了 Turbolinks 的网站：ruby-china.org](http://ruby-china.org/)

[turbolinks]: https://github.com/rails/turbolinks
