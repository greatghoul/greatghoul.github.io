---
slug: 156-jqmodal-with-rails
date: '2013-04-24 10:55'
layout: post
title: jqmodal在rails中的简单应用
tags:
  - Ruby on Rails
  - JavaScript
issue: 156
---

概述
----

我以前使用过很多 jquery 模拟对话框的组件，有的简洁，有的炫丽，甚至有的还带N多种可定制的皮肤，但往往的情况是
我们的页面中只需要一种，而且功能好的组件默认的皮肤却并不适合自己页面的风格，于是需要在插件的样式中修改。

于是又有了新的问题，插件的对话框 HTML 结构可能与前端的设计习惯不吻合，或者要改造成满意的样式和结构需要大费周折。

这个时候，[jqmodal][jqm] 就是一个比较好的选择了，因为它除了强大的 API 外，并不限制你使用什么样的 HTML 结构和样式表，
事实上它根本没有提供固定的 HTML 结构和默认皮肤什么的，你完全可以自己定制，于是你想设计成什么样就完全凭自己喜欢了。

而本文要介绍的就是利用 jqmodal 的特性 rails 中实现一个简单的对话框应用。

准备
-----

因为并未找到 jqmodal 相关的 gem，所以你需要手动拷备 jqmodal 的文件到 vendor 中以便调用。

在[这里][^1]下载 `jqModal.js` 并保存在应用 `vendor/assets/javascripts/` 下。

jqmodal 强大的 API 见[过里][^2]。

然后你需要在你的应用的 javascript 中添加 jqModal 的支持

    //= require jquery
    //= require jquery_ujs
    //= require jqModal

jqModal 既然是 jquery 的插件，自然是依赖于 jquery 的，不过需要注意的是，jqmodal 不支持 `jquery-1.9.x`，所以推荐使用
`jquery-1.8.3`，所以你需要在 `Gemfile` 中 jquery 的 gem 锁定在 `1.8.3`。

    gem 'jquery-rails', '2.1.4'

扩展
-------

通常的对话框总会伴随着 ajax 内容的加载，网速慢或者数据大的时候，对话框打开时需要较长时间，所以显示一个加载的提示效果
可以更友好一些，这个用 js 就能很轻松搞定，但当对话框中比较多，每个去写就没有必要了。

为了更方便的结合 rails 的 remote 调用，一个比较好的作法是，modal 默认内容就为加载提示（文字或者图片），触发 remote 
调用的同时，打开对话框，显示加载提示，等请求执行完毕，再替换对话框中的内容中新内容。
对话框关闭时。

### 定义通用的 modal 结构 

虽然 jqmodal 可以自由书写 HTML 结构，但在大量应用对话框的时候，完全没有必要重复定义 modal 结构，可以借助 rails 的 
helper 来实现一个 `modal_tag` ，定义好通用的部分，使用时只关心个性的部分就可以了。

修改 `app/helpers/application_helper.rb`

    module ApplicationHelper
      def modal_tag(title, options = {}, &block)
        options = { loading: true }.merge(options)
        locals = { 
          :modal_title => title.nil? ? 'Modal' : title,
          :options => options
        }

        if block_given?
          render :layout => '/layouts/modal', :locals => locals, &block
        else
          render :layout => '/layouts/modal', :locals => locals do 
            if options[:loading] 
              content_tag :span, 'Loading...'
            end
          end
        end
      end
    end

添加 `app/views/layouts/_modal.html.erb`

    <div <% if options.has_key?(:id) %>id="<%= options[:id] %>"<% end %> class="jqmWindow <%= options[:class] %>">
      <div class="modal-header">
        <%= modal_title %>
        <a href="#" class="jqmClose">&times;</a>
      </div>

      <div class="modal-content">
        <%= yield %>
      </div>

      <% if options[:loading] %>
      <div class="preloader" style="display: none">Loading...</div>
      <% end %>
    </div>

jqmodal 使用 `class=jqmWindow` 来标识一个元素是对话框，然后该元素内部的 `class=jqmClose` 来为元素绑定关闭对话框的事件。 

这样就可以在 erb 中使用 `modal_tag` 来快速定义一个对话框的结构了。

    <%= modal_tag 'Modal Demo', :id => 'modal_demo' %>

