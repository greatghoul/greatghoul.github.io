---
slug: 198-revert-code-from-wechat-devtool
date: '2018-03-04'
layout: post
title: 找回微信开发者工具中误删的小程序源代码
tags:
  - IDE
  - 微信小程序
issue: 198
---

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/5c3ff68f-cd98-45fd-bb31-ff92f22fe18b)

**终于，受到了不做备份的惩罚。**

最近在开发一个微信小程序，因为只是从一个 demo 做起，就偷懒只在本地使用了 git，但并没有将工作推送到 remote。于是该发生的终究还是发生了，因为微信开发者工具的一个 Bug，以及我的误操作，导致工作成果全部丢失。

当时微信开发者工具的项目目录中莫名的出现了一个 `.` 目录，类似这样。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/19d7c21e-f6c9-4c92-8b31-c2cb4980d506)

（这个是我事后模拟的，建立文件夹时，文件夹可以命名为 `.` 并且不会报错，但删除后会删掉整个项目文件夹）

里面只有一个文件，当时脑子一抽，就把它删除了，然后就变成了下面这样。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/d3d475bf-6996-43e3-b60d-1a7f9dfe60cf)

整个目录都没有了！包括 `.git` 文件夹！我当时就凉了，虽然只是个 Demo，但是也实现了挺多的功能，重写一次肯定很难受。

趁着热乎，我尝试了一些恢复的方法。

**首先是文件恢复工具**

找了两款 Mac 下的文件恢复应用，都没有能够恢复这个文件夹

**恢复工具无效，就只能找找看小程序编译的缓存了**

但在微信开发者工具相关的目录找了个遍，也没有看到有用的东西。`/Users/<username>/Library/Application Support/微信web开发者工具/WeappBuildCache` 里面空空如也。在[这篇文章](http://blog.csdn.net/qq_39022313/article/details/72849560)提及的其它几个目录也找了下，依然未果。不甘心，在 `/Users/<username>/Library/Application Support/微信web开发者工具` 这个目录下再找找。

**使用小程序的 id 查找相应的文件名**

```
$ find . -name 'wxd359116e97dxxxx'
./WeappFileSystem/o6zAJszdNy5yHQ6C1PLiOyAxCUR8/wxd359116e97dxxxx
./WeappRemote/data/wxd359116e97dxxxx
./WeappRemote/temp/wxd359116e97dxxxx
./WeappRemote/wxd359116e97dxxxx
```

这几个文件夹都看过了，没有有价值的东西。

**使用小程序的 id 查找文件内容**

```
$ grep 'wxd359116e97dxxxx' . -r
Binary file ./Default/Storage/ext/ikhdnebglabgeplgnhnjgldiemdflddf/09F1EBF3AF8D/Cache/0fe5cffdcd00df22_0 matches
Binary file ./Default/Storage/ext/ikhdnebglabgeplgnhnjgldiemdflddf/09F1EBF3AF8D/Cache/ad78a46bfb6836da_0 matches
./WeappLocalData/localstorage.json:{
..............
}
```

这个方法能够检索到一些文本文件，但里面没有我想要的东西，都和源代码无关，虽然有几个二进制文件，但没有引起我的注意。

**继续以代码中的某个方法名查找文件内容**

```
$ grep 'renderGrid' . -r
grep: ./App Shim Socket: Operation not supported on socket
Binary file ./Default/Storage/ext/ikhdnebglabgeplgnhnjgldiemdflddf/09F1EBF3AF8D/Cache/00d43b43c128d7e7_0 matches
Binary file ./Default/Storage/ext/ikhdnebglabgeplgnhnjgldiemdflddf/09F1EBF3AF8D/Cache/6df5479a210eea9a_0 matches
./Default/Storage/ext/ikhdnebglabgeplgnhnjgldiemdflddf/09F1EBF3AF8D/Cache/ba7a36476285a8ef_0 matches
```

前面的几个二进制文件又冒出来了，这引起了我的注意，查看一下，果然发现了代码的踪迹。

```
cat ./Default/Storage/ext/ikhdnebglabgeplgnhnjgldiemdflddf/09F1EBF3AF8D/Cache/ba7a36476285a8ef_0
```

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/89d9afba-65a3-467b-ac32-e81c7d45cf65)

似乎是微信开发工具的 js 编译或者调试记录，找到最新的代码，复制出来手工恢复。

然后，**比较遗憾的是，这些文件里面只包含了 js 部分的代码，页面和样式的代码都缺失了**。不过聊胜于无，总算挽回了一些损失。这次吸取了教训，以后无论如何，都要随时 push 代码。
