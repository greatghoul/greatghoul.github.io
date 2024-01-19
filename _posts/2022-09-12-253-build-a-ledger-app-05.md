---
slug: 253-build-a-ledger-app-05
date: '2022-09-12'
layout: post
title: 做一个记账应用 05 - Automate 并行处理
tags:
  - Automation
issue: 253
---

在[上一节](https://anl.gg/post/252-build-a-ledger-app-04)中，我给记账的脚本加入了循环处理，得以批量记账，但脚本的执行时间会随着记录条数成倍增长。长时间的等待除了让人焦急，也容易出错，比如一条出错后，后面的都无法执行。

所以这一节，我会让批量添加的行为可以并行，大大提高效率。

Automate 支持的并行处理方式主要有两种 [Fork](https://llamalab.com/automate/doc/block/fork.html) 和 [Flow start](https://llamalab.com/automate/doc/block/flow_start.html)，前者类似与开启一个线程，后者更想函数调用。我个人更偏好后者，虽然需要额外增加一个调用函数的 Block，但是脚本的结构看起来会更加干净。

## 定义子 Flow

在原来的脚本上加入一个 Flow Begining Block，名字随意，但记得在配置中勾选下面两个选项。

* Allow parallel launches from the block - 勾选后会支持并发调用，否则同时只会有一个在 Flow 实例在运行，打不到我们并行创建记账的目的。
    
* Don't show in list of starting points - 因为是想作为内部函数来使用，不希望它作为整个 Flow 的入口
    

这里还有设置一个属性，payload = row，它表示调用这个子 Flow 的参数，在后面会讲。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/d4e33781-e3d1-48fb-9eb9-10aed56db295)

然后将之前循环里面的内容移动到这个 Flow Beginning 下面。因为 Automate 的限制，只能同时移动一个 Block，还在循环里面的 Block 不多，算不上什么大的工作量。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/1705a647-0372-4edb-9363-7853299d10eb)

这样就定义好一个**函数**了，接下来可以在别的地方调用它。

## 调用子 Flow

把原来的循环这里，替换成一个 Flow Start Block，Flow URI 为要调用的子 Flow，这里选择上面定义的那个，然后在 payload 里面填入循环中使用的变量 row，这里就对应了上面定义子 Flow 时的 Payload，不过在调用的这里纯的 payload 需要是一个已经定义过的变量，而定义那边可以随意取名字，类似函数的参数，它会移动引用到调用时传递的值。

还有一个需要注意的点， "Stop new fiber when parent stops" 要保持未勾选的状态，不然循环玩了后，主流程就结束了，它会强制杀掉子流程，即使它们还没有执行完。

![1](https://github.com/greatghoul/greatghoul.github.io/assets/208966/f76ba78e-32f5-4325-8f64-30d7bcbc6607)

至此，就改造完毕了。来看看整体的变化。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/ba2cc4e6-0e5d-4ff7-9f2f-559dd7ae199b)

## 运行结果

简单测试一下效果，可以看到，几乎同时就运行完了，虽然 toast 通知还是一个一个弹出的，但这是限于 Android 系统本身。

![2](https://github.com/greatghoul/greatghoul.github.io/assets/208966/2e89fcb8-f518-4ae9-b0b5-63cf69bae795)

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/1eaf478c-4a5c-428e-91dd-d89a627cc717)

通过日志，其实可以更加明确的感受到 “并行” 的效果。

```erb
09-12 17:27:09.122 I 41295@1: Flow beginning
09-12 17:27:09.124 I 41295@2: Dialog input?
09-12 17:27:13.231 I 41295@5: Variable set
09-12 17:27:13.234 I 41295@10: For each
09-12 17:27:13.238 I 41295@13: Flow start
09-12 17:27:13.255 I 41295@10: For each
09-12 17:27:13.257 I 41295@13: Flow start
09-12 17:27:13.267 I 41295@10: For each
09-12 17:27:13.275 I 41295@13: Flow start
09-12 17:27:13.287 I 41295@10: For each
09-12 17:27:13.288 I 41295@0: Stopped at end
09-12 17:27:13.306 I 41296@12: Flow beginning
09-12 17:27:13.310 I 41296@3: Variable set
09-12 17:27:13.314 I 41296@7: HTTP request
09-12 17:27:13.331 I 41297@12: Flow beginning
09-12 17:27:13.336 I 41297@3: Variable set
09-12 17:27:13.339 I 41297@7: HTTP request
09-12 17:27:13.354 I 41298@12: Flow beginning
09-12 17:27:13.356 I 41298@3: Variable set
09-12 17:27:13.358 I 41298@7: HTTP request
09-12 17:27:14.557 U 41298@14: 笨瓜记账成功!
09-12 17:27:14.560 I 41298@9: Toast show
09-12 17:27:14.561 I 41298@0: Stopped at end
09-12 17:27:14.900 U 41297@14: 南瓜记账成功!
09-12 17:27:14.902 I 41297@9: Toast show
09-12 17:27:14.903 I 41297@0: Stopped at end
09-12 17:27:15.114 U 41296@14: 西瓜记账成功!
09-12 17:27:15.115 I 41296@9: Toast show
09-12 17:27:15.115 I 41296@0: Stopped at end
```

## 完结了

来回顾一下[第一节](https://anl.gg/build-a-ledger-app-01)中定下的路线图。

1. 使用 Notion 制作一个记账表格，立马就可以先用起来
    
2. 使用 Automate 应用做一个手机上快速记账的脚本
    
3. 给 Notion 表格的日期自动设置默认值
    
4. 改进 Automate 脚本，一次可以记录多笔账目
    
5. 为账目表格制作月度汇总视图
    
6. 改进 Automate 脚本，如果某天没有记账，第二天早上给手机通知提醒
    

除了 5 和 6，其它的都完成了，也不算是鸽吧，我愿称之为**坎需求**，对于月度汇总，我准备以后开个新坑， 《Notion 玩儿法》什么的来进行分享，至于记账通知嘛，我有别的途径满足需求了，所以也不需要了。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/80287fcb-1e63-4778-a203-0d6d0ab2862b)

完结撒花，希望你们喜欢。

接下来，我准备开始另一个系列：写一个自用的 RSS 阅读器。目前还在构思中，敬请期待。
