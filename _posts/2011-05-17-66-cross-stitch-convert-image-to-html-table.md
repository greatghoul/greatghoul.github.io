---
slug: 66-cross-stitch-convert-image-to-html-table
date: '2011-05-17'
layout: post
title: 十字绣计划之图片转换HTML色块表
tags:
  - Python
  - Image Processing
issue: 66
---

女朋友最近在绣十字绣，我突发奇想，想做一个这方面的应用，本来打算做一个android版的，但考虑开发的周期太长了，还是先用 python 实现一下吧，把路子走通。

既然是十字绣应用，总该有个素材之类的才。。。

![原图](https://github.com/greatghoul/greatghoul.github.io/assets/208966/2feeb0f1-97ec-449d-933a-3bd21e53c9ea)

我去，这货不是狗头，这货不是狗头。。。

这里以我的头像为例，将其转换成html表格色块图。

处理图像，需要用到 python 的图像处理库 [PIL] 。

通过 PIL 将图像转换成 rgb 表。

    # coding: utf-8
    """
    将图片转换成颜色表
    """
    import Image
    import os
    import webbrowser

    def img2colmap(imgfile, pw=10, ph=10):
        img = Image.open(imgfile)
        pix = img.load()
        f = open(os.path.splitext(imgfile)[0] + '.html', 'w')
        f.write('''
                <style>
                td { font-size: 1px; line-height: 1px; }
                </style>
                <table cellpadding="0" cellspacing="0">\n''')
        for h in range(img.size[1]):
            f.write('<tr>')
            for w in range(img.size[0]):
                f.write('<td width="%d" height="%d" style="background:rgb%s">&nbsp;</td>\n' % (pw, ph, str(pix[w, h])))
            f.write('</tr>\n')
        f.write('</table>')
        f.close()

        print 'done'

    if __name__ == '__main__':
        img2colmap(r'E:\Pictures\greatghoul.jpg')</pre>

转换效果如下：

![转换效果](https://github.com/greatghoul/greatghoul.github.io/assets/208966/de0a56de-7ed2-41d5-b2a1-7a709d6c8831)

[PIL]: http://www.pythonware.com/products/pil/
