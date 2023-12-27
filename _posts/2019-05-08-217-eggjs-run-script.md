---
slug: 217-eggjs-run-script
date: '2019-05-08'
layout: post
title: Egg.js 通过命令行脚本执行应用方法
tags:
  - Node.js
  - Egg.js
issue: 217
---


Rails 有 rake tasks 可以非常方便的在命令行执行一些应用的功能，但 eggjs 没有这样的机制，这在日常和应用打交道的时候，十分麻烦。比如：

* 手动清除指定资源的缓存
    
* 执行一个数据更新脚本
    
* 打印队列中等待重试的任务
    

如果不能通过通过命令行触发这些操作，那么你就得提供一个 api 让维护人员来调用，实现起来相对比较复杂。

那么 Egg.js 有没有类似的机制可以在普通 Node.js 脚本中调用应用实例中的方法呢？几经探索，在一个 Egg.js 的第三方库中找到了[类似的实现](https://github.com/Xuhao/egg-console/blob/develop/src/index.js)。

参考这个实现，我写了一个简单的 Node.js 脚本。

```js
const { Application } = require('egg')

const app = new Application({
  baseDir: process.cwd()
})

const ctx = app.createAnonymousContext()
ctx.model.User.findAll({
  where: {
    signin_retries_count: {
      [ctx.model.Op.gt]: 5
    }
  }
}).then(users => {
  for (let user of users) {
    console.log(user.nickname)
  }
})
```

这里有一个想不通的地方，egg-console 的实现中，应用方法是在一个 ready 的回调中执行的。

```js
const app = new Application({
  baseDir: process.cwd(),
})

app.ready(() => {
  const r = repl.start('> ')
  r.context.app = app
  r.context.ctx = app.createAnonymousContext()
})
```

但我实现使用时，这个 ready 方法的回调一直无法执行，并且日志中有这样的记录。

```erb
2019-05-01 22:28:10,985 WARN 69545 [egg:core:ready_timeout] 10 seconds later node_modules/egg-watcher/lib/init.js:15:14 was still unable to finish.
```

看日志，应该是和 egg-watcher 这人组件有关系，egg-console 的实现中，有移除 egg-watcher 这个插件的操作，不过我觉得加上这个步骤，脚本变得有些复杂，所以没有加入。具体便不再深入研究了。

## 参考资料

* [可否支持类似于rails console那样的功能](https://github.com/eggjs/egg/issues/2064)
    
* [Xuhao/egg-console](https://github.com/Xuhao/egg-console/blob/develop/src/index.js)
