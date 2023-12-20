---
slug: 209-qcloud-serverless
date: '2018-12-15'
layout: post
title: QCloud 云函数踩坑记之异步调用返回结果为 null
tags:
  - Node.js
  - Serverless
issue: 209
---


最近在产品中尝试了腾讯云的云函数来运行一些相对耗资源的小任务，不得不说，腾讯云函数还是蛮方便的，搭配腾讯云的 API 网关，很方便可以做出一个 API 服务。

本来云函数运行的挺好，但昨天晚上突然出现了问题，API 接口返回总为空，既然代码之前都在生效，配额也还充足，那到底是哪里出了问题，我百思不得其解。

我的云函数大概是长这样的

```javascript
exports.main_handler = (event, context, callback) => {
  asyncCall().then(info => {
    console.log(info)
    callback(null, { info })
  })
}
```

正常情况下，通过 API 网关调用这个云函数，它返回的是 `{ info: { ... } }` 这样的内容，但突然之间，所以的调用都变成返回空。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/9949f033-3a56-4f7b-8c45-fdda1bb61fb6)

查了一些资料，在[这篇文档](https://cloud.tencent.com/document/product/583/11060)中看到

> 通过在 callback 回调执行前设置 `context.callbackWaitsForEmptyEventLoop = false;` ，可以使得云函数后台在 callback 回调被调用后立刻冻结进程，不再等待事件循环内的事件，而在同步命令完成后立刻返回。
> 
> 同样也可以通过使用 context.done 回调替换掉 callback 回调。context.done 回调的入参与 callback 回调入参相同。context.done 回调在被执行后同样会冻结事件循环监听的进程，在同步命令执行完成后立刻返回。

于是我尝试了 context.done 以及关闭循环检测，都没有任何作用。

这个文档中还有关于返回和异常的描述

> 如果在代码中未调用 callback，云函数后台将会隐式调用，并且返回 null。

这个很对症呀，虽然我的确是调用了 callback，而且之前的确是返回正常的，我想可能是腾讯变更了检测“如果代码中未调用 callback” 的检查策略，腾讯是怎样判断存在异步调用呢，我想应该是 Promise 吧，于是我改为明确的返回一个 promise 给云函数的入口函数，问题立即就解决了。

```javascript
exports.main_handler = (event, context, callback) => {
  return asyncCall().then(info => {
    console.log(info)
    callback(null, { info })
  })
}
```
