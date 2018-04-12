---
layout: post
title: 十字绣计划 之 图片转换色块图
slug: cross-stitch-convert-image-to-pattern-image
date: 2011-06-07 20:25
tags: [PIL, python, cross-stitch]
---

继之前的 [十字绣计划 之 图片转换HTML色块表][1] 作了一些改进，将生成HTML转变成生成图片形式的色块表，应该说，已经基本
能将一个图片转换成一张非常粗糙的图谱了（其实还不算是）。

转换前

![原图](http://pic.yupoo.com/greatghoul_v/B3UGdYui/dhKrp.jpg)

转换后

![转换后](http://pic.yupoo.com/greatghoul_v/B7PSaXHu/small.jpg)


很粗糙，而且还面临很多问题：

 * **杂色的规整**  
   虽然并不是颜色越少越好，但颜色太多太杂还是不利于绣的，得不停的换线，虽然 DMC 绣有 500 多种颜色，但其实我觉得将颜色
   规整到 256 色就可以满足普通需求了。求大家指定相关方法。
 * **颜色到线号的匹配**  
   观察了老婆的十字绣图谱，上面每种颜色都有对应一个单独的符号，然后在每格中[标注该格颜色的符号][2]，以便于辅助区分同
   色系不同颜色。从颜色到线号的匹配我有一张[DMC线的对照表][3]，DMC的绣线在淘宝上还是相对好买的，至于标注符号，借助 
   PIL，应该也不是什么难事。在图谱侧面还需要有一个颜色的索引，方便买线。
 * **线量的计算**  
   一根绣线能绣多少格其实是一定的，可以以一个合适的值作为粒度，根据图谱上图片的色块数量算出需要各种颜色绣线需要的量来
   （其实挺鸡肋的一个功能，但既然能做，还是考虑做一下的），这个我觉得也不是难点。  
   其实看一个，最难的地方，还是对颜色的去杂色和颜色规整处理，当然，选图这种事，可以交给用户自己去做，这块功能就可以不
   需要考虑太多了。  

下面是借助PIL库将图片转图谱（只是色格表，没有标符号和线号）的代码：

    # coding: utf-8
    """
    将图片转换成颜色块
    """
    import Image
    import ImageDraw
    import os

    def convert(imgfile, pw=10, ph=10):
        img = Image.open(imgfile)
        pix = img.load()
        im_out = Image.new("RGBA", (img.size[0] * pw, img.size[1] * ph) )
        draw = ImageDraw.Draw(im_out)
        for h in range(img.size[1]):
            for w in range(img.size[0]):
                draw.rectangle([w*pw, h*ph, w*pw+pw, h*ph+ph], fill=pix[w, h], outline=(255,255,255))
        del draw
        print 'done'
        im_out.save(os.path.splitext(imgfile)[0] + '.png', "PNG")
    if __name__ == '__main__':
        convert(r'100_0546.jpg', pw=20, ph=20)</pre>

[1]: http://www.g2w.me/2011/05/cross-stitch-convert-image-to-html-table/
[2]: http://img08.taobaocdn.com/imgextra/i8/31133170/T2aWNaXnlXXXXXXXXX_!!31133170.jpg
[3]: http://www.meilaodiy.com/10xiu/xianse/dmc-rgb.htm
