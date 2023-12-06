---
slug: 177-install-dbus-python
date: '2014-01-30'
layout: post
title: 安装 dbus-python
tags:
  - Python
issue: 177
---

写一个 python 脚本需要用到 dbus，但因为 [dbus-python] 这个包并没有提供 `setup.py` ，
所以无法通过 pip 直接安装，唯有[下载源码][src]手动编译安装一途了。

    wget https://pypi.python.org/packages/source/d/dbus-python/dbus-python-0.84.0.tar.gz
    tar zxvf dbus-python-0.84.0.tar.gz
    cd dbus-python-0.84.0

但事有不顺，在 `./configure` 的过程中，还是出了一些错。

    configure: error: Package requirements (dbus-1 >= 1.0) were not met:

    No package 'dbus-1' found

    Consider adjusting the PKG_CONFIG_PATH environment variable if you
    installed software in a non-standard prefix.

    Alternatively, you may set the environment variables DBUS_CFLAGS
    and DBUS_LIBS to avoid the need to call pkg-config.
    See the pkg-config man page for more details.

这显然是缺失了依赖库

    sudo apt-get install libdbus-glib-1-dev

然后安装就就可以顺利进行了

    ./configure
    make
    sudo make install

[dbus-python]: https://pypi.python.org/pypi/dbus-python/0.84.0
[src]: https://pypi.python.org/packages/source/d/dbus-python/dbus-python-0.84.0.tar.gz
