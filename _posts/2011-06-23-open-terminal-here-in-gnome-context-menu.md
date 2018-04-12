---
layout: post
title: Gnome中建立Open Terminal Here右键菜单
slug: open-terminal-here-in-gnome-context-menu
date: 2011-06-23 00:38
tags: [linux]
---

破机子装上了 [archlinux][1] ，桌面起初使用的是 [xfce][2] ，结果因搞不定 terminal 中的中文显示，当了逃兵，换了 gnome3。

不过 gnome3 并未提供方便的打开 terminal 的入口，只好自己加了，不会写 shell，就只有借助软件了  -- [Nautilus-Actions][3]

> Nautilus-Actions is a Nautilus extension whose principal function is to allow the user to add arbitrary actions to 
> the file manager context menus. These actions may be organized in menus and submenus, exported and shared with other 
> desktop environments.

1. 安装 nautilus-actions
-------------------------

    $ sudo pacman -S nautilus-actions

2. 添加 Open Terminal Here 的 Action
-------------------------------------

打开 Nautilus-Actions Configuration Tool 添加一个 action，在 Action 标签页中填写菜单名及Tip提示，
例如： **Open Gnome-Terminal Here**

![添加 Action ，编辑菜单名称](http://pic.yupoo.com/greatghoul_v/Ba8UlcHp/baZwI.png)

切换到 Command 选项卡

在 **Path** 中输入 terminal 应用程序的路径，如：`gnome-terminal`

在 **Parameters** 中输入参数 `--working-directory=%f`

在 **Working Directory** 中输入 `%d`

![Action的Command设置](http://pic.yupoo.com/greatghoul_v/Ba8UAQ79/VtGDf.png)

参数可参考：

    $ gnome-terminal --help-terminal-options

填写好后保存 Nautilus-Action Configuration Tool 设置

3. 配置 Nautilus-Actions 不使用子菜单
-------------------------------------

默认情况下，nautilus-actions 会将你的 actions 放在一个 Nautilus Actions 菜单下，每次执行 action，还得先点开这个菜单，
很麻烦，好在 nautilus-actions 提供了相关的配置。

打开 Nautilus-Actions-Configuration Tool 的 Preferences，在 Runtime Preferences 下面，可以看到这样的配置。
**Create a root 'Nautilus-Actions' menu** 取消勾选后保存即可。

![Nautilus Actions Configuration Tool Preferences](http://pic.yupoo.com/greatghoul_v/Ba8UMVFO/WZQvn.png)

现在在任意目录中展开你的右键菜单，大功告成。（为了使配置生效，可能还需要重启下X）

![Open Terminal Here 效果预览](http://pic.yupoo.com/greatghoul_v/Ba8UUZYD/u83ji.png)

[1]: http://www.archlinux.org/
[2]: http://www.xfce.org/
[3]: http://www.nautilus-actions.org/
