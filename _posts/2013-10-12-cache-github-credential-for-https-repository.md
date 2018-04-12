---
layout: post
title: 记住 Github HTTPS 仓库的密码
slug: cache-github-credential-for-https-repository
date: 2013-10-12 22:55
tags: [github, git]
---

自从上次 GitHub 被[重点照顾][1]以后，使用 ssh 地址 `git@github.com:user/repo.git` 访问 GitHub 仓库时，
进度经常会卡住不动了，便日常开发都受到了严重的影响。

经常尝试后发现，使用 HTTPS 地址访问仓库时比较流畅，虽然速度不是特别理想，但是却不影响使用。但 HTTPS 每次
进行 PUSH 操作会提示输入用户名和密码，比较麻烦，为避免重复操作，需要在 gitconfig 中加入一些配置。

**对于 1.7.9 及之后的版本**

	git config --global credential.helper cache

如何希望加上失效时间，可以这样配置

	git config credential.helper 'cache --timeout=3600'

就可以记住密码一个小时。

**对于 1.7.9 之前的版本**

需要显式的 git 地址中加入用户名和密码，如 https://you:password@github.com/you/example.git

	git config remote.origin.url https://you:password@github.com/you/example.git

## 参考资料：

 - [Is there a way to skip password typing when using https:// github][r1]
 - [gitcredentials(7) Manual Page][r2]

[1]: http://www.williamlong.info/archives/3351.html
[r1]: https://www.kernel.org/pub/software/scm/git/docs/gitcredentials.html
[r2]: https://www.kernel.org/pub/software/scm/git/docs/gitcredentials.html
