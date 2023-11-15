---
slug: 68-windows-git-push-error-solution
date: '2011-05-19'
layout: post
title: windows下git push报Permission denied的解决方案
tags:
  - Windows
  - Git
issue: 68
---

在 windows 下按照[教程][1]安装好 git 后准备后准备 push 代码，结果报错了。

    E:\Workspaces\hta\iReader&gt;git push origin master
    Permission denied (publickey).
    fatal: The remote end hung up unexpectedly

百般折腾，终于发现，只要在 git 附带的 bash （Git Bash 可以在开始菜单的 git 目标里面找到）里面运行命令，就可以一切正常。

    $ ssh git@github.com
    The authenticity of host 'github.com (207.97.227.239)' can't be established.
    RSA key fingerprint is 16:27:ac:a5:76:28:2d:36:63:1b:56:4d:eb:df:a6:48.
    Are you sure you want to continue connecting (yes/no)? yes
    Warning: Permanently added 'github.com,207.97.227.239' (RSA) to the list of kno
    n hosts.
    Hi greatghoul! You've successfully authenticated, but GitHub does not provide s
    ell access.
    Connection to github.com closed.

不过还是感觉不方便呀。。。。

[1]: http://help.github.com/win-set-up-git/
