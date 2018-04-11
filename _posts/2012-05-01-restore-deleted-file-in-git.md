---
layout: post
title: 恢复 git 中误删的文件
slug: restore-deleted-file-in-git
date: 2012-05-01 23:47
tags: [git]
---

今天删除项目中一个无用的文件时打错字了，结果把有用的文件给删除了，而且顺手就给提交了，杯具。

当然，既然是版本管理，那自然是可以恢复的。

比如我说我们刚刚提交的 `commit` 是 `f5810e08df0cb7cf82608d65cdb709cb430df2ea`

那么执行以下命令即可恢复删除的文件

    $ git checkout f5810e08df0cb7cf82608d65cdb709cb430df2ea path/to/file

修改后重新提交即可。
