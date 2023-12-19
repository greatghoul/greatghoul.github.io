---
slug: 206-rails-favicon-setup
date: '2018-06-10'
layout: post
title: Rails 项目的网站图标多平台适配
tags:
  - Ruby on Rails
issue: 206
---

平时很少看日志，最近给网站上了 [Sentry](https://sentry.io/) 服务用于异常监测，结果发现一个频率很高的异常。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/44d66730-f6ac-4958-a2d1-1b72b0b9aec8)

原来是网站图标没有做多平台的适配，那么都需要适配哪些平台呢？各个平台的标准又是什么样的？作为一个懒人，当然是去找现成的工具了。

**隆重介绍** [Real Favicon Generator](https://realfavicongenerator.net/)

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/1bd2cffc-683c-4f6a-8ff0-a502e52057c3)

使用这个在线服务上传网站的高清图标（推荐大于 260x260），然后它会让你调整你的图标在不同的平台上的样式，比如替换背景颜色，添加阴影，图标缩放方式之类的。这些调整都有预览，非常方便。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/bf643d01-14da-43e2-b6fe-f7ddeb1ee20f)

我们是 Rails 项目，推荐直接使用 [Favicon Generator for Ruby on Rails](https://realfavicongenerator.net/favicon/ruby_on_rails)。

如果你使用的普通静态 HTML 的生成器，完成调整配置后，它会给你一个压缩包，里面包含所需的所有文件，但 ROR 的生成器稍有不同，它会给你一个配置文件，然后配合它的 gem 包，直接在本地生成所需要的文件。

```ruby
# Gemfile
group :development do
  gem 'rails_real_favicon'
end
```

不要忘记 `bundle install`，然后准备好配置文件。

```erb
# config/favicon.json
{
    "master_picture": "app/assets/images/master_icon.png",
    "favicon_design": {
        "ios": {
            "picture_aspect": "background_and_margin",
            "background_color": "#ffffff",
            "margin": "14%",
            "assets": {
                "ios6_and_prior_icons": false,
                "ios7_and_later_icons": false,
                "precomposed_icons": false,
                "declare_only_default_icon": true
            },
            "app_name": "\u4e00\u65e9\u4e00\u665a"
        },
       ......
}
```

其中 `app/assets/images/master_icon.png` 为高清图标所在的路径，准备好一切后，执行下面的命令生成图标适配所需要的文件。

```bash
rails generate favicon
```

它根据你的配置，帮你生成下面的一堆文件，有缩放的图标、各平台的应用描述文件以及所需的 partial 文件等。

```erb
app/assets/images/favicon/favicon-16x16.png
app/assets/images/favicon/browserconfig.xml.erb
app/assets/images/favicon/html_code.html
app/assets/images/favicon/android-chrome-256x256.png
app/assets/images/favicon/README.md
app/assets/images/favicon/android-chrome-192x192.png
app/assets/images/favicon/mstile-150x150.png
app/assets/images/favicon/favicon-32x32.png
app/assets/images/favicon/site.webmanifest.erb
app/assets/images/favicon/safari-pinned-tab.svg
app/assets/images/favicon/apple-touch-icon.png
app/assets/images/favicon/favicon.ico
app/views/application/_favicon.html.erb
config/initializers/web_app_manifest.rb
```

到这里，我们只需要将 `app/views/application/_favicon.html.erb` 引入我们的 layout 模板中就可以了。

```erb
<head>
  ...
  <%= render 'application/favicon' %>
  ...
</head>
```

日后如果想更换图标，只需要更新高清图标 `app/assets/images/master_icon.png` 然后重新执行一次命令就好了。
