---
slug: 250-build-a-ledger-app-02
date: '2022-07-31'
layout: post
title: 做一个记账应用 02 - 用 Automate 解析输入的文本
tags:
  - RegExp
  - Automation
issue: 250
---

在[上一步](https://anl.gg/post/249-build-a-ledger-app-01)中，我建立了 Notion 表格用于管理账目，并计划使用 Automate 来实现快速添加，提升记账的便捷性。

比如 “早餐 7元 买饭”，自动解析出

```erb
项目：早餐
金额： 7
类型：买饭
```

然后再用结构化的信息去调用 Notion API, 本节我准备先做解析输入的文本这一步，先拿到数据，再考虑后续的步骤。

我的主力手机是一部 Android 机，使用的自动化工具是我最喜欢的 [Automate](https://play.google.com/store/apps/details?id=com.llamalab.automate&hl=en&gl=US)，当然也有其它选择，比如 [Tasker](https://tasker.joaoapps.com/) 和 [Auto.js](https://g.pro.autojs.org/)。如果你使用的是 iOS，可以尝试一下[快捷指令](https://support.apple.com/zh-cn/guide/shortcuts/welcome/ios)，想当年，[咱也玩过快捷指令](https://sharecuts.cn/)。

Automate 是用“工作流”的形式组织自动化脚本的，优点是结构清晰，缺点吗，想要修改是非常痛苦，你得一个一个节点的挪动。期待哪天作者支持批量移动。

## 解析输入的文本

我使用 Automate 创建了一个Flow, 并加入了几个简单的步骤。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/3af60354-959f-4211-8bab-bb232a61782f)

忽略掉 "Log Append" 的命令块，那是我用于调试的，其它的命令块分别为

1. 显示一个输入框，接受用户（也就是我）输入文本
    
2. 简单的清理一下文本，移除掉标点符号和空格（讯飞会自动加入句号什么的），简化解析
    
3. 使用正则解析出项目、金额以及类型
    

### 1\. 显示输入框

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/5c52e8e8-3a43-41ec-bfd6-bf6ea90268d3)

显示一个输入框，为了方便测试，我把默认值设置为 “早餐 7元 买饭。”，省得每次调试都要手动输入内容。

这一步，我把输入的值保存在一个变量 `text` 里面，后面会用到。

### 2\. 清理文本

清理掉语音输入自动加的空格和标点等，这一步用了一个赋值命令。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/daa701f0-6a08-4036-b68a-0ab587e9b7b5)

如果用编程语言表达的活，大致类似

```erb
text = text.replaceAll(/[，。 ]/, "")
```

对于 replaceAll，可以参考[官方文档](https://llamalab.com/automate/doc/function/replace_all.html)

### 3\. 正则匹配出结果

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/4116a5c9-6516-4344-8007-e8c0bfbe9012)

这一步对清理后的文本进行解析，用到的正则很简单。

```erb
findAll(text, "^(.*)(\\d+)元?(.*)$")
```

正则表达式中的三个括号分别代表：项目、金额以及类型，这里 `元?` 是为了兼容语音输入和自己手动输入，输入时“元”字可有可无（有时候周围人太多，可能不方便用语音输入，打字就没有必要专门多打一个字了）

如果上一步没有做清理，那正则可能要变成下面这样，另外还得额外的去处理末尾句号。句号也可以用 `。?` 的方法去处理，不求完美，能工作就好。

```erb
findAll(text, "^\\s*(.*)\\s*(\\d+)\\s*元\\s*(.*)\\s*$")
```

### 运行结果

综合上面的处理，我们就可以拿到文本对应的结构化数据了。

![](https://github.com/greatghoul/greatghoul.github.io/assets/208966/4b7a2519-e4ed-4467-840b-42c373fff11b)

```erb
07-31 15:29:23.722 I 32366@1: Flow beginning
07-31 15:29:23.722 I 32366@2: Dialog input?
07-31 15:29:25.423 I 32366@5: Variable set
07-31 15:29:25.425 U 32366@4: 早餐7元买饭
07-31 15:29:25.425 I 32366@3: Variable set
07-31 15:29:25.427 U 32366@6: 早餐7元买饭, 早餐, 7, 买饭
07-31 15:29:25.429 I 32366@0: Stopped at end
```

最后得到的匹配结果是一个数组，可以用 matches\[1\] matches\[2\] matches\[3\] 分别取到正则中三个捕获组对应的内容。

### 参考资料

* [正则表达式教程](https://deerchao.cn/tutorials/regex/regex.htm#grouping)
    
* [Automate 官方文档](https://llamalab.com/automate/doc)
    

## 下一步

Notion 已经在之前的更新中开放了 API, 这使得他有了无限的可能，对于个人开发者而言，完全可以当一个数据库来使用了。

这次拿到了结构化的数据，那么接下来就是调用 Notion API 创建记录的事情了。

https://developers.notion.com/reference/post-page

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/15678eb5-5746-4bbf-9017-b3573c78fd13)
