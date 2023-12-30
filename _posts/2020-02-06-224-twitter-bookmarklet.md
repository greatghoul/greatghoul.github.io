---
slug: 224-twitter-bookmarklet
date: '2020-02-06'
layout: post
title: 一个分享网页到 Twitter 的 Bookmarklet
tags:
  - Tool
issue: 224
---

[Bookmarklet](https://en.wikipedia.org/wiki/Bookmarklet) 是什么东西就不多作解释了，我之前用的一个分享页面到 twitter 的 bookmarklet 非常不好用，提取选中文本和解析网页标题时灵时不灵，Google 试用了一圈，也没有找到合适的，本来不是个什么复杂的东西，干脆自己写一个算了。

```javascript
(function() {
  var url = window.location.toString();
  var text = (window.getSelection().toString() || document.title || '').replace(/(^\s+|\s+$)/g, '');
  var tweetUrl = 'https://twitter.com/intent/tweet';
  var searchParams = new URLSearchParams();
  var left = screen.width / 2 - 700 / 2;

  searchParams.set('url', url);
  searchParams.set('status', text + '\n' + url);
  window.open(tweetUrl + '?' + searchParams.toString(), '_blank', 'chrome,centerscreen,width=700,height=260,top=100,left=' + left);
})();
```

压缩转译成 bookmarklet 就是

```erb
javascript:(function()%20{var%20url%20=%20window.location.toString();var%20text%20=%20(window.getSelection().toString()%20%7C%7C%20document.title%20%7C%7C%20%27%27).replace(/(%5E%5Cs%2B%7C%5Cs%2B%24)/g%2C%20%27%27);var%20tweetUrl%20=%20%27https%3A//twitter.com/intent/tweet%27;var%20searchParams%20=%20new%20URLSearchParams();var%20left%20=%20screen.width%20/%202%20-%20700%20/%202;searchParams.set(%27url%27%2C%20url);searchParams.set(%27status%27%2C%20text%20%2B%20%27%5Cn%27%20%2B%20url);window.open(tweetUrl%20%2B%20%27?%27%20%2B%20searchParams.toString()%2C%20%27_blank%27%2C%20%27chrome%2Ccenterscreen%2Cwidth=700%2Cheight=260%2Ctop=100%2Cleft=%27%20%2B%20left);})();
```

它支持下面的一些特性：

* 如果不选中文本，点击书签会分享 **网页标题+网址**
    
* 如果选中的文本，点击书签会分享 **选中的文字+网址**
    
* 打开的弹出窗口会居中显示
    
![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/10d3ecb3-fc15-4569-a7f3-519be2f82c0d)

Github 上不能发带有可执行代码的链接，你可以访问这个 Codepen 来试用。 https://codepen.io/greatghoul/pen/qpWMjR

---

如果你也想尝试尝试写个 Bookmarklet，推荐一些工具。

* [Bookmarklet IDE](https://chrome.google.com/webstore/detail/bookmarklet-ide/peebnjhlifoemfpcffdlbcdppmikglek/reviews) 一个 Chrome 扩展，界面巨丑，交互难受，但还算合用。
    
* [Make Bookmarklet](https://packagecontrol.io/packages/Make%20Bookmarklet) 一个 Sublime Text 的插件，写好 js 后运行插件的命令，会生成 bookmarklet 内容到文件第一行注释里面。
    
* [Bookmarklet Maker](http://bookmarklets.org/maker/) 一个在线的 bookmarklet 编辑器，实时转译，还支持引入 jQuery
