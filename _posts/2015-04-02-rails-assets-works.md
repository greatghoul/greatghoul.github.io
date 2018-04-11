---
layout: post
title: 用 Rails Assets 管理前端组件
date: 2015-04-02 20:48 CST
tags:
  - rails
  - bower
cover: http://greatghoul.b0.upaiyun.com/1504/t3r7kT6B5zzV.png
---

做 Rails 开发的都不陌生 Asset Pipline，在《[Rails Assets Pipeline 的价值][1]》
这篇讨论中有详细讲到。

如果使用 Asset Pipline，在 Rails 中引入一个第三方的前端组件时，通常有两种方式：

- 将第三库的脚本拷备到应用中，通过 Asset Pipline 引入
- 安装有些开发者封装好的前端组件的 Ruby Gems

前者很费力，你需要将组件按 Rails Asset Pipline 组织脚本的方式来拆开组件的脚本，
然后分别引入，甚至要修改一些脚本中的引用。

后者虽然省力，但 JavaScript 和 CSS 的组件实在太多，Gem 的作者不可能完全跟上版本。

这个时候，我就特别羡慕那些使用 bower 的家伙，当然，[Rails 也能使用 Bower][2]，
但我更喜欢 Asset Pipline 的方式。

有一天，我在 Ruby China 发现有人推荐了一个叫 [Rails Assets][3] 的工具，
它可以**把 Bower 的组件转换成 Ruby Gem** 供你使用，而且可以和 Bower 
组件的版本保持一致 ，我眼前一亮，就是它了！

![](http://greatghoul.b0.upaiyun.com/1504/t3r7kT6B5zzV.png)

## 使用 Rails Assets

在 Gemfile 中加入下面的代码：

    gem 'bundler', '>= 1.8.4'

    source 'https://rails-assets.org' do
      gem 'rails-assets-bootstrap'
      gem 'rails-assets-angular'
      gem 'rails-assets-leaflet'
    end

**注意：**目前 Rails Assets 需要 bundler 至少是 `1.8.4`。

注意到那些以 `rails-assets-` 开头的 Gem 了吗，它就是通往 Bower Components 
的传送门呀。

当你执行 `bundle install` 时，Rails Assets 帮你做下这些事。

1. 下载对应的 Bower 组件。
2. 分析组件的清单 bower.json
3. 将组件中的脚本打包成 Ruby Gem 的格式，安装到你的应用中

它甚至会自动安装对应的依赖组件。

然后你就可以像平时使用 Asset Pipline 一样通过 `require xxx` 来引入脚本了。

## 寻找组件

在 <https://rails-assets.org/> 的网站上，你可以通过关键字搜索都要的组件，
搜索结果会告诉你，要使用一个组件，你要如何引入 Gem，如果引入脚本，
像下图这样。

![](http://greatghoul.b0.upaiyun.com/1504/5IwXB4FBq6x1.png)

如果搜索结果中找不到，你还可以[手动添加][4]

## 一些取舍

Rails Assets 毕竟是自动转换的，有时候会存在一些问题，
这时候还是换回传统的方式比较好。

比如 `rails-assets-bootstrap-sass` 这个组件，在 `app/assets/stylesheets/` 
的子文件夹中的脚本中使用时，字体可能加载不到，但换成 `bootstrap-sass` 就 OK。

还有比如 `font-awesome` 使用普通的 Ruby Gem，可以有 `fa_icon('home')` 这样
方便的 helper 方法用，使用时，可以按自己的需求取舍。


[1]: https://ruby-china.org/topics/9664
[2]: https://github.com/rharriso/bower-rails
[3]: https://rails-assets.org/
[4]: https://rails-assets.org/components/new



