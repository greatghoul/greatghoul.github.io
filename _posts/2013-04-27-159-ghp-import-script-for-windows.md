---
slug: 159-ghp-import-script-for-windows
date: '2013-04-27'
layout: post
title: Windows 版 Github Pages 发布脚本
tags:
  - Batch Script
issue: 159
---

因为需要在 Github Pages 中发布新制作的[简历][1]，因此使用了一个 python 的工具 [ghp-import][2]，这个工具在 linux 下工作
非常完美，但是到了 windows 上面就会出很多问题，比如：

 * 有可能会损坏一些文件的格式，比如图片和 PDF。
 * 不能识别子目录，比如 `doc/myfile.txt` 发布后不是存储在 `doc` 文件夹下，而是存储成了 `doc\myfile.txt` 文件。

于是经常诸多尝试，写了一个简单的 BAT 文件用来发布子目录作为 Github Pages

    @echo off
    title Deploying gh-pages ...
     
    if "%1" == "" goto help
     
    if "%1" == ".git" (
        echo Warning:  Can not publish .git directory
        goto end
    )
     
    if not exist %1 (
        echo Directory "%1" not found.
        goto end
    )
     
    echo Creating gh-pages with directory: %1
    git branch -q -D gh-pages
    git checkout -q --orphan gh-pages
    git rm -r -q --cached .
    for /f %%G in ('dir /b .') do ( if not "%%G" == "%1" if not "%%G" == ".git" del /S /F /Q %%G > nul )
    move /Y %1\* .  > nul
    rd /S /Q %1 > nul
    git add .
    git commit -m "First Commit"
     
    echo Deploying gh-pages to github pages
    git push --force origin gh-pages
    git checkout -q -f master
    echo Everyting is done.
    goto end
     
    :help
    echo ghp-import ^<dirname^>
    goto end
     
    :end

最新代码可以在 <https://gist.github.com/greatghoul/5461633> 找到。

**用法：**

将文件保存为 `ghp-import.bat` 并放置在环境变量 `PATH` 的任意目录中，比如： `D:\Python27\Scripts``

在需要发布页面的项目根目录中执行

    ghp-import <dirname> 

**注意：** 目前 ghp-import 脚本只支持一级目录，理会深层次的目录就不支持了，不过我后面会改进的。


[1]: https://github.com/greatghoul/resume
[2]: https://github.com/davisp/ghp-import
