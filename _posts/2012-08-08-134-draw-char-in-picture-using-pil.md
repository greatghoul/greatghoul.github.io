---
slug: 134-draw-char-in-picture-using-pil
date: '2012-08-08'
layout: post
title: PIL批量给图片加上字母序号
tags:
  - Python
  - Image Processing
issue: 134
---

女友让我给她论文的图片上加上字母序号，本来觉得是个很简单的事情，但那个白底黑字的圆圈序号却难住了我，
试了几个常用的软件，都不行。

后来用 PS + 动作，倒是能搞出来，不过也不容易，正好那天没搞完，于是拿回自己家做，但我的电脑上又没有 PS，
所以就用 python 实现了。

**效果图**

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/b37160d6-67c9-4330-b47d-efacbc73dd1d)


这里用的图片全是 `240X240` 的，按文件名的首字母作为序号，[PIL][1] 虽然可以计算文字的尺寸，但类似 `D` 
这样的字符依然不能处于圆圈的正中，所以还对个别字符做了偏移设置，本来想用 [aggdraw][2] 画圆圈的，能平滑
一些，不过安装了好几次，都以失败告终，最终放弃。

```py
#!/usr/bin/env python
#-*- coding: utf-8 -*-
import os, sys, fnmatch
import Image, ImageDraw, ImageFont

def process_picture(filename):
    seq = os.path.split(filename)[-1][0].upper()
    img = Image.open(os.path.join(input_dir, filename))

    draw = ImageDraw.Draw(img)

    # 在右下角画白底黑框圆圈
    draw.ellipse((215, 215, 235, 235), outline='black', fill='white')

    # 将字母序号写入到圆圈内
    font = ImageFont.truetype('fonts/Times New Roman.ttf', 20)

    # 计算文字居中的位置
    text_size = draw.textsize(seq, font)
    x = (20 / 2) - (text_size[0] / 2)
    y = (20 / 2) - (text_size[1] / 2)

    # 字母偏移量
    offsets = {'A': 1, 'B': 1, 'E': 1, 'D': 2}
    offset = offsets.get(seq, 0)
    draw.text((215 + x + offset, 215 + y), seq, font=font, fill='black')

    # save image
    img.save(os.path.join(output_dir, filename), 'JPEG')

if __name__ == '__main__':
    if len(sys.argv) < 3:
        print 'Usage: python drawseq.py <input_dir> <output_dir>'
        sys.exit(1)

    input_dir, output_dir = sys.argv[1:3] 
    os.path.exists(output_dir) or os.makedirs(output_dir)

    for filename in os.listdir(input_dir):
        if fnmatch.fnmatch(filename.lower(), '*.jpg'):
            process_picture(filename)
```

[1]: http://www.pythonware.com/products/pil/
[2]: http://effbot.org/zone/pythondoc-aggdraw.htm
