---
slug: 243-migrate-github-issues-to-hashnode
date: '2022-01-20'
layout: post
title: 迁移 Github Issues 博客到 Hashnode
tags:
  - Github
  - Ruby
  - Blog
issue: 243
---

受到数字游民部落[这篇文章](https://jarodise.com/the-best-free-blogging-platform-in-2021-with-free-custom-domain-hashnode)的影响，我也把播客迁移到 Hashnode 了，最看重的还是自动备份以及免费绑定顶级域名，还自动配置 SSL。

[之前的博客](https://anl.gg/post/238-github-issues-as-blog)是写在 Github 私有库的 Issues 里面的，算作是博客的数据库，前端是一个简单的 nextjs 程序，用 vercel 托管的。虽然也能用，但是没有 Hashnode 这么方便，比如旧文章没法设置准确的发布日期，只能用 YAML Front Matter 来 hack，最终还是决定迁移了。

开始先是手动迁移了二十几篇（我其实还是挺喜欢手动迁移的），无奈最近太忙，没有多少空闲享受这份回顾旧文章的安逸，索性就自动导入吧。Hashnode 支持 Markdown 文件导入，就很方便了，自己写个脚本，把 Issues 到处成 markdown 文件，再搭配上 Hashnode 所需要的 Front Matter 格式。打个 zip 上传，就可以静静等待导入完成了。等待的过程，顺便记录下这篇文章。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/acfc1a87-93e0-43bc-87b1-396994aca525)

下面是我导出 issues 所用到的 Ruby 脚本。

https://replit.com/@greatghoul/export-github-issues

如果你也有类似的需求，可以 fork 后简单修改下，需要配置一个自己的 Github Token.

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/3ef8dc45-cb94-4880-9c7a-caba9d334227)

个人建议在导入前，先批量修改一下 Slug.

---

参考链接

- [Github API -  List repository issues](https://docs.github.com/en/rest/reference/issues#list-repository-issues)
- [Creating a personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)
- [Parse link headers from Github API in Ruby](https://gist.github.com/thesowah/0ca5e1b4b3c61bfe8e13
)




