---
title: SAE Python 应用开发和部署环境搭建
date: 2015-02-06 22:40
tags: sae, python
cover: http://greatghoul.b0.upaiyun.com/1502/rx8bA89aC6_N.png
---

![](http://greatghoul.b0.upaiyun.com/1502/rx8bA89aC6_N.png)

因为 [GAE] 在国内访问不便，所以平时有一些小应用，我都会放在 SAE 上面，
虽然 [SAE] 还有很多缺陷，但算是上手比较容易的一个了，最起码[文档][1]写的不错。

开发 SAE 上的应用，我一般都用 [Flask]，[SAE 预装了 Flask][2]，所以你可以直接用，
但我们难免会用一些没有预装的库。

如果是在以前，可能需要自己将 package 挨个 copy 到应用目录中，然后手动加载，
现在嘛，不需要那么麻烦了，SAE 有个非常不错的解决方案，见[《安装依赖的第三方包》][3]

你可以使用 `saecloud` 来代替 `pip` 安装第三方库

    saecloud install -r requirements.txt

这条命令会将第三方库安装在应用目录的 `site-packages` 目录下面，部署时可以将所有的依赖
打包成 zip 档案，这样上传和维护都很方便。

    cd site-packages/
    zip -r ../site-packages.zip .

在 `index.wsgi` 中将这些依赖加载进来

    import os
    import sys

    root = os.path.dirname(__file__)

    # 两者取其一
    sys.path.insert(0, os.path.join(root, 'site-packages'))
    sys.path.insert(0, os.path.join(root, 'site-packages.zip'))

虽然是二者取其一，但学是推荐使用 zip 档案的方式。

有个问题是，我们需要打包的，只是 SAE 没有预装的包，
但我们本地开发还要依赖 Flask 这些预装的包，
都使用 `saecloud` 安装的话，这个包明显就会有冗余。

借鉴于 [bower], [npm] 这些包管理器的依赖管理的优点，
我们显然应该将依赖库分离出来。

    # 安装非预装依赖
    pip install -r requirements.txt
    # 维护预装依赖
    saecloud install -r requirements-dev.txt

这样，只有 `requirements.txt` 中的包会被安装到应用目录下的
`site-packages` 文件夹中。

经过一些实践，我整理了自己用着比较顺手的源代码文件结构

    LICENSE
    Makefile
    README.md
    requirements-dev.txt
    requirements.txt
    site-packages
      ...
    site   <--- web app 目录
      index.wsgi
      main.py
      config.yam
      site-packages.zip   <--- 打包的依赖库
      ...

我会将下面的文件加入到 `.gitignore`，以避免它们被提交到版本中。

    /site-packages
    /site/site-packages.zip
    /site/index.wsgic

为了方便安装依赖和部署项目，我写了个 [Makefile][4]

<script src="https://gist.github.com/greatghoul/6cc39bdf530c4f29c166.js"></script>

这个脚本有三条指令

- `make install`  安装依赖并打包到 `site/site-packages.zip`
- `make server`   启用 dev server
- `make deploy`   将应用发布到 sae


[GAE]: https://cloud.google.com/appengine/
[SAE]: http://sae.sina.com.cn/
[Flask]: http://flask.pocoo.org/
[bower]: http://bower.io/
[npm]: https://www.npmjs.com/

[1]: http://sae.sina.com.cn/doc/python/
[2]: http://sae.sina.com.cn/doc/python/runtime.html#id7
[3]: http://sae.sina.com.cn/doc/python/tools.html#howto-use-saecloud-install
[4]: https://gist.github.com/greatghoul/6cc39bdf530c4f29c166