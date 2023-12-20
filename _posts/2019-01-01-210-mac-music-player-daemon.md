---
slug: 210-mac-music-player-daemon
date: '2019-01-01'
layout: post
title: Mac 上使用 Music Player Daemon 在终端下播放音乐
tags:
  - Tool
  - macOS
issue: 210
---

最近被一首音乐洗脑，在做开发的时候，一直单曲循环作为背景音乐

> [MineCraft - C418 Begining](https://c418.bandcamp.com/track/beginning)

这是游戏《[我的世界](https://zh.wikipedia.org/zh-hans/%E6%88%91%E7%9A%84%E4%B8%96%E7%95%8C)》里面的一首曲子，但作为一个使用低配 MBP 作开发的人来说，开个 iTunes 光放音乐就得占至少 60M 内在，实在是有些吃紧，于是就寻觅别的音乐播放器。

我的需求是：

* 占用内存小
    
* 没有 GUI 或者只在状态栏里面有 GUI（iTunes 会有 Dock Icon）
    
* 歌曲管理不需要，因为我只有一首音乐
    

在 Mac App Store 里面逛了一圈，也看了一些开源的 App，没有一个合适的，于是就想起了 [MPD (Music Player Daemon)](https://www.musicpd.org/) 这个运行在终端或者系统服务中的音乐播放器。

于是赶紧安装了它的 server 和 client 程序。

```bash
$ brew intall mpd
$ brew install mpc
```

MPD 这东西有一些学习成本，这里我讲下我的配置。

首先，复制一下配置文件

```bash
$ cp /usr/local/etc/mpd/mpd.conf ~/.mpd/mpd.conf
```

然后编辑它，修改一些主要的配置

```ini
music_directory   "~/Music/MPD"
bind_to_address   "~/.mpd/socket"
```

`music_directory` 是存放音乐的地方，我新建了一个 `~/Music/MPD` 目录专门来存放我要播放的音乐，怕和其它音乐搞混。

`bind_to_address` 我指定为通过 socket 连接，主要是因为如果是 host 的方式的话，通过 client 添加音乐到播放队列的时候，老是报错，也没有找到什么解决的方法。

```bash
$ mpc -h localhost -p 6600 add ~/Download/c418-begining.mp3
mpc add file ~/Download/c418-begining.mp3 error adding access denied
```

启动一下 mpd 服务

```bash
$ brew services start mpd
```

然后通过 mpc 来控制播放

```bash
$ mpc -h ~/.mpd/socket add ~/Downloads/c418-begining.mp3
$ mpc -h ~/.mpd/socket play
```

为避免输入麻烦，可以做一个别名放在 `~/.bashrc`， 或者 `~/.zshrc` 如果你用的 zsh 的话。

```bash
alias mpc="mpc -h ~/.mpd/socket"
```

如果不想每次都用 `mpc add` 添加音乐的话，也可以直接复制音乐文件到 ~/Music/MPD 文件夹下，然后执行

```bash
$ mpc rescan
```

控制播放和暂停

```bash
$ mpc play 
$ mpc pause
```

开启循环播放

```bash
$ mpc repeat on
```

更多命令，查看

```bash
$ mpc help
```

---

MPD 完美的解决了我的需求，而且占用内存才 8M 左右，相比 iTunes 的 60M+，简直太环保了，而且没有运行窗口和图标干扰你的视线，享受宁静吧～
