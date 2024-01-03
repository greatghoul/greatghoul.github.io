---
slug: 226-github-action-checkout-token
date: '2020-09-14'
layout: post
title: Github Action Checkout 私有库时使用 token 的奇葩问题
tags:
  - Github
issue: 226
---

**这个问题，后面又试了几次，有神奇的不存在了。**

---

在配置 github action 检出非当前库的私有库时，需要配置一个 github personal access token，但是我按照[官方文档](https://github.com/marketplace/actions/checkout#checkout-multiple-repos-private)的配置，并没有成功的运行

```erb
- name: Checking out ror
  uses: actions/checkout@v2
  with:
    repository: foo/bar
    ref: master
    token: ***
    path: bar
```

而是给出了如下的错误

```erb
[error]Input required and not supplied: token
```

后来在这个 [issue](https://github.com/actions/create-release/issues/36) 中看到可以使用 ENV 的写法

```erb
env:
  GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

但是尝试后，依然不能检出私有库，问题到底出在哪里呢？  
打算再改回 token 的形式试一试，这次无意间把 token 参数放在第一个，神奇般的就通过了。

```erb
- name: Checking out ror
  uses: actions/checkout@v2
  with:
    token: ***
    repository: foo/bar
    ref: master
    path: bar
```

**太奇葩了。**
