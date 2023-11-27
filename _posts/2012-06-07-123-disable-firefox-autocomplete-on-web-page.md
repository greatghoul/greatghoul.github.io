---
slug: 123-disable-firefox-autocomplete-on-web-page
date: '2012-06-07'
layout: post
title: 火狐下禁用表单自动完成
tags:
  - HTML
issue: 123
---

Firefox 默认会自动记住网页中的表单状态，这样，如果我们的页面中一些表单元素的状态关系到一些页面逻辑，
Firefox 的这一特性自然会破坏掉我们的逻辑。

比如说，勾选某个复选框就显示某一个页面元素，而这个动作是靠绑定的事件触发的，那当勾选了该复选框后指
定的元素被呈现，但当我们刷新页面后，Firefox 记住了这个勾选状态，但因为没有触发事件，结果需要呈现的
元素并不会按预期的那样呈现。

这时候我们需要考虑在页面上禁用 Firefox 的表单自动完成功能，显然在 Firefox 的设置页中设置并不是个有
效的方法，事实上 Firefox 给我们提供了一个非常方便的方法：`autocomplete="off"`

1) 如果需要禁用 FORM 下所有表单元素的自动完成功能，则在 FORM 元素上加上 `autocomplete="off"`

```html
<form action="/path/to/action" method="post" autocomplete="off">
...
</form>
```

2) 如果只要在某个特定的表单元素上禁用自动完成功能，则只在该元素上加上 `autocomplete="off"`

```html
<input type="checkbox" autocomplete="off" /> Show Something
```

参考资料：<https://developer.mozilla.org/en/How_to_Turn_Off_Form_Autocompletion>

