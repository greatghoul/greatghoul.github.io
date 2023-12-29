---
slug: 221-two-js-problems-in-safari
date: '2019-11-19'
layout: post
title: 两则兼容老版本 Safari 的 JavaScript 问题记录
tags:
  - JavaScript
issue: 221
---

最近上线的远程工作者社区[电鸭社区](https://eleduck.com/)，是使用 nextjs 开发的，有的用户反馈在 safari 10 下面打开会报 500, 但其它浏览器却没有这个问题，有小伙伴给我报告了错误的控制台信息。

```erb
TypeError: Attempted to assign to readonly property.
```

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/8be56570-3853-4578-a79c-7a9cefa335e0)

然而，没有更细致的错误堆栈，实在是不好定位，千辛万苦安装了 iOS 10.3.1 的 Simulator 后，终于复现了这个问题。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/783ef9b0-c0b3-486b-ad59-aeb39431acb0)

在 Safari 老版本上面元素的 style 属性是只读项，这导致页面加载失败。

换成 `document.body.removeAttribute(’style’)` 后问题解决。

不幸的是，又立即遇到了新的问题，发送请求用的 axios 库返回的 promise 调用 finally 时报错了，老版本的 safari 也不支持这种用法。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/d08e9060-20fc-472b-8070-119c1e239b08)

很容易就在 axios 的 Issues 中找到了两种打适配补丁的解法

1\. 使用 CDN

```erb
<script src="https://polyfill.io/v3/polyfill.min.js?features=Promise.prototype.finally" defer></script>
```

2\. 使用 Package Manager

```erb
yarn add promise.prototype.finally
```

```erb
const promiseFinally = require('promise.prototype.finally');
promiseFinally.shim();
```

我使用的是 CDN 的方式。

---

参考资料

* [How to set element style property in strict mode?](https://stackoverflow.com/questions/24906279/how-to-set-element-style-property-in-strict-mode)
    
* [Axios Issues #34 Support finally?](https://github.com/axios/axios/issues/34#issuecomment-501296675)
    
* [TypeError: \_axios2.default.post(...).then(...).catch(...).finally is not a function](https://github.com/axios/axios/issues/1955#issuecomment-497698234)
