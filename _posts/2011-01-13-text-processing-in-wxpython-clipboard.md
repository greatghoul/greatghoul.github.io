---
layout: post
title: wxPython中使用剪贴板存取文本数据
slug: text-processing-in-wxpython-clipboard
date: 2011-01-13 16:17
tags: [java, python, wxpython]
---

从[皮皮书屋][^1]下载了一本[《wxPython 2.8 Application Development Cookbook》][^2]，特别喜欢这种 Cookbook 的书，
例子简单实用，本文中剪贴板处理部分便是参考 Cookbook 而作的练习。（皮皮书屋的注册验证码很给力）

涉及到开发桌面程序，尤其是文本处理，剪贴板就很常用，不像 java 中那么烦锁，wxpython 中访问剪贴板非常简单，寥寥几句足以。

    # 取得剪贴板并确保其为打开状态
    text_obj = wx.TextDataObject()
    wx.TheClipboard.Open()
    if wx.TheClipboard.IsOpened() or wx.TheClipboard.Open():
        # do something...
        wx.TheClipboard.Close()

取值：

    if wx.TheClipboard.GetData(text_obj):
        text = text_obj.GetText()

写值：

    text_obj.SetText(‘要写入的值’)
    wx.TheClipboard.SetData(text_obj)

下面的例子中，点击 Copy 会将文本框中的值复制到剪贴板，点击 Paste 会将剪贴板中的文本粘贴到文本框中。

![pic1](http://pic.yupoo.com/greatghoul_v/ALKMbM6s/156GfN.jpg)

    """
    Get text from and put text on the clipboard.
    """

    import wx

    class MyFrame(wx.Frame):
        def __init__(self):
            wx.Frame.__init__(self, None, title='Accessing the clipboard', size=(400, 300))

            # Components
            self.panel = wx.Panel(self)
            self.text = wx.TextCtrl(self.panel, pos=(10, 10), size=(370, 220))
            self.copy = wx.Button(self.panel, wx.ID_ANY, label='Copy', pos=(10, 240))
            self.paste = wx.Button(self.panel, wx.ID_ANY, label='Paste', pos=(100, 240))

            # Event bindings.
            self.Bind(wx.EVT_BUTTON, self.OnCopy, self.copy)
            self.Bind(wx.EVT_BUTTON, self.OnPaste, self.paste)

        def OnCopy(self, event):
            text_obj = wx.TextDataObject()
            text_obj.SetText(self.text.GetValue())
            if wx.TheClipboard.IsOpened() or wx.TheClipboard.Open():
                wx.TheClipboard.SetData(text_obj)
                wx.TheClipboard.Close()

        def OnPaste(self, event):
            text_obj = wx.TextDataObject()
            if wx.TheClipboard.IsOpened() or wx.TheClipboard.Open():
                if wx.TheClipboard.GetData(text_obj):
                    self.text.SetValue(text_obj.GetText())
                wx.TheClipboard.Close()

    app = wx.App(False)
    frame = MyFrame()
    frame.Show(True)
    app.MainLoop()

[^1]: http://www.ppurl.com/
[^2]: http://www.ppurl.com/2010/12/wxpython-2-8-application-development-cookbook.html
