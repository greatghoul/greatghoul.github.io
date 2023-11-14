---
slug: 58-sum-tasks-memories-in-windows-by-python
date: '2011-02-09'
layout: post
title: 取得windows系统当前进程列表，并计算占用的内存总值
tags:
  - Python
issue: 58
---

用 `os.popen()` 上了瘾，再来一段，计算 windows 进程列表中所有进程的内存占用总和，不过结果相当不准确。

    # coding: utf-8
    """
    取得windows系统当前进程列表，并计算占用的内存总值
    """

    import os
    import re

    memo_in_total = 0

    for line in os.popen('tasklist /nh'):
        line = line.strip()
        if line:
            memo = int(re.split(r'\s+', line.strip())[-2].replace(',',''))
            memo_in_total += memo

    print memo_in_total / 1024, 'MB in total'

