---
slug: 42-delete-without-confirm-in-windows
date: '2010-12-10'
layout: post
title: Windows下设置删除文件不显示提示框
tags:
  - Windows
issue: 42
---

帮女朋友整理文献，她把文献都存在 Gmail 的草稿箱里面，我每整理出来一篇，就 Discard Draft 了，
后来我整理U盘时不小心将整理的文献都删掉了（之前设置了删除文件时不显示确认对话框），而且没有经过回收站，
虽然尝试过数据恢复，但可耻的失败了，后来的事，你懂的。

顺便说下 Windows XP 下设置删除文件不显示确认框的方法：

打开 **回收站** 的 **属性** 对话框，取消 **显示删除确认对话框** 后点击确定。

![回收站属性设置](https://github.com/greatghoul/greatghoul.github.io/assets/208966/4343a19f-9690-4e8f-915d-e0a35f3c13c6)

如果该项为灰色不可用，则先执行以下操作：

 1. 开始 &gt; 运行 &gt; 输入 `gpedit.msc` 打开 **组策略**
 2. 依次展开 用户配置 &gt; 管理模板 &gt; Windows组件 &gt; Windows资源管理器
 3. 在右侧列表中 **禁用** 掉 **不要将已删除的文件移至回收站** 和 **删除文件时显示确认对话框**

![Windows删除文件](https://github.com/greatghoul/greatghoul.github.io/assets/208966/a370fa84-b102-47b0-b95b-dc18a03ffb6a)

**不要将已删除的文件移至回收站** 最好禁用掉，万一悲剧一下，得不偿失呀，如果想直接删除，可以按住 `Shift` 键再删除。
