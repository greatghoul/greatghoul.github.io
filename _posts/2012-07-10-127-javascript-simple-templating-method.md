---
slug: 127-javascript-simple-templating-method
date: '2012-07-10'
layout: post
title: JavaScript实现简单的文本模板函数
tags:
  - JavaScript
issue: 127
---

背景
--------

在 javascript 开发中，如果要动态的构造一些 HTML 元素，经常需要拼接字符串，而对于一些的 HTML 片断，
拼接字符串低效而且容易出错，所以通常我们需要使用一个前台的模板工具，比如 [jquery-mustache][1]

使用前台模板工具的好处显而易见，尤其是在复杂的 web 项目中，能给我们节省很可观的开发时间，但是如果
是开发 jquery 插件这样的小东西，专门引入一个第三方的库就让人不能接受了，尤其是开发 UI 控件之类的
应用时，就更需要频繁使用模板这样的东西了。

我在开发公司项目中时有写一个 [bootstrap] 的插件，就苦恼这样的问题，于是我写了一个仅有一个方法的实现，
需要使用时，把这个方法拷贝到你的 javascript 中即可。

代码
--------

最新的实现见：<https://gist.github.com/3080410>

```js
// 格式化字符串
//
// 用法：
//
// var s1 = '%{1} and %{2}!';
// console.log('source: ' + s1);
// console.log('target: ' + fmt(s1, 'ask', 'learn'));
//
// var s2 = "%{name} is %{age} years old, his son's name is %{sons[0].name}";
// console.log('source: ' + s2);
// console.log('target: ' + fmt(s2, { name: 'Lao Ming', age: 32, sons: [{ name: 'Xiao Ming' }]}));
function fmt() {
    var args = arguments;
    return args[0].replace(/%\{(.*?)}/g, function(match, prop) {
        return function(obj, props) {
            var prop = /\d+/.test(props[0]) ? parseInt(props[0]) : props[0];
            if (props.length > 1) {
                return arguments.callee(obj[prop], props.slice(1));
            } else {
                return obj[prop];
            }
        }(typeof args[1] === 'object' ? args[1] : args, prop.split(/\.|\[|\]\[|\]\./));
    });
}
```

用法
--------

1) 如果都是简单参数，则直接使用参数表的形式传递模板变量：

```js
var s1 = '%{1} and %{2}!';
fmt(s1, 'ask', 'learn');  // 输出：ask and learn!
```

2) 如果需要将某个对象的变量注入到模板中，可以这样用：

```js
var s2 = "%{name} is %{age} years old, his son's name is %{sons[0].name}";
fmt(s2, { name: 'Lao Ming', age: 32, sons: [{ name: 'Xiao Ming' }]});
// 输出：Lao Ming is 32 years old, his son's name is Xiao Ming
```

对于一般的应用，这个方法已经能大大的简化我们的操作了，不过暂且还不支持循环和 if 操作，要实现，
可能会使方法变得复杂，还在思考中。

[1]: https://github.com/jonnyreeves/jquery-Mustache
[bootstrap]: http://twitter.github.com/bootstrap/
