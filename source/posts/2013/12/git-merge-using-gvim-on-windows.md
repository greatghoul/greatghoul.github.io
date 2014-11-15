---
title: Windows 下使用 gvimdiff 合并 git 冲突
slug: git-merge-using-gvim-on-windows
tags: [windows, git, gvim]
date: 2013-12-10 22:17
published: false
---

## 工具配置 

假定 git 安装在 `D:\Git` 文件夹下

1. 复制 D:\Git\bin\vim 为 gvim，内容如下

    #!/bin/sh

    exec /D/Vim/vim74/gvim "$@"

2. 修改 D:/Git/etc/gitconfig 加入如下配置

    [merge]
        tool = gvimdiff

## 合并操作

运行 `git mergetool`

其它一些操作

## 参考资料

 * [vimdiff 使用技巧](http://www.pythonclub.org/vim/vimdiff-usage)
 * [vimdiff 常用命令](http://www.cnblogs.com/xuxm2007/archive/2010/10/22/1858139.html)

