---
slug: 6-wxpyhon-gridbagsizer
date: '2011-09-16'
layout: post
title: wxPython布局GridBagSizer的应用
tags:
  - Python
  - wxPython
issue: 6
---

wxpython 的布局管理器，除了 `BoxSizer` ，大概就 `GridBagSizer` 比较常用了，相比于 java 的 `GridBagLayout`，那不是方便
一点半点（事实上我到现在仍然不会用 java 的 `GridBagLayout`）。

`GridBagSizer` 和 html 的 `TABLE` 元素比较像，你可以把组件添加到指定行列的位置，并且可以指定行列合并，以及可以自动撑大
寸的填充块。

## 构造器

    wx.GridBagSizer(integer vgap, integer hgap)

`vgap` 和 `hgap` 分别用于指定组件的垂直和水平间距，可以理解为 `table` 的 `cellspacing` 属性。

## 添加组件

    Add(self, item, tuple pos, tuple span=wx.DefaultSpan, integer flag=0, integer border=0, userData=None)

`pos` 为组件添加到的位置 `(row, col)`，从`0`开始索引的整形值。

`span` 为行列合并 `(rows, cols)`，分别表示合并的行数和列数，可以理解为 `table` 的 `rowspan` 和 `colspan` 属性。

## 填充块

    AddGrowableRow(integer row)
    AddGrowableCol(integer col)

指定第几行自动撑高及第几列自动撑宽。

## 示例

下面是一个使用 `GridBadSizer` 布局的例子。

    #!/usr/bin/env python
    #-*- coding:utf-8 -*-

    import wx
    import sys

    class TestFrame(wx.Frame):
        def __init__(self):
            wx.Frame.__init__(self, None, -1, 'Full Screen Test')
            # 设置全屏模式
            self.ShowFullScreen(True, style=wx.FULLSCREEN_ALL)
            self.InitUI()

        def InitUI(self):
            panel = wx.Panel(self)
            panel.SetBackgroundColour('#555')
            sizer = wx.GridBagSizer(5, 5)

            self.muteBtn = wx.Button(panel, -1, u'静音')
            sizer.Add(self.muteBtn, pos=(0, 3), flag=wx.TOP, border=7)

            self.closeBtn = wx.Button(panel, -1, u'取消')
            sizer.Add(self.closeBtn, pos=(0, 4), flag=wx.RIGHT | wx.TOP, border=7)

            self.timerLabel = wx.StaticText(panel, -1, u'休息三分钟，去和朋友聊聊天吧！')
            sizer.Add(self.timerLabel, pos=(2, 0), span=(1, 5), flag=wx.ALIGN_CENTER | wx.LEFT | wx.RIGHT, border=7)
            self.timerProcess = wx.StaticText(panel, -1, '02:17')
            # 设置倒计时的字体
            font = wx.Font(30, wx.ROMAN, wx.NORMAL, wx.BOLD, True)
            self.timerProcess.SetFont(font)
            sizer.Add(self.timerProcess, pos=(3, 0), span=(1, 5), flag=wx.ALIGN_CENTER|wx.LEFT|wx.RIGHT, border=7)

            self.footerLabel = wx.StaticText(panel, -1, u'好好休息一下')
            sizer.Add(self.footerLabel, pos=(5, 4), flag=wx.RIGHT|wx.BOTTOM, border=7)

            sizer.AddGrowableRow(1)
            sizer.AddGrowableRow(4)
            sizer.AddGrowableCol(0)
            panel.SetSizerAndFit(sizer)

            self.Bind(wx.EVT_BUTTON, sys.exit, self.closeBtn)

    if __name__ == '__main__':
        app = wx.PySimpleApp()
        frame = TestFrame()
        frame.Show()
        app.MainLoop()


## 效果图

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/30b21683-d2f7-4d2c-a0e8-2704aa5c3184)