如果不希望显示加载提示，可以这样

    <%= modal_tag 'Modal Demo', :id => 'modal_demo', :loading => false %>

### 扩展 jqmodal

一般来说，modal 的正文并不是 jqmWindow 所在的元素，而是它的子元素(比如 `div.modal-content`)，所以如果要更新 modal 
的内容，需要这样：

    var $modal = $('#modal-id');
    $modal.find('.modal-content').html('Your content here.');

因为更新 modal 正文内容的使用频率非常频繁，所以我们可以写成一个 jqmodal 的扩展。

    jQuery ->
      $.fn.extend
        # 更新对话框内容
        jqmUpdate: (html) ->
          $modal = @
          $modal.find('.modal-content').html(html)

        # 自动关闭对话框 自动关闭默认时间为 2000
        # $obj.jqmAutoHide()
        # $obj.jqmAutoHide(1000)
        # $obj.jqmAutoHide(callback)
        # $obj.jqmAutoHide(1000, callback)
        jqmAutoHide: (delay, callback) ->
          $modal = @

          # 如果 delay 为数字，则使用该数字为延迟时间，否则使用系统默认时间
          timeout = if isNaN(delay) then 2000 else parseInt(delay)

          # 根据参数类型，自动选择加调方法
          handler = $.noop
          if $.isFunction(delay)
            handler = delay
          else if $.isFunction(callback)
            handler = callback
          
          setTimeout () ->
            $modal.jqmHide()
            handler()
          , timeout

为了方便在延迟几秒后关闭对话框，并执行可选的回调函数，我还加了一个 `jqmAutoHide` 方法扩展。

用法
-----

要使用 jqmodal，需要在页面加载时调用其构造方法进行初始化。

    ## jqmDialog 扩展方法
    # 初始化页面中的对话框
    $('.jqmWindow').jqm
      toTop: true
      modal: true
      onHide: (modal) ->
        modal.w.fadeOut () ->
          # 如果弹出窗口内容是ajax读取，则在隐藏时将内容重置为载入动画
          $preloader = modal.w.find('.preloader')
          modal.w.jqmUpdate($preloader.html()) if $preloader.length
          
          # 清除Overlay
          modal.o.remove() if modal.o

其中 `modal: true` 表示这是一个模态对话框，并会生成一个遮罩层。

    # 绑定了 data-toggle=jqmModel 的元素，会自动寻找 data-target 或者 href 对应的弹出层并打开
    $(document).on 'click', '[data-toggle=jqmModal]', (e) ->
      $this = $(@)
      href= $this.attr('href')
      $target = $($this.attr('data-target') or (href && href.replace(/.*(?=#[^\s]+$)/, '')))
      $target.jqmShow()
      e.preventDefault()


然后为 modal 绑定打开事件，只要在元素中加上属性 `data-target="jqmModal"`，则表示点击该元素可以
触发 modal 显示，并且需要加入属性 `target="modal-id"` 或者 `href="#modal-id"` 来指定要打开
modal 元素的 `id`。

在 erb 中，对于需要触发 modal 的元素，可以这样设置：

    <%= link_to 'Show Modal', show_path, :remote => true, 
      :'data-toggle' => 'jqmModal', 
      :'data-target' => '#modal_demo' %>

这样当点击链接时，会先显示一个对话框（带 loading 的效果），同时后台发送一个 script 类型的 ajax 请求
请求的返回脚本中，用来动态更新对话框的内容。

    var $modal = $('#modal_demo');
    $modal.jqmUpdate('<%= j(render :partial => 'show') %>');

在这个对话框中如果执行了提交表单之类的操作后需要关闭对话框，可以这样做：

    var $modal = $('#modal_demo');
    $modal.jqmUpdate('Work is done!');
    $modal.jqmAutoHide(function() {
        // Do something ...
    });


**效果如下：**

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/f13b3939-5a39-4498-bc2b-ac4b49daa5ae)


完整的 demo 可以[这里][^3]下载。

[jqm]: http://dev.iceburg.net/jquery/jqModal/
[^1]: http://dev.iceburg.net/jquery/jqModal/#where
[^2]: http://dev.iceburg.net/jquery/jqModal/#how
[^3]: https://github.com/greatghoul/playground/tree/master/jqmodal-demo
