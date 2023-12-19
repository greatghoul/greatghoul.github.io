---
slug: 205-image-gallery-waterfall
date: '2018-04-22'
layout: post
title: 图片型瀑布流实现
tags:
  - JavaScript
  - CSS
issue: 205
---

瀑布流已经是一种大家熟知的布局方式了，最著名的当属 [Pinterest](https://www.pinterest.com) 网站了。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/e33580c2-1130-4684-a9b9-347f647acee7)

开源社区中也有非常棒的实现瀑布流工具：[Masonry](https://masonry.desandro.com/) （砖石结构，非常贴切的一个名字），我自己也在建设瀑布流类的网站 [Awesome Pigtails](http://pigtails.info/])，在具体实现时也遇到了一些问题，主要是内容都是图片，图片的尺寸又都不统一，在动态加载时，无法准确计算卡片的尺寸导致布局混乱。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/af96bbee-d138-4a65-accf-63159f54b28b)

我尝试过两种方法，imageloaded 和固定图片宽高比，最终解决了这个问题。

## Imagesloaded

[imagesloaded](https://github.com/desandro/imagesloaded) 提供图片加载回调的 js 库，使用起来也非常简单。

```js
initMasonry( $('.grid') );
initMasonry( $('.grid-footer') );
initMasonry( $('.grid-hp') );

function initMasonry( $grid ) {
  var $grid = $grid.masonry({
    // options
  });

  // layout images after they are loaded
  $grid.imagesLoaded( function() {
    $grid.masonry('layout');
  });
}
```

这种方式实现起来非常简单，图片加载后，会自动触发 masonry 重算布局，但在图片加载完成之前，布局依然会有混乱，即使可以设置每个图片加载后都触发一次重算，但效果也并不理想。

```js
imgLoad.on( 'progress', function( instance, image ) {
  var result = image.isLoaded ? 'loaded' : 'broken';
  console.log( 'image is ' + result + ' for ' + image.img.src );
});
```

**参考资料：**

*   [Multiple masonry layouts on one page ](https://github.com/desandro/imagesloaded/issues/262)
*   [ImagesloadedEvents ‘progress'](https://github.com/desandro/imagesloaded#progress)
    

## 固定图片宽高比

既然 imagesloaded 有一些小缺陷，于是我就想到了固定宽高比，如果初始时就知道图片的尺寸 ，在页面元素上做上限制，这样 masonry 就不用等图片加载了才进行重算，初始时就可以直接进行自动布局了。

固定宽高比有很多种方式，[这篇文章](https://css-tricks.com/aspect-ratio-boxes/)里面有非常全面的总结，我使用了 **The Math of Any Possible Aspect Ratio** 这种方法。

```html
<div class="post col-md-3 col-sm-4 col-xs-6 col-xxs-12">
  <a class="thumbnail" href="/posts/298">
    <div class="thumb" style="background-image: url(https://i.imgur.com/lQFH36M.jpg);padding-top: calc(1200 / 949 * 100%);"></div>
    <div class="caption">イラストリアス。アンケ投票ありがとうございました！</div>
  </a>
</div>
```

使用 `padding-top` 为改变容器的高度

```css
padding-top: calc(height / width * 100%
```

使用 `background-image` 来替代 `img` 标签显示图片，并设置 [background-size 为 contain](https://developer.mozilla.org/en-US/docs/Web/CSS/background-size)

```scss
.post {
  .thumbnail {
    .thumb {
      width: auto;
      height: 0;
      background-size: contain;
      background-repeat: no-repeat;
      background-position: center;
      background-color: #eeeeee;
    }
  }
}
```

这样卡片的元素可以动态的根据卡片的宽度动态的设置卡片的高度，无需等等图片加载就可以完成瀑布流布局计算 。

```js
$(‘.posts’).masonry({ itemSelector: '.post' })
```

当然，这种方法也有一些麻烦的地方，就是你需要提前知道图片的尺寸并持久化在数据库中，但为了更好的体验，我认为是值得的。

**参考资料：**

*   [Aspect Ratio Boxes](https://css-tricks.com/aspect-ratio-boxes/)
