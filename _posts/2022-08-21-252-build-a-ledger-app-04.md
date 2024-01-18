---
slug: 252-build-a-ledger-app-04
date: '2022-08-21'
layout: post
title: 做一个记账应用 04 - 批量记账
tags:
  - RegExp
  - Automation
issue: 252
---

在[上一步](https://anl.gg/post/251-build-a-ledger-app-03)实现了真正的手机上快捷记账的功能，接下来，就要不断改进它，让它变得更好。

所以这一节，我要加上批量记账的功能，可能我超市购物一次，但是买的东西确实不同用途的，相比一条条添加，显然一次加完更加省心。

## 捉虫

在开始之前，先来捉一个虫，之前在记录这样一笔账目时，发现了脚本的问题。

> 牛奶36.5营养品

识别成了

> 项目：牛奶，金额：36，分类：.5营养品

数字识别错了，这是我的正则只考虑到了整数，所以小数点被忽略了。

只需要把匹配数字的捕获组更新一下就好了。

```erb
findAll(text, "^(.*?)([0-9\\.]+)元?(.*)$")
```

注意这里的 `[0-9\\.]+` 其实是偷懒的做法，`...` 这种内容甚至也会被捕获到金额中，实际上的整数和小数匹配会[更复杂一些](https://stackoverflow.com/questions/14550526/regex-for-both-integer-and-float)，不过我是自用，**够用就好**。

## 多行文本

要支持输入框输入多行文本非常简单，Automate 的 Input Dialog Block 内置了很多种输入模式，甚至自带了数字、邮箱、网址等验证。

只需要把原本的 Text 类型改为 Multirow text 类型即可。

![多行文本输入](https://github.com/greatghoul/greatghoul.github.io/assets/208966/58b0ac3e-81b5-4a83-8ef8-a38d078c090e)

简单测试一下，会发现，多行文本的输出结果，是会换行的文本

![多行文本测试结果](https://github.com/greatghoul/greatghoul.github.io/assets/208966/9a5e52cc-b23b-47ef-8e78-9c9f53f4971f)

这样的结果，之前的处理逻辑肯定无法识别，需要处理一下。

## 使用循环

事实上，只要把多行文本按照行来单独处理，那么就和之前的逻辑一样了，所以这里需要做两件事

1. 把文本按照换行进行分割
    
2. 循环处理每一行
    

分割文本需要用到一个函数 [split](https://llamalab.com/automate/doc/function/split.html)

![split](https://github.com/greatghoul/greatghoul.github.io/assets/208966/1ba7d85e-5a7c-4a64-b8d0-603f127ca3b6)

```erb
split(text, "\\n")
```

`\\n` 表示换行，按照换行进行分割，会得到一个包含各行文本的数组，然后再[利用循环进行处理](https://llamalab.com/automate/doc/block/for_each.html)。

上图中，我已经使用了 For Each Block，这里面有两个关键点

* Container - 要循环的内容，可以是数组（循环每一个数组元素）、字典（循环每一个键值对）、文本（循环每一个字符）或者数字（循环多少次），本例中，使用的是数组
    
* Entry value - 循环的值，本例中，对应的是每一行的文本
    

其实 For Each Block 还有其它的参数可以配置，比如循环的索引，结束条件什么的，因为暂时不涉及，这里就不多说了，感兴趣的可以去看看[文档](https://llamalab.com/automate/doc/block/for_each.html)。

为了调试方便，我写了个简单的测试，循环一个多行文本，然后打印每一行的内容。For Each Block 的 Do 出口需要连接到循环体（本例中是一个Log Block），然后执行完成还要再连接回 For Each Block 的 In 入口，否则这个循环跑完第一次就会终止。

![循环结构](https://github.com/greatghoul/greatghoul.github.io/assets/208966/4221c5c1-271c-4a36-953b-efdb7c02fa8c)

看一下结果，运行符合预期。

![测试循环功能](https://github.com/greatghoul/greatghoul.github.io/assets/208966/0ef84fb7-f414-405e-b1d0-be9142c127ad)

既然如此，就把它套用到记账脚本里面吧。

![记账应用循环](https://github.com/greatghoul/greatghoul.github.io/assets/208966/fa363417-26e1-4129-88e2-d53ab810d31b)

变成循环后，需要把之前处理 `text` 变量的 Block 换成处理循环的值 `row`, 这样让循环每一行时可以按照原来的逻辑进行处理。

运行一下看看。

![记账循环效果](https://github.com/greatghoul/greatghoul.github.io/assets/208966/f7560ec5-f28f-4310-8131-79164fe64426)

结果符合预期。

![记账结果](https://github.com/greatghoul/greatghoul.github.io/assets/208966/ba7fcfe5-7511-4cc2-b101-3e62b52eb38e)

这样以后记账就更方便啦。

## 下一步

不知道你有没有注意到，在上面的记账脚本运行中，第一次弹出记账成功后过了一小段段时间，又弹出一次记账成功？

![记账成功](https://github.com/greatghoul/greatghoul.github.io/assets/208966/8b635280-28cc-4f8f-846c-a6338fdccd66)

这是因为我使用的 For Each Block，它会逐个处理每一条，测试中，我输入了两行文本，那么它会跑两次，如果输入五行，那么它就会跑五次，而且是上一条执行完，才会执行下一条。它的执行是串的，虽然最终会运行完，但是太慢了。

下一步，我打算然它并行处理，以加快速度。

还有一点就是，我的循环没有处理意外情况，比如多输入了一个空行，那么脚本可能就会出错。自用的话，这个暂时可以不用处理，不过有机会的话，还是会修理修理的。
