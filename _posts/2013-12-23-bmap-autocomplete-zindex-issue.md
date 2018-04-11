---
layout: post
title: 百度地图地址自动完成控件的 z-index 问题
slug: bmap-autocomplete-zindex-issue
date: 2013-12-23 15:54
tags: [baidu-map, coffee, css, jquery]
---

在项目中应用百度地图的 [Autocomplete] 控件来辅助地址输入，在普通的页面中使用很正常，但放在浮层中就出现了问题：
自动完成的下拉浮层被遮住了！

![Autocomplete1](http://pic.yupoo.com/greatghoul_v/DpgY1830/jzui2.png)

很显然，是 Autocomplete 下拉浮层的 z-index 太低了（事实上，百度压根没有考虑到这一点）

    <div class="tangram-suggestion-main" id="tangram-suggestion--TANGRAM__19-main" data-guid="TANGRAM__19"
         style="position: absolute; display: none; left: 554px; top: 164px; width: 294px;">...</div>

但是问题还是要解决，只能是写 css 来为 `div.tangram-suggestion-main` 这个元素设置一个**合适**的 `z-index`

    .tangram-suggestion-main {
        z-index: 1060;
    }

然后这个问题就会被修正了。

![Autocomplete2](http://pic.yupoo.com/greatghoul_v/Dph1KsPD/OcJjx.png)

---

顺便送上一个百度地图 Autocomplete 的简单 jQuery 封装

    # 百度地图地址自动完成组件
    do ($ = jQuery) ->
      $.fn.bmapAutocomplete = (options) ->
        return @each () ->
          instance = $(@).data('bmapautocomplete')
          $(@).data('bmapautocomplete', (instance = new BMap.Autocomplete(input: @))) unless instance

使用方法：

    $(document).on 'focus', '.input-address', (e) ->
        $(@).bmapAutocomplete()

[Autocomplete]: http://developer.baidu.com/map/reference/index.php?title=Class:%E6%9C%8D%E5%8A%A1%E7%B1%BB/Autocomplete
