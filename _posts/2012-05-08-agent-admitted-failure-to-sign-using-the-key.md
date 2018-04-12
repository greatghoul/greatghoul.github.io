---
layout: post
title: 变更ssh key后git连接失败
slug: agent-admitted-failure-to-sign-using-the-key
date: 2012-05-08 01:28
tags: [git, ssh]
---

变更了 ssh key 后，git clone 无法使用，提示信息如下：

    Agent admitted failure to sign using the key.
    Permission denied (publickey).

起初以为是在 github 上填写key值时写错了，重新试了一次依然如此

不过很快 google 到了方法

**方法1：**

注销再登陆系统即可

**方法2：**

在终端下执行命令 `ssh-add`

然后尽情的 git 吧

    $ ssh -T git@github.com
    Hi greatghoul! You've successfully authenticated, but GitHub does not provide shell access.

