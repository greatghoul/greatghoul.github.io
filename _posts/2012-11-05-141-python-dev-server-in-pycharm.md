---
slug: 141-python-dev-server-in-pycharm
date: '2012-11-05'
layout: post
title: PyCharm中配置Python WEB的本地Dev Server
tags:
  - Python
  - Tool
issue: 141
---

上文中讲了 [PyCharm中配置python库的导入路径][1] ，本文中再分享下如何配置 PyCharm 以启动你的WEB工程，因为 django 
gae 已经有了集成的工具，所以只分享下 flask 和 uliweb 的工程怎么配置。

如下图，选择 **Run/Debug Configruation** 下拉框，选择 **Edit Configurations...**，新建一个 **Python** 的配置项。

![pycharm](https://github.com/greatghoul/greatghoul.github.io/assets/208966/4d34f855-341d-4594-b14f-fc0f696313e4)

这里需要关注的几个输入是

 - Script： `dev_server` 启动脚本的位置
 - Script Parameters: 启动脚本的参数
 - Project: 选择配置对应的项目
 - Working directory: 启动脚本的工作目录，指定些项以便脚本正确找到相对于项目目录的文件路径，比如配置文件。

Flask 配置
--------------

以  flask 为例，没有使用 flastk-script 扩展的情况下，如果我们的启动脚本是 `main.py` ，通常我们会执行

    python main.py

那配置中只需要配置 **Script** 为 `main.py` 并指定 **Working directory** 为项目所在路径，如果 `main.py` 还接受额外的
参数，填在 **Script Parameters** 里就可以了。

如果是使用 flask-script 的话，那我们通常这样启动。

    python manager.py runserver

这样的情况，配置 **Script** 为 `manager.py`，**Script Parameters** 填写 `runserver`，然后指定项目和项目路径即可。

Uliweb 配置
------------

Uliweb 的配置稍微特殊一些，通过启动 uliweb 需要执行

    uliweb runserver --thread -h 0.0.0.0 -p 9899

`uliweb` 指令本身就是一个 python 文件，所以这里我们要将 uliweb 的实际路径填写在 **Script** 中，比如
`/usr/local/bin/uliweb` ，然后在 **Script Parameters** 中填写 `runserver --thread -h 0.0.0.0 -p 9899` 

配置好后，点击配置下拉框旁边的启动按钮就可以启动本地的开发环境了。

![pycharm](https://github.com/greatghoul/greatghoul.github.io/assets/208966/41541b2d-050e-4f10-88eb-6a602fb59eac)


[1]: https://anl.gg/post/140-pycharm-setup-package-path
