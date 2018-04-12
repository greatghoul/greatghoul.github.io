---
layout: post
title: wxPython中TextCtrl控件的文本长度限制
slug: text-length-limit-of-textctrl-in-wxpython
date: 2011-01-10 14:52
tags: [python, wxpython]
---

在用 [wxPython][^1] 做一个练习正则表达式的小工具，界面中有一个 source string 的多行文本框，当然，常用于粘贴网页源代码，
结果粘贴一段比较长的网页源代码时，粘贴进去的文本是截断的，看到默认的配置是有文本长度限制的 。

去除这个限制其实很简单，设置 `MaxLength` 为 `0` 即可 [via][^2]

    self.source = wx.TextCtrl(rootPane, style=wx.TE_MULTILINE)
    self.source.SetMaxLength(0)

> **wxTextCtrl::SetMaxLength**
>
> **virtual void SetMaxLength(unsigned long len)**
> 
> This function sets the maximum number of characters the user can enter into the control. In other words, 
> it allows to limit the text value length to len not counting the terminating NUL character.
> 
> If len is 0, the previously set max length limit, if any, is discarded and the user may enter as much text 
> as the underlying native text control widget supports (typically at least 32Kb).
> 
> If the user tries to enter more characters into the text control when it already is filled up to the maximal length,
> a `wxEVT_COMMAND_TEXT_MAXLEN` event is sent to notify the program about it (giving it the possibility to show an 
> explanatory message, for example) and the extra input is discarded.
> 
> Note that under GTK+, this function may only be used with single line text controls.

发现默认情况下，`TextCtrl` 是没有对一些快捷键的支持的，比如说全选(`Ctrl+A`)，Google 未果，只能求助于列表了，
很快就解决了。

    self.source = wx.TextCtrl(rootPane, style=wx.TE_MULTILINE|wx.TE_RICH|wx.TE_PROCESS_ENTER)

**ps:** 欢迎西安的 pythoner 加入讨论组 <http://groups.google.tk/group/xapy>，墙内访问方法：
<http://greatghoul.appspot.com/subscribe-to-google-group-directly>

[^1]: http://www.wxpython.org/
[^2]: http://www.wxpython.org/docs/api/wx.TextCtrl-class.html#SetMaxLength "Package wx :: Class TextCtrl" 
