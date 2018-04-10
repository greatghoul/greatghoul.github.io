---
title: Archlinux安装eclipse-jee
slug: install-eclipse-jee-in-archlinux
date: 2012-02-23 20:11
tags: [archlinux, eclipse]
---

刚装好的 ArchLinux (Gnome3) ，准备安装个 eclipse，不过官方 extra 里面找不到 eclipse-jee，只有 `eclipse 3.7.1`，
于是我直接在 eclipse 官方网站上下载了个 eclipse-jee，准备安装时，突然发现 aur 里面有一个 [eclipse-jee][1] 于是赶紧
下载了 tarball。

下载后 `makepkg`

    tar -zxvf eclipse-jee.tar.gz
    cd eclipse-jee
    makepkg -s

结果下载 `eclipse-jee-indigo-SR1-linux-gtk.tar.gz` 时异常的慢，实在不想再下载一次，刚好我下载的和这个是同一个版本，
所以直接将之前下载的 `eclipse-jee-indigo-SR1-linux-gtk.tar.gz` 移动到 `eclipse-jee` 解压的目录下，再 `makepkg -s` ，
顺利完成。

然后就是直接安装了 pkg 了。

    sudo pacman -U eclipse-jee.3.7.1.pkg.tar.gz

这样一来，以后更新什么的也方便多了，而且可以直接通过 gnome-shell 运行了。

虽然安装好了，但是启动 eclipse 时还遇到了些小麻烦，刚启动就直接崩溃了，老套路。

修改 `/usr/share/eclipse/usr/share/eclipse/eclipse.ini`

    sudo vim /usr/share/eclipse/usr/share/eclipse/eclipse.ini

将 `-Xms40m` 改为 `-Xms256m` 启动 eclipse 正常。

++2012-03-19 update: eclipse 自动完成功能与 xulrunner 冲突问题的解决方法++

为此困惑了很久，没有想到官方的wiki上面早都已经有了[解决方法][2]。

[1]: http://aur.archlinux.org/packages.php?ID=18067
[2]: https://wiki.archlinux.org/index.php/Eclipse#Autocompletion_and_javadoc_render_crash
