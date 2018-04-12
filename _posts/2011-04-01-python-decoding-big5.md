---
layout: post
title: python处理大五码
slug: python-decoding-big5
date: 2011-04-01 03:41
tags: [python, wxpython, encoding]
---

在抓取一个先进论坛的图片，遇到了些编码问题，因为该论坛采用的是[大五码(big5)][1]，通过 `urllib2.urlopen()` 拿到的是乱码

    >> s = urllib2.urlopen(url).read()
    >> s
    '\xa1i\xa5t\xc3\xfe\xa4\xd1\xb0\xf3\xa1j----- \xc2y\xa9_\xa4j\xc6['
    >> print s
    �i�t���Ѱ��j----- �y�_�j�[

所以我们需要将其转换成 unicode 编码

    >> s = urllib2.urlopen(url).read().decode('big5')
    >> s
    u'\u3010\u53e6\u985e\u5929\u5802\u3011----- \u7375\u5947\u5927\u89c0'
    >> print s
    【另類天堂】----- 獵奇大觀

在解析的过程中，还经常碰到一些以转义字表示的汉字，当显示在非 HTML 环境中时，就不那么能看得懂了。

> 超完美女优，<strong><span style="color: #ff0000;">&amp;#20026;</span></strong>什么<strong><span style="color: #ff0000;">&amp;#36825;</span></strong>么<strong><span style="color: #ff0000;">&amp;#38739;</span></strong>啊！

python 提供了 [unichr()][2] 函数用于将数字序号转换成对应的 unicode 字符

    >> s = u'超完美女优，&amp;#20026;什么&amp;#36825;么&amp;#38739;啊！'
    >> print re.sub(r'&amp;#(\d{1,5});', lambda m: unichr(int(m.group(1))), s)
    超完美女优，为什么这么靓啊！

**PS:** 其实，在练习 wxpython ，顺便做一个论坛图片抓取的工具（我似乎就喜欢干这类事儿），截图放出来看下，
为了社会的HX，特做了模糊处理，你懂的。

![隐窝窝爽图下载器截图](http://pic.yupoo.com/greatghoul_v/AXxstGyM/NvUJu.png)

[1]: http://zh.wikipedia.org/zh/%E5%A4%A7%E4%BA%94%E7%A2%BC
[2]: http://docs.python.org/library/functions.html#unichr
