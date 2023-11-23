---
slug: 119-vim-exception-e73-tag-stack-empty
date: '2012-05-08'
layout: post
title: vim 错误 E73 tag stack empty
tags:
  - Vim
issue: 119
---

更新了 `.vimrc` 文件后，启动 gvim 倒没有什么，但每次在终端下启动 vim 或者 `git commit` 时，
都会报一个错误 `E73: tag stack empty`

google 也没有找到解决方法，于是只能一行一行的禁用 `.vimrc` 设置，终于找到了出错的地方。

    " jump out of the tag stack (undo Ctrl-])
    map <C-t> <ESC>:po<CR>

这个设置导致 vim 每次启动后报错 *tag stack empty*，并且直接进入了插入模式，非常不方便。

想要修正这个错误，又想保留这个功能，可以这样配置

    " [[ jump out of the tag stack (undo Ctrl-])
    map [[ :po<CR>

就可以避过错误，正常使用 vim 了。
