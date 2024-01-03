---
slug: 227-vscode-rspec-outline
date: '2021-04-09'
layout: post
title: VS Code 中土法查看 RSpec 测试用例标题大纲
tags:
  - RSpec
  - VS Code
issue: 227
---

使用 vscode 来开发 Ruby 程序的朋友可能也和我有类似的烦恼，就是 vscode 没有一个能够解析出 rspec 测试用例大纲的扩展。

## 问题

可以正常拿到普通 ruby 文件 symbols

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/6bd1e3d2-ab64-4b61-b1e7-5e8cf8f29259)

但是 rspec 文件的 symbol 无法识别

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/01546bee-c745-4d6b-864f-eb732350c49b)

## 解法

我有试过一些 rspec 的扩展，但是都无法达到预期的效果，又不像自己花时间写一个扩展，所以研究了一种通过正则搜索文件的解决方法。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/3ff55c7d-c6c5-4c32-aecd-a305624752a2)

使用正则匹配的方式搜索当前文件，关键字设置为

```erb
^\s*(describe|context|it)\s('|")
```

点击搜索结果，就可以在各个测试用例之间来回跳转

## 一些 Tips

> 觉得搜索时每次选择当前文件比较麻烦？

可以试试 Search in Current File 这个扩展

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/597d2191-3fe8-4c4a-a26f-d18ee06662ce)

> 每次输入一大堆关键字比较麻烦？

可以借助 Text Expander 类的工具，Windows 下推荐 [Beeftext](https://beeftext.org/), macOS 下面我之前用的 [Dash](https://kapeli.com/dash). 可以快速通过关键字或者快捷浏览输入复杂文字。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/40ba6784-1fca-4bf5-a409-a5c84d6b598d)

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/17dabb22-1deb-4b92-9ff7-bad27742b1e2)
