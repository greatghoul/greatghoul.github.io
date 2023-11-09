---
slug: 45-recover-after-override-and-update
date: '2010-12-29'
layout: post
title: 恢复 MyEclipse 中被 Override and Update 后的代码
tags:
  - Java
  - Tool
issue: 45
---

今天做了件相当愚蠢的事，把一个新的功能（之前未提交过代码）写完后准备在 MyEclipse 中提交代码，平常提前前都习惯性的
先比较差异，怎知今天竟鬼使神差的把未提交的代码用给 **Override and Update** 了，执行完这一动作后，我立刻意识到杯具了，
随即把那个还没有关闭的窗口赶紧 `Ctrl+Z` 了，内容回来了，不过剩下的没有打开文件就丢失了，`.java` 文件直接被删除，
`.class` 文件也被自动布署的机制给干掉了，一切都干净了，想找到 `.class` 文件反编译都不行。

Google 寻找恢复方案，未果（可能是因为太着急了，没有用心搜索吧），打电话求助朋友，也得到无法恢复的答案，
看来只能凭记忆还比较鲜活，赶紧重新写一次了。重新新建 Class，打开编辑器，刚开始敲代码，又有点不甘心，
于是在该文件上右键，在 **Team** 中看到了 **Show History** 选项，于是抱着试一试的态度按下了左键，结果奇迹出来了，
修改历史出来了。

![编辑器历史](https://github.com/greatghoul/greatghoul.github.io/assets/208966/498bacf4-a34f-4ebf-a24a-9dd0e9bffc36)

这个编辑历史显然是本地的，如果你不慎删除了还没有加入到 CVS 中的代码，只要在相同路径建立同名文件，然后利用 **Team** 
中的 **Show History** 工具，就可以找回丢失的代码了。

