---
slug: 77-simple-progress-bar-in-console
date: '2011-07-09'
layout: post
title: 命令行中模拟进度条
tags:
  - Python
issue: 77
---

最近总是需要造大量的数据，用 python 操作，非常方便，可以参考 [pyodbc][1] 这个东东。

数据量比较大的时候，等待是一种痛苦的事，所以做了个简易的进度条，在命令行中输出当前的进度。

效果类似这样：

```
ABCDEFGHIJKLMNOPQRSTUVWXYZ.csv (1000)                                  100%
``````

代码如下：

```python
import sys
import time

def print_progress(msg, progress):
    sys.stdout.write('%-71s%3d%%\r' % (msg, progress))
    sys.stdout.flush()
    if progress &gt;= 100:
        sys.stdout.write('\n')

if __name__ == '__main__':
    max = 1000
    for i in range(max + 1):
        progress = i * 1.0 / max * 100
        print_progress('ABCDEFGHIJKLMNOPQRSTUVWXYZ.csv (%d)' % i, progress)
        time.sleep(0.01)
```

进度条的关键在于，`\r` [Carriage return][2]，它可以把光标从移至本行的行首，而不会产生新行。

其实 python 已经有了非常棒的 [text progressbar][3]，可以非常方便定制进度条的外观及动态效果，鉴于这里只是非常简单的应用，没有必要额外再引入别的库了，一切从简。

[1]: http://code.google.com/p/pyodbc/
[2]: http://en.wikipedia.org/wiki/Carriage_return
[3]: http://pypi.python.org/pypi/progressbar/2.2
