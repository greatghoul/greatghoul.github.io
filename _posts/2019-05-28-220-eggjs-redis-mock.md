---
slug: 220-eggjs-redis-mock
date: '2019-05-28'
layout: post
title: Eggjs 如何在测试中使用 redis mock
tags:
  - Node.js
  - Redis
issue: 220
---

[eggjs](https://eggjs.org/) 这个框架对测试的支持还算不错，不过最近在使用 [egg-redis](https://github.com/eggjs/egg-redis/) 这个插件时，遇到了一些测试上面的问题。

为避免测试互相影响，我会在每个用例后清一次 redis

```js
# test/.setup.js
afterEach(async function () {
  await app.redis.flushall()
})
```

这样虽然满足了测试的要求，但会有一些副作用。

1.  测试时连接的真实的 redis 服务，速度较慢
2.  会清掉开发环境的数据（可以配置不同的实例来规避）

其实我们可以使用 redis mock 来解决这两个副作用，egg-redis 这个插件使用的是 ioredis 这个包，我们可以在测试环境的配置文件中覆盖 egg-redis 使用的 ioredis 版本（[需要 egg-redis 2.1.0 以上的版本](https://github.com/eggjs/egg-redis/commit/ee3fda1f95a178a6120fe32141c903d19f7f5ecb)）。

ioredis 有一个还算成熟的 mock 实现 [ioredis-mock](https://github.com/stipsan/ioredis-mock)，我们可以使用这个库。

```js
// config/config.unittest.js
config.redis = {
  Redis: require('ioredis-mock'),
  client: {
    data: {}
  }
}
```

这样测试环境下，redis 就不会去连接真实的 redis 服务了，而是在内存中模拟，速度上就很快了，也不会对开发环境的数据造成影响。

不过在具体测试时，发现了测试无法执行，因为 redis 连接超时。

2019-05-27 23:46:46,441 WARN 37722 [egg:core:ready_timeout] 10 seconds later /path/to/project/node_modules/egg-redis/lib/redis.js:53:7 was still unable to finish.

阅读一下这部分的代码，我们可以发现，应用一直没有收到 redis ready 事件，redis 插件无法初始化。

```js
# https://github.com/eggjs/egg-redis/blob/master/lib/redis.js#L53-L57
app.beforeStart(async () => {
  const index = count++;
  await awaitFirst(client, [ 'ready', 'error' ]); // <------
  app.coreLogger.info(`[egg-redis] instance[${index}] status OK, client ready`);
});
```

我们再去看看 redis-mock 的实现，会发现，它的 Redis 实例在初始化的方法里面，要么立即就推送了 ready 事件，要么压根不推，这与实际情况的 redis 连接是不相符的。

egg-redis 傻傻的在等待一个永远收不到的事件，所以测试就卡壳了。

```js
# https://github.com/stipsan/ioredis-mock/blob/master/src/index.js#L44-L47
class RedisMock extends EventEmitter {
  constructor(options = {}) {
    // ...
    if (optionsWithDefault.lazyConnect === false) {
      this.connected = true;
      emitConnectEvent(this);
    }
  }
  // ...
}
```

等待作者去修改是比较慢的，我们就先自己黑科技解决一下吧，用一个自定义的 Redis Class 继承自 ioredis-mock 的 Redis Class，在初始化的方法中延迟推送一个 ready 事件。这样去跑测试的时候，就可以顺利的走下去了。

```js
// config/config.unittest.js
const Redis = require('ioredis-mock')
class RedisMock extends Redis {
  constructor (options = {}) {
    super(options)
    setTimeout(() => {
      this.emit('connect')
      this.emit('ready')
    }, 1000)
  }
}

module.exports = appInfo => {
  const exports = {}
  exports.redis = {
    Redis: RedisMock,
    client: {
      data: {}
    }
  }

  return exports
}
```
