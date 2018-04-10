---
title: 解决 gnome-tweak-tool 无法更换主题的问题
slug: gnome-tweak-tool-shell-user-theme-extension-not-enabled
date: 2012-02-23 20:40
tags: [archlinux, gnome-shell, gnome-theme]
---

卸载了XP，装上了 2011.8.19 的那个 ArchLinux，桌面为 gnome3，安装了 gnome-tweak-tool 后，无法更换桌面主题。

提示信息：

    Shell user-theme extension not enabled

![gnome-tweak-tool](http://pic.yupoo.com/greatghoul_v/BLpEph5R/IB1dW.png)

要启用，可用借助 `dconf-editor` 工具，打开 `dconf-editor`，展开 `org.gnome.shell`，将 `user-theme` 插件加入到键值 
`enabled-extensions` 中

    ['**user-theme@gnome-shell-extensions.gcampax.github.com**', 'poweroptions@fpmurphy.com']

当然，`user-theme` 插件需要自己下载

    sudo pacman -S gnome-shell-extension-user-theme

启用了插件后，重启 `gnome-shell`

    <Alt+F2>
    r<Enter>

然后就可以了。
