---
slug: 114-use-gvim-in-git-bash
date: '2012-04-30'
layout: post
title: 在 git-bash 配置 gvim
tags:
  - Git
issue: 114
---

windows 平台下[安装 msysgit][1] 后，在 git-bash 看使用 gvim 编辑器，需要做一些配置。

打开 git-bash，在 `/usr/bin` 路径下建立一个 gvim 脚本

    #!/bin/sh
    exec /d/Vim/vim73/gvim.exe "$@" &

其中命令末尾的 `&` 用于在启动 gvim 后终端部阻塞，可以接着执行其他命令

`/d/Vim/vim73/gvim.exe` 表示我的 gvim 安装在 `d:/Vim/vim73/gvim.exe` 这个位置

文件保存后执行命令

    $ chmod +x /usr/bin/gvim

重启 git-bash 即可

[1]: https://anl.gg/post/113-window-git-bash
