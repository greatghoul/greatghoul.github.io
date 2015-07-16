---
title: 解决 rails 的 data-remote 链接生效前用户误触的问题
date: 2015-07-17 00:36 CST
tags:
  - rails
  - jquery_ujs
  - ajax
---

[jquery_ujs] 对 rails 来说，是一个非常重要的组件，它包含在 rails 的默认组件之中。

jquery ujs 包含一些非常便捷的功能，比如确认对话框、触发 ajax、自动禁用表单提交按钮等，本文主要讨论的是触发 ajax 的功能。

通过添加简单的标签属性，jquery ujs 可以把一个普通的链接或者表单转换成 ajax 提交，而不需要写 JavaScript 代码。

    <%= link_to '关闭项目', close_project_path(project), remote: true, method: :post %>

上面的代码会生成如下的代码

    <a href="/projects/1/close" data-remote="true" data-method="post">关闭项目</a>

当用户点击后，它会触发一个指向地址 `/projects/1/close`，method 为 post 的 ajax 请求，而不是 get 的 普通请求，这样使得实现 ajax 调用变得非常便捷。

## 网速慢导致的问题

事情并不都是美好的，在网速比较慢的时候，jquery ujs 的这个实现会出问题，如果文档还没有加载完成，用户就点击了链接，页面会发起一个到链接地址的 GET 请求，页面会跳转，但指向该地址的 GET 请求可以并不存在，这样就会出错。

有用户有提过一个[相关的 Issue][1]，但是开发者并没有受理，然而网速慢是中国的国情，问题我们还是得处理，借助于 CSS3 的一些特性，这个问题其实也不难解决。

## pointer-events

> [pointer-events: none;][2]
>  
>  The element is never the target of mouse events; however, mouse events may target its descendant elements if those descendants have pointer-events set to some other value. In these circumstances, mouse events will trigger event listeners on this parent element as appropriate on their way to/from the descendant during the event capture/bubble phases.

这个属性可以禁止元素的点击事件，因为一般 CSS 是先加载的，我们只要控制在页面加载完成之前给 jquery ujs 相关的元素应用 `pointer-events: none;` 样式，在页面加载完成后再去除该样式，就可以解决网速慢的情况下，页面没有加载完成时用户点击 rmote 链接导致的错误了。

## 解决方案

添加如下的全局样式，默认情况下含有 `data-remote` 和 `data-method` 属性的标签不可点击，除非 body 元素含有名为 `ready` 的 css class。

    [data-remote], [data-method] {
      pointer-events: none;

      button, input[type=submit] {
        pointer-events: none;
      }
    }

    body.ready {
      [data-remote], [data-method] {
        pointer-events: auto;

        button, input[type=submit] {
          pointer-events: auto;
        }
      }
    }

然后通过段简单的脚本让页面加载后给 body 元素添加 `ready` class

    $(document).ready ->
      $('body').addClass('ready')

----

于是，问题轻松的就解决了。

[1]: https://github.com/rails/jquery-ujs/issues/353
[2]: https://developer.mozilla.org/en-US/docs/Web/CSS/pointer-events

[jquery_ujs]: https://github.com/rails/jquery-ujs