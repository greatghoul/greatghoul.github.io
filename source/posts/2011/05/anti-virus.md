---
title: 遭遇文件夹病毒
slug: anti-virus
date: 2011-05-23 21:48
tags: [anti-virus, windows]
---

同学去北京工作，需要找两个“保荐人”（其实只是一种形式），需要保荐人的身份证电子扫描件，于是昨天去了复印店扫描，因为需要
描双面，竟然每面需要两元钱（黑），那大姐还用ps装模做样的PS了一下。

于是掏出手机，插入了那大姐的USB，当时也没成想，今天晚上上传图片时，在文件对话框中死活找不到之前存放文件的文件夹，而我
机里是可以看到该图片的，所以我90%可以断定，我染毒了，囧，而且很有可能是很久以前盛行的[文件夹病毒][1]，这年头，如果不
点电脑知识，随便找个病毒，都能强奸你，这种病毒那已经是我大学时的产物了，现在竟然还在流行。

![pic](http://pic.yupoo.com/greatghoul_v/B5z2geE0/jikFv.png)

由于没有杀毒软件，实在是在裸奔，于是手动查杀，方法很简单。

打开 CMD，切换到U盘根目录，执行以下命令:

    attrib -S -A -R -H /S /D

等待一段时间之后，文件夹就都显现出来了，exe文件也都可以删除了，手动删除即可。[切记不要双击打开U盘][2]

[1]: http://www.google.com.hk/search?sourceid=chrome&amp;ie=UTF-8&amp;q=%E6%96%87%E4%BB%B6%E5%A4%B9%E7%97%85%E6%AF%92&amp;qscrl=1
[2]: http://hi.baidu.com/help58/blog/item/c99c907ef41fdc380dd7da4b.html
