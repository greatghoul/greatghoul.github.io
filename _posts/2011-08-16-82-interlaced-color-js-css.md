---
slug: 82-interlaced-color-js-css
date: '2011-08-16'
tags:
  - JavaScript
  - CSS
layout: post
title: 隔行变色(JS+CSS)
issue: 82
---

## 隔行变色(JS+CSS)

在 css 中定义两种样式 `.odd{...}` 和 `.even{...}` 分别用于奇数行和偶数行的不同背景颜色。在网页加载后通过 javascript
获取要变色的标签列表，执行如下代码

```js
// 当文件加载时，执行代码。
window.onload = function() {
    // 获取<ul id="list" />对象
    var list = document.getElementById('list');
    // 获取list下面的所有li
    var items = list.getElementsByTagName('li');
    // 遍历items
    for (var i = 0; i < items.length; i++) {
        var className = (i % 2 == 0) ? ' odd' : ' even';
        items[i].className += className; 
    }
}
```

实现不同行的不同颜色，这样变完全在前端处理，不会与后端的逻辑混淆，是一种比较好的解决方案。

```html
<ul id="list" style="list-style-type: none; padding: 0px; margin: 0px;">
	<li class="odd"  style="background-color: #e8bda6;">Item 1</li>
	<li class="even" style="background-color: #e8aa89;">Item 2</li>
	<li class="odd"  style="background-color: #e8bda6;">Item 3</li>
	<li class="even" style="background-color: #e8aa89;">Item 4</li>
	<li class="odd"  style="background-color: #e8bda6;">Item 5</li>
	<li class="even" style="background-color: #e8aa89;">Item 6</li>
	<li class="odd"  style="background-color: #e8bda6;">Item 7</li>
	<li class="even" style="background-color: #e8aa89;">Item 8</li>
	<li class="odd"  style="background-color: #e8bda6;">Item 9</li>
	<li class="even" style="background-color: #e8aa89;">Item 10</li>
	<li class="odd"  style="background-color: #e8bda6;>Item 11</li>
</ul>
```
