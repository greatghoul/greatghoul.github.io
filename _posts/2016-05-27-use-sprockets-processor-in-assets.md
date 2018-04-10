---
title: 使用 Sprockets Processor 剔除 CSS 中的 Google Font
date: 2016-05-27 00:44 CST
tags: rails
---

使用 Rails 做 Web 应用时，基本上都会遇到使用第三方前端组件的情况，相比于自己手动 Copy 组件的文件到 Assets 中，使用一些别人封装好的 Gem，或者借助 [bower-rails](https://github.com/rharriso/bower-rails) 等工具，可以更省心的管理这些依赖文件。

一些组件的 CSS 中可能通过一些 CDN @import 引入一些依赖，比如 [Google Fonts](https://www.google.com/fonts)。这对开发者来说，本来是件极便利的事，但因为一些众所周知的原因，一些通过 URL 引入的样式文件无法访问或者访问很慢，而样式一般是在网页头部引入，这导致整个网页加载异常缓慢，因为无法访问的样式表请求一直 Block 在那里，直到出错或者加载完成。

    @import url('https://fonts.googleapis.com/css?family=Open+Sans');

以前我的做法是 Fork 组件的代码，从中去除这些影响访问的资源引入，然后通过 GIT 地址引入到项目中，但这样做非常不优雅：

- 一个项目用的第三方组件可能很多，一个个 Fork 很费事
- 通过 Git 引入的依赖在安装时一般很慢，这一定程度上影响了部署的速度
- 不能及时更新组件的新版本

怎么办呢？在查阅了 Sprockets 的资料后，发现有个叫 [Processor](https://github.com/rails/sprockets#processor-interface) 的东西，似乎能派上用场。Processor 的 `call` 方法可以返回一个包含 `:data` 的  Hash，用于传递处理过的 Asset 内容到下一个 Processor。

    def self.call(input)
      input[:cache].fetch("my:cache:key:v1") do
        # Remove all semicolons from source
        input[:data].gsub(";", "")
      end
    end

**注：**直接返回字符串相当于返回 `{ data: str }`

**这下有得玩了！**

    class ChinaSprocketsProcessor
      GOOGLE_FONT_PAT = /@import\s+url\(.*?googleapis.*?\);?/
      BOOTCDN_PAT = /@import\s+url\(.*?bootstrapcdn.*?\);?/

      def self.call(input)
        data = input[:data].gsub(GOOGLE_FONT_PAT, '').gsub(BOOTCDN_PAT, '')

        { data: data }
      end
    end

    Sprockets.register_postprocessor 'text/css', ChinaSprocketsProcessor

将这段代码添加到 `config/initializers/assets.rb` 中，这样 CSS 文件中 googleapis 的引用和 bootstrapcdn 的引用都会被干掉了，即不用自己修改组件的代码，还符合了国情，真是太好了👏🏻。


