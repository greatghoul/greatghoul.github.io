---
layout: post
title: 隔行换色(CSS)
slug: interlaced-color-css
date: 2011-08-16 21:57
tags: [css, html]
---

目录
----------

 - 隔行变色(CSS)
 - [隔行变色(JS+CSS)][1]
 - [隔行变色(JS+CSS) 高级][2]

隔行变色(CSS)
---------------

在css中定义两种样式 `.odd{...}` 和 `.even{...}` 分别用于奇数行和偶数行的不同背景颜色。

在html标签中设置

    <ul id="list">
        <li class="odd">Item 1</li>
        <li class="even">Item 2</li>
        <li class="odd">Item 3</li>
        <li class="even">Item 4</li>
        <li class="odd">Item 5</li>
        <li class="even">Item 6</li>
        <li class="odd">Item 7</li>
        <li class="even">Item 8</li>
        <li class="odd">Item 9</li>
        <li class="even">Item 10</li>
        <li class="odd">Item 11</li>
    </ul>

可以在 jsp 中利用循环，设置不同的 class，实现不同行的不同颜色，不过这样会把前端的逻辑放在后端处理，并不是一个好的处理
方案。

<ul id="list" style="list-style-type: none; padding: 0px; margin: 0px;">
	<li class="odd"  style="color: #000; background-color: #e8bda6;">Item 1</li>
	<li class="even" style="color: #000; background-color: #e8aa89;">Item 2</li>
	<li class="odd"  style="color: #000; background-color: #e8bda6;">Item 3</li>
	<li class="even" style="color: #000; background-color: #e8aa89;">Item 4</li>
	<li class="odd"  style="color: #000; background-color: #e8bda6;">Item 5</li>
	<li class="even" style="color: #000; background-color: #e8aa89;">Item 6</li>
	<li class="odd"  style="color: #000; background-color: #e8bda6;">Item 7</li>
	<li class="even" style="color: #000; background-color: #e8aa89;">Item 8</li>
	<li class="odd"  style="color: #000; background-color: #e8bda6;">Item 9</li>
	<li class="even" style="color: #000; background-color: #e8aa89;">Item 10</li>
	<li class="odd"  style="color: #000; background-color: #e8bda6;">Item 11</li>
</ul>

[1]: http://www.g2w.me/2011/08/interlaced-color-js-css/
[2]: http://www.g2w.me/2011/08/interlaced-color-js-css-advanced/
