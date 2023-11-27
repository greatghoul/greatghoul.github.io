---
slug: 122-bootstrap-modal-shown-in-the-center
date: '2012-06-05'
layout: post
title: Bootstrap Modal 垂直居中
tags:
  - JavaScript
  - Bootstrap
issue: 122
---

Bootstrap 的 [modal][modal] 正文中如果内容较少的话，并不会垂直居中，而是偏上，
如果想要达到垂直居中的效果，需要自动动手了。

可以在初始显示时设置垂直居中，可以这样做：

```js
$('#YourModal').modal().css({
    'margin-top': function () {
        return -($(this).height() / 2);
    }
});
```

或者我们可以将这个效果注册到显示事件中

> **show: ** This event fires immediately when the ``show`` instance method is called.

```js
$('.modal').on('show', function() {
    $(this).css({
        'margin-top': function () {
            return -($(this).height() / 2);
        }
    });
});
```

## 参考资料

 * [Modal plugin of Bootstrap 2 is not displayed by the center](http://stackoverflow.com/a/10674087)
 * [Issue #374: .modal isn't shown in the center](https://github.com/twitter/bootstrap/issues/374#issuecomment-5170705)

[modal]: http://twitter.github.com/bootstrap/javascript.html#modals "Bootstrap Modal"
