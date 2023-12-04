---
slug: 140-pycharm-setup-package-path
date: '2012-10-29'
layout: post
title: PyCharm 中配置 python 库的导入路径
tags:
  - Python
  - Tool
issue: 140
---

[PyCharm][1] 是一个非常棒的 Python IDE，它提供了完整的项目开发、调试、版本控制、代码着色、自动完成等功能，
比 [PyDev][2] 好用不是一点半点。

之前朋友申请了一个 PyCharm 了的开源授权帐号，我从而有幸用到如此强大的 Python IDE，用于开发 Python 项目，非常高效。

这里介绍一个 PyCharm 的小技巧。

对于我们通过 `sys.path.insert(...)` 导入的库，PyCharm 自然是无法识别的，编辑器会提示错误。

![pycharm-error](https://github.com/greatghoul/greatghoul.github.io/assets/208966/4835bcef-1aaf-4224-81e3-1414b281e227)

> Unresolved reference 'scriptfan' less... (Ctrl+F1) This inspection detects names that should resolve but don't. 
> Due to dynamic dispatch and duck typing, this is possible in a limited but useful number of cases. Top-level 
> and class-level items are supported better than instance items.

解决这样的问题，可以通过更改项目的配置项来解决。

打开 **File -> Settings -> Project Settings -> Python Intercepter -> Python Intercepters** 在 **Paths** 
选项卡的列表中添加自定义的导入路径即可。

![配置路径](https://github.com/greatghoul/greatghoul.github.io/assets/208966/37364871-ac7e-408d-9b32-d9b5647be149)

应用配置后，即可消除 Unresolved Reference 错误。

[1]: http://www.jetbrains.com/pycharm/
[2]: http://pydev.org/
