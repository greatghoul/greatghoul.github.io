---
slug: 238-github-issues-as-blog
date: '2021-08-21'
layout: post
title: 使用 Github Issues 写独立博客
tags:
  - Github
issue: 238
---

### 01 又迁移博客了

我之前使[用过 issues 写博客一段时间](https://github.com/greatghoul/profile/issues?page=1&q=is%3Aissue+is%3Aclosed)，那是一个 public 的 github repo, 借助于 github 的 markdown 编辑器，写作编程了一件很有趣的事情，也着实写了一些文章。不过因为 issues 本身的限制，我没有一个独立的域名，因为受到一个独立博客群组的“荼毒”，我有购买了域名，搞起了独立博客的勾当。

自己用 Ruby on Rails 写了个博客程序，使用 Basecamp 的 Trix Editor 作为编辑器，虽然程序搭建起来了，也运行良好，但是我发现自己没有那么多时间去定制那个编辑器来实现一些想要的功能。而且托管一个 rails 应用，好歹也需要一个 vps, 得花钱呀。我使用的 AWS，这东西真的不便宜。

于是我一天在看 Next.js 的时候，脑袋一热，就用 Next.js 来写了一个博客程序，使用 Github Issues 作为博客的数据库，程序部署在 Vercel 上面，可以自动部署，免费，还自带 HTTPS，一切近乎完美，因为在开发电鸭社区网站时得到的锻炼，整个过程也就花了四五个小时。 

### 03 优点和缺点

目前我的这个方案：使用私有 Github Issues 作为博客，使用 Vercel 托管博客程序，优点还是很明显的

* Github 自带的 Markdown 编辑器
* 自带标签机制
* 方便的图片上传和免费的 CDN
* 有现成 API 可以用，并且支持分页，无需额外的服务端
* 因为是私有库，Issues 不会被恶意污染
* 自动部署，push 后就自动更新
* 免费的 HTTPS
* 免费的托管服务

缺点也肯定有，但是不致命

* Github Personal Token 每小时只有 5000 次请求的限额，不过对于个人博客而言，够用了
* 成也萧何，败也萧何，无法借助 Github Issue Comments 作为评论系统
* 没有办法手动描述发布时间，只能依赖 Issue 创建时间，或者自己解析 YAML Front Matter（不准确）
* 不能按照日期归档

### 04 实现原理

要运行这个博客，你需要

* Github 私有库 - 用于托管博客程序代码以及博客文章（Issues)https://vercel.com/
* [Vercel](https://vercel.com/) - 用于免费部署和托管博客程序（我使用的是 Next.js）
* 一个独立域名（非必须）

博客是一个简单的 [Next.js](https://nextjs.org/) 项目，直接调用 [Github API](https://docs.github.com/en/rest/reference/issues)，然后进行服务端渲染，一气呵成。因为 Github API 匿名调用的话，限额非常低，所以最好申请一个 [Personal Access Token](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token)，差不多就够用了。

为了安全性，Token 可以维护到 Vercel 环境变量中，并使用加密类型存储

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/12281a17-9204-47b9-b3a5-9838bcc9a495)

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/cd34c6f1-e2b4-4ad4-966f-81c0f179c2fa)

我的 Next.js 程序中，使用到了如下的 JavaScript 库，用于

* @octokit/rest - 访问 Github API
* front-matter - 用于解析 Issue 中的 YAML Front Matter
* makred - 用于将 markdown 转换为 html 代码
* truncate-html - 用于从 html 解析出文章摘要

我给 Issues 设置了一个保留标签 "0_Published"，用于标识文章是否已经发布了，用 YAML Front Matter 来解决 Issues 创建时间和真实发布时间不一致的情况。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/d570ac81-ffe7-4251-baca-bb975482f15a)

给便签加前缀 "0_" 是为了让它始终保持在第一个，方便选择。

下面一段代码，是读取和把 Issue 处理为文章数据的结构的代码，仅供参考，你可以根据自己的需求，定制自己的代码。

```js
// utils/github.js

import { Octokit } from '@octokit/rest'
import frontMatter from 'front-matter'
import marked from 'marked'
import truncate from 'truncate-html'

const LABEL_PUBLISHED = '0_Published'
const octokit = new Octokit({ auth: process.env.GITHUB_TOKEN })
const repo = {
  owner: process.env.GITHUB_OWNER,
  repo:  process.env.GITHUB_REPO
}

function issueToPost (issue) {
  const { attributes, body } = frontMatter(issue.body)
  const content = marked(body)
  const attrs = JSON.parse(JSON.stringify(attributes))

  return {
    id: issue.number,
    title: issue.title,
    author: issue.user,
    labels: issue.labels.filter(x => x.name !== LABEL_PUBLISHED),
    published: issue.labels.filter(x => x.name === LABEL_PUBLISHED).length > 0,
    published_at: attrs.date || issue.created_at,
    attrs: attrs,
    content: content,
    brief: truncate(content, {
      length: 250,
      stripTags: true,
      excludes: ['img', 'pre']
    })
  }
}

export async function getRecentPosts (page) {
  return octokit.rest.issues.listForRepo({
    ...repo,
    labels: LABEL_PUBLISHED,
    sort: 'created',
    direction: 'desc',
    per_page: 10,
    page: page
  }).then(resp => resp.data.map(issueToPost))
}

export async function getPost (id) {
  return octokit.rest.issues.get({
    ...repo,
    issue_number: id
  }).then(resp => issueToPost(resp.data))
}
```

### 05 Vercel

Vercel 是一个非常良心的服务，可以让你免费的部署和托管前端应用，甚至贴心的配备了 https，省了很多很多事情，每次要更新应用时，你只需要 push 代码就可以了，不需要考虑维护 node 环境，build，nginx 等等烦恼的事情。

以前因为对前端不熟悉，部署 js 应用还要用 [capstrano](https://anl.gg/posts/3) 这样的大家伙，现在好了，一切都是自动化了。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/19a7a307-0a5f-44db-905d-3828bd09846a)

Vercel 虽然比较妙，但是也带来了一些副作用，你必须把域名 nameserver 迁到 vercel 上面来，这就导致这个域名几乎只能用来跑 vercel 的服务了，因为 vercel 的 DNS 管理，是一个非常简化的版本，像 URL Redirect 这样的操作，都是不支持的，就连 A 记录到指定 IP，也有问题。但好处是，有自动的 HTTPS 了，不需要再去维护证书。
