---
slug: 136-pil-gaussian-blur
date: '2012-09-21'
layout: post
title: PIL对图像进行局部高斯模糊
tags:
  - Python
  - Image Processing
issue: 136
---

逛 ChinxUnix 时遇到这样一个[求助帖子][1]：

> RT，想问一下如何将一个图片的某个区域进行高斯模糊而不是整张图片模糊？

从一篇文章中看到，`PIL 1.1.5` 已经内置了高斯模糊，但是并没有在文档中提及，而且PIL的高斯模糊中 radius 是硬编码，
虽然构造方法中有传入 radius 参数，但压根就没有用到 （[看这里][2]），所以需要自己进行改造，当然，知道了原因，
修改起来自然非常简单了。

结合帖子中的需求，对局部进行高斯模糊，所以还需要结合使用 [crop][3] 和 [paste][4] 方法实现局部使用滤镜。

代码如下：

```py
#-*- coding: utf-8 -*-

from PIL import Image, ImageFilter

class MyGaussianBlur(ImageFilter.Filter):
    name = "GaussianBlur"

    def __init__(self, radius=2, bounds=None):
        self.radius = radius
        self.bounds = bounds

    def filter(self, image):
        if self.bounds:
            clips = image.crop(self.bounds).gaussian_blur(self.radius)
            image.paste(clips, self.bounds)
            return image
        else:
            return image.gaussian_blur(self.radius)

bounds = (150, 130, 280, 230)
image = Image.open('source.jpg')
image = image.filter(MyGaussianBlur(radius=29, bounds=bounds))
image.show()

```
可以看下效果：

![妹子原图](https://github.com/greatghoul/greatghoul.github.io/assets/208966/96293c8f-97e9-4655-a79e-a4b951958b82)

![局部高斯模糊效果](https://github.com/greatghoul/greatghoul.github.io/assets/208966/cb076f61-03df-4354-8720-84b3645c1a82)


[1]: http://bbs.chinaunix.net/thread-3771095-1-1.html
[2]: http://aaronfay.ca/content/post/python-pil-and-gaussian-blur/
[3]: http://www.pythonware.com/library/pil/handbook/image.htm#Image.crop
[4]: http://www.pythonware.com/library/pil/handbook/image.htm#Image.paste
