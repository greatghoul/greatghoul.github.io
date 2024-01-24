---
slug: 255-chatgpt-music-player
date: '2023-05-24'
layout: post
title: 使用 ChatGPT 写一个简单的播放器
tags:
  - Python
  - Tkinter
  - AIGC
issue: 255
---

作为一个普通程序员，听歌可以说是我的日常了，工作时听，学习时听，游戏时也要听。

### 我的听歌渠道

我近几年没有使用网易云音乐的习惯，觉得杂音太多。

#### Youtube

一般用于听一些老歌集锦，有种上古时代听 CD 或者磁带的感觉。也会听一些动物吃东西的 ASMR。而且 Youtube 的推荐算是听符合口味了。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/45303fd4-30a4-40eb-a912-8ced311d11f7)

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/d9321eae-c61e-4425-bb4a-7ebd6ecd0f50)

#### 本地音乐

会通过一些网站下载喜欢的歌曲到本地磁盘，然后用播放器循环播放，我最常听的音乐都放在 Google Drive 里面，然后再电脑和手机上同步。

电脑上使用 Google Drive 自己的客户端同步，手机上是使用 [FolderSync Pro](https://play.google.com/store/apps/details?id=dk.tacit.android.foldersync.full&hl=en_US&gl=US)，就同步而言，可以说是很丝滑了。

听歌应用的选择，手机上使用的是 [Musicolet](https://play.google.com/store/apps/details?id=in.krosbits.musicolet&hl=en_US&gl=US) ，算是比较干净，体验也很好，电脑上面则没有什么好的选择，试了一些播放器，都设计的太复杂了，最近一段时间，使用的是 VLC。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/0f8b04e3-a8f7-4224-b9b7-8136963a1efd)

### 自己动手

之前我试用过很多音乐播放器，无论是桌面的，浏览器扩展，还是网页应用，都没有能特别满足我的。

网页办的应用，有使用过 [GDriveMusic](https://gdrivemusic.com/)，直接从 GDrive 读取文件夹，网页里面播放，省去了同步到本地的麻烦，但是这个服务偶尔会抽风。最后不得已弃用了。不过它的简洁风格，我是很喜欢的。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/34f7f4d1-c034-448a-86d3-92c59f959ab4)

最近一段时间，AI 大行其道，于是我萌生了让 AI 帮我写一个播放器的想法。我选择的开发工具是 Python 的 [Tkinter](https://docs.python.org/3/library/tkinter.html)，因为 Python 自带，没有什么特殊的依赖，我对 UI 精美程度没有太高的期待，所以功能够用就好。

起初我只是简单的帮我用 tkinter 写一个音乐播放器，加载给定的文件夹里面的歌曲。然后 AI 给出的代码竟然直接就可以运行。

于是我就再按照自己的要求，调整了一下，它就给我生成了一段 Python 代码，运行后是一个大差不差的应用。

> write a simple mp3 player in Tkinter, should include a simple playlist from folder “G:\\我的云端硬盘\\01 音乐” , it plays music in the playlist randomly until app exit, or user can double click a music to start playing it, the playlist only show the music information in “artist - title” format, if both artist and title are missing, use the filename instead, no need duration column, music in playing should be in bold font style. The app don’t have a menubar, instead a toolbar including play / pause / stop / next buttons will be shown at the foot of the window.

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/abdc3bf7-8ea0-4873-82d8-e11e81c73fc4)

但是它其实没有正确处理自动播放下一曲的功能，这也难不住 AI，直接问它 pygame mixer 怎么检查歌曲播放结束，它给出了类似下面的示例代码。

```python
    def check_music_end(self):
        if pygame.mixer.music.get_busy():
            self.root.after(1000, self.check_music_end)
        elif pygame.mixer.music.queue:
            self.next_music()
```

稍微加入到代码中，调整调整，就正确的运行了。

我自己又在生成的代码上微调了一下布局什么的，一个拥有小巧窗口的播放器就完成了，只有简单的播放列表和控制按钮，支持自动随机播放。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/a976d109-02dd-4858-af3f-259d4bc20a28)

把 python 文件的后缀改为 .pyw 这样双击运行后不会有 Window 控制台的黑窗口，一切都很完美。

最终代码如下。以后想加什么进度条之类的，可以继续通过 AI 调教它。

```python
import os
import random
import tkinter as tk
from pygame import mixer

class MusicPlayer:
    def __init__(self, root):
        self.manually_stopped = False
        self.root = root
        self.root.title("Simple MP3 Player")
        self.root.geometry("500x400")

        # initialize mixer
        mixer.init()

        # create playlist
        self.music_folder = r"G:\\我的云端硬盘\\01 音乐"
        self.playlist = []
        for file in os.listdir(self.music_folder):
            if file.endswith(".mp3"):
                self.playlist.append(file)

        # create playlist frame
        self.playlist_frame = tk.Frame(self.root)
        self.playlist_frame.pack(fill="both", expand=1, padx=10, pady=10)

        # create playlist treeview
        self.playlist_treeview = tk.Listbox(
            self.playlist_frame,
            selectmode=tk.SINGLE
        )
        
        # create playlist scrollbar
        self.playlist_scrollbar = tk.Scrollbar(self.playlist_frame, command=self.playlist_treeview.yview)
        self.playlist_scrollbar.pack(side=tk.RIGHT, fill=tk.Y)
        self.playlist_treeview.config(yscrollcommand=self.playlist_scrollbar.set)

        self.playlist_treeview.pack(fill="both", expand=1)

        # set playlist items
        for file in self.playlist:
            self.playlist_treeview.insert(tk.END, file.split(".mp3")[0])

        # bind click on playlist item
        self.playlist_treeview.bind("<Button-1>", self.play_music)

        # create control frame
        self.control_frame = tk.Frame(self.root)
        self.control_frame.pack(fill="both", expand=0, padx=10, pady=(0, 10))

        # create control buttons
        self.play_button = tk.Button(self.control_frame, text="Play", command=self.play_music)
        self.play_button.pack(side=tk.LEFT, padx=10)

        self.pause_button = tk.Button(self.control_frame, text="Pause", command=self.pause_music)
        self.pause_button.pack(side=tk.LEFT, padx=10)

        self.stop_button = tk.Button(self.control_frame, text="Stop", command=self.stop_music)
        self.stop_button.pack(side=tk.LEFT, padx=10)

        self.next_button = tk.Button(self.control_frame, text="Next", command=self.next_music)
        self.next_button.pack(side=tk.LEFT, padx=10)

        # set current music index
        self.current_music_index = None

        # play the first music
        self.next_music()

    def play_music(self, event=None):
        if event:
            self.current_music_index = self.playlist_treeview.curselection()[0]
        if self.current_music_index is None:
            self.current_music_index = random.randint(0, len(self.playlist) - 1)
        mixer.music.load(os.path.join(self.music_folder, self.playlist[self.current_music_index]))
        mixer.music.play()
        self.playlist_treeview.selection_clear(0, tk.END)
        self.playlist_treeview.selection_set(self.current_music_index)

        self.check_music_end()

    def check_music_end(self):
        if self.manually_stopped:
          return

        if mixer.music.get_busy():
            self.root.after(1000, self.check_music_end)
        elif mixer.music.queue:
            self.next_music()
            
    def pause_music(self):
        mixer.music.pause()
        self.manually_stopped = True
        self.pause_button.configure(text="Resume", command=self.resume_music)
    
    def resume_music(self):
        mixer.music.unpause()
        self.manually_stopped = False
        self.pause_button.configure(text="Pause", command=self.pause_music)

    def stop_music(self):
        mixer.music.stop()
        self.manually_stopped = True
        self.current_music_index = None
        self.playlist_treeview.itemconfig(self.playlist_treeview.curselection(), bg="white")

    def next_music(self):
        if self.current_music_index is not None:
            self.playlist_treeview.itemconfig(self.current_music_index, bg="white")
        self.current_music_index = random.randint(0, len(self.playlist) - 1)
        self.playlist_treeview.see(self.current_music_index)
        self.play_music()

if __name__ == "__main__":
    root = tk.Tk()
    app = MusicPlayer(root)
    root.mainloop()
```
