---
layout: post
title: 用 Rails 简单的实现网站的导航路径
date: 2015-04-08 10:15 CST
tags: rails
published: false
---

开发网站后台，一个常用的场景就是要有一个导航路径，指示出当前页面的所处的版块。

![](http://greatghoul.b0.upaiyun.com/1504/ujUzptVDKT31.png)

这个功能很小，小到都不值得去专门找一个专门的组件，所以就自己简单的实现一下。

要实现导航路径，我们需要

- 一个列表能够保存导航条目的信息，基本的包括文本和网址
- 一个添加导航项目的方法
- 一个在页面输出导航路径的方法

具体的使用场景可能是这样的：

    class ApplicationController < ActionController::Base
      before_action { drop_breadcrumb('系统首页', root_url) }
    end

    class ArticlesController < ApplicationController
      before_action { drop_breadcrumb('文章管理', articles_path) }
      
      def index
        drop_breadcrumb('文章列表')
      end
    end

这样我在访问 `/articles` 页面时，希望看到这样的导航路径：

> [系统首页](#) / [文章管理](#) / 文章列表


    def render_breadcrumbs
      @breadcrumbs.last[:active] = 'active'
      @breadcrumbs.first[:icon] = 'home'
      render '/shared/breadcrumbs'
    end

controller

    def drop_breadcrumb(text, url=nil)
      @breadcrumbs ||= []
      @breadcrumbs.push({ text: text, url: url})
      @title = text
    end

页面部分

    <ol class="breadcrumb">
      <% @breadcrumbs.each do |breadcrumb| %>
        <%= content_tag :li, class: breadcrumb[:active] do %>
          <% if breadcrumb[:url] %>
            <%= fa_icon(breadcrumb[:icon]) if breadcrumb[:icon] %>
            <%= link_to breadcrumb[:text], breadcrumb[:url] %>
          <% else %>
            <%= breadcrumb[:text] %>
          <% end %>
        <% end %>
      <% end %>
    </ol>
