---
layout: post
title: VIM中移动选中内容到备份文件
slug: move-selection-into-bak-file-in-vim
date: 2012-02-07 00:30
tags: [gtd, vim]
---

在公司跟踪自己的工作计划时，我使用的 gtd 工具是 vim 的插件 [taskpaper][1]，不过当任务比较多的时候，想要把已经完成的
任务备份起来，于是选择需要备份的条目剪切到新的文件中，但每次这样实在是太麻烦了，那就让代码来帮忙吧。

在 `.vimrc` 中添加内容如下：

    com! -nargs=1 -range Sbak call MoveSelectedLinesToFile(<f-args>)
    fun! MoveSelectedLinesToFile(filename)
        exec "'<,'>w! >>" . a:filename
        norm gvd
    endfunc
    vmap <F2> :Sbak %:t.bak<CR>

当你在选择了文本后，只要按下 `<F2>` 键，便可以将选中的内容移动到 `<当前文件名>.bak` 文件的末尾，方便吧。

不过为了便于查看，最好能够将选中文本移动到备份文件的开头，不知道这里该怎么写。

[1]: http://www.vim.org/scripts/script.php?script_id=2027
