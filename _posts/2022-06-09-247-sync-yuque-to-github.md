---
slug: 247-sync-yuque-to-github
date: '2022-06-09'
layout: post
title: 同步语雀云知识库《远程工作者》到 Github 仓库
tags:
  - Github
  - Ruby
  - Remote Working
issue: 247
---

2013 年，那是一个夏天，有一位[日常通勤四小时](https://anl.gg/ride-to-company)程序员，深深被远程工作震撼。

## 远程工作者资源列表的由来

在一个活动上面，看到 Andy 分享的远程工作主题，当时激动的心情，近十年过去了，仍然恍如昨日。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/c9154ae4-2c86-4d65-ad33-e42fad7ba93a)

https://speakerdeck.com/yorzi/yuan-cheng-gong-zuo-na-xie-shi-er

我当时决定要向 Andy 学习，争取以后远程工作。远程对我来说，是一个全新的领域，我急切的想要了解它，于是我建立了一个 Github 仓库 [greatghoul/remote-working](https://github.com/greatghoul/remote-working) 并提交了第一个 commit

https://github.com/greatghoul/remote-working/commit/c862266f705c399349a9432cd9ef2df2ac27ebe9

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/998f441c-3e8f-4526-8516-2ea12de14585)

随后的几年间，我隔三差五的往里面添加新找到的远程工作相关的文章和其它资源，因为坚持去接近远程工作的群体，自己在不久后也追随着 Andy 的步伐，辞掉了坐班的工作，[开始全职远程工作](https://anl.gg/eleduck-interview-working-remotely-for-8-years)了。

随着国内远程工作越来越火热，列表也收获了不少的 Star，作为一个程序员，Star 最多的项目却是一个 README，说来惭愧，但是这个列表帮到了我自己，也帮到了一些想要远程的朋友，我心里还是很欢喜的。

## 从 Github 到语雀云

这个列表主要是我自己在维护，但是每次编辑都要打开编辑器，修改后再 git commit, 非常麻烦，所以 2021 年，我归档了 Github 仓库，将列表迁移到[语雀云知识库](https://anl.gg/remote)进行更新，编辑变得方便后，更新起来自然更佳惬意。而且语雀的内容在微信中分享非常方便，而且国内用户打开也很快，不像 Github，如果上网方法不够科学，甚至加载不出来。语雀上评论文档也非常方便，迁移到语雀后，我收到了不少反馈，这些对持续更新都有非常好的促进作用。

列表的更新是一个长期的事情，我一点一点在积累和改进，比如远程团队的改进，[回顾了一下这些年的远程团队 | 电鸭](https://eleduck.com/posts/Gzf7Zo)。我最近还在更新文章列表，解决一些坏链，并且给文章都写上简介，方便读者挑选阅读。这些文章虽然时过境迁，但是很多仍然有很大的参考价值，值得反复阅读。逐个写简介是一件非常耗费精力的事情，但是我乐在其中，更新列表是我的日常，我没想着一两天就能把所有内容都更新好，只要坚持就好了，毕竟我从 2013 年坚持到了现在。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/7be26c7f-ebed-4b4b-945b-65000e1b84aa)

我的日常 Todo List 中，有专门的记录提醒自己整理资源，虽然不是每天都能坚持，但是能够长期去维护它，这个提醒作用还是蛮大的。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/e3289adb-8587-4f28-8ae8-1936f87db584)

## 同步语雀内容到 Github

语雀也有自己的缺点，比如 SEO 效果似乎并没有想象中的那么好，程序员群体对它也不怎么感冒。我个人比较偏爱所见即所得的编辑器，所以挺喜欢语雀这边的编辑体验，也准备以后继续在这边更新，但是也希望自己辛苦整理的内容可以触达到更多的人，如果能因此交到更多喜欢远程工作的朋友，那自然最好了。所以我一直想要做一个自动化的工具把语雀云的内容自动同步到 Github 来，这样只需要在一边更新就可以了。想法由来已久，但是实施是最近才开始的。

[语雀是支持 Webhook 的](https://www.yuque.com/yuque/developer/doc-webhook)，这让同步变成了可能。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/55160824-43af-451c-98a9-43c5d82f5a88)

我写了一个简单的服务用于接收语雀的内容更新推送，然后根据更新的内容，利用 Github API 写入内容到对应的文件中。

```ruby
class RemoteWorking::SyncsController < ApplicationController
  skip_before_action :verify_authenticity_token

  REPO = "greatghoul/remote-working".freeze
  WATCH_LIST = %w[
    about issues posts videos podcasts reports  
    books guides tools sites teams others 
  ]
  
  def create
    data = params.dig(:sync, :data)
    if data[:webhook_subject_type] == "update" and WATCH_LIST.include?(data[:slug])
      publish_document(
        file: slug_to_file(data[:slug]),
        commit: "更新《#{data[:title]}》",
        content: "# #{data[:title]}\n\n#{data[:body_draft]}"
      )
    end
  
    render json: { success: true }
  end

  private

  def publish_document(file:, commit:, content:)
    logger.info "Updating file #{file}"
    client = Octokit::Client.new(access_token: ENV["GITHUB_TOKEN_REMOTE_WORKING"])
    sha = client.contents(REPO, path: file).sha rescue nil
    resp = client.update_contents(REPO, file, commit, sha, content)
    logger.info "success to update #{file}, #{resp.message}"
  rescue => e
    logger.error "failed to publish #{file}, #{e.inspect}"
  end

  def slug_to_file(slug)
    if slug == "about"
      "README.md"
    else
      "#{slug}/README.md"
    end
  end
end
```

语雀的推送中竟然[包含文档内容 Markdown 源码](https://jsoneditoronline.org/#left=cloud.bc75e0b20f3943baa2fd55117df9144a&right=local.namila)，明明是一个富文本编辑器。简直是贴心他妈给贴心开门，贴心到家了，省得我自己转换了。

为了说明页面的目录链接能够自适应语雀和 Github 的 URL 结构，我给目录的链接使用了相对路径。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/1d935732-1096-4e75-9e64-e359ffeb2940)

语雀这边对应文档的内容，在 Github 中我对应为 `"#{slug}/README.md"`，很幸运，它在语雀和 Github 都工作的很好。

这个同步服务工作良好，只是有一点不足，就是没有办法在 Commit 中简单描述更新的内容，这导致 Commit 记录显得单调。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/e93597e8-d150-4b16-a1c1-4a321bf2ec1e)

期待语雀以后能支持相应的功能，比如在这里加一个输入框什么的。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/1df84681-8496-449b-b216-4a2ac659e55d)

## 欢迎推荐资源

做了同步后，我又制作了接受网友推荐的渠道，[语雀云表单](https://www.yuque.com/forms/share/c11bd87d-2187-43d6-8855-e6206e57da82)或者 [Github Issue](https://github.com/greatghoul/remote-working/issues/new?assignees=greatghoul&labels=%E8%B5%84%E6%BA%90%E6%8E%A8%E8%8D%90&template=------.md&title=%5B%E8%B5%84%E6%BA%90%E6%8E%A8%E8%8D%90%5D+) ，欢迎大家提交远程工作的资源。资源采纳后，会根据推荐者的意愿，更新他的名字到列表说明的贡献者列表里面，在两边同步。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/10e55883-8c97-4252-b0be-8ac66ea98fc7)
