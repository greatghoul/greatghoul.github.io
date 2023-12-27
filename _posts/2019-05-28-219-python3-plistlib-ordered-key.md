---
slug: 219-python3-plistlib-ordered-key
date: '2019-05-28'
layout: post
title: 使用 python3 plistlib 修改 plist 文件时保持 key 的顺序不变
tags:
  - Python
  - iOS
issue: 219
---


最近一段时间主要给公司维护一个 iOS 快捷指令（以下简称**捷径**）的社区，其中有个需求是给用户上传的捷径文件插入作者信息和更新步骤。

捷径的文件是一个二进制的 [plist] 文件，之前用了一个 nodejs 的库叫 [simple-plist]，不过因为 js 的局限性和这个库的 bug，导致读取捷径文件再修改保存后出现诸多问题，无奈切换到使用 python3 的标准库 [plistlib] 来修改捷径文件再进行转储，python2 的 plistlib 不支持读写二进制的 plist 文件，所以使用了 python3。

```py
import plistlib

data = plistlib.load(open(filename, 'rb'))
# 一些处理 ...
plistlib.dump(data, out_file, fmt = plistlib.FMT_BINARY)
```

但是这样处理的捷径也存在一些问题，经过修改再保存，plist 文件部分 key value 的顺序乱套了，捷径的功能也受到了影响。

![image](https://cdn.hashnode.com/res/hashnode/image/upload/v1642690866743/1Ibr14pVE.png)

查阅了 plistlib 的文档后，发现解析和保存时，有两个参数，会影响 key 的顺序。

```py
# dict_type
plistlib.load(fp, *, fmt=None, use_builtin_types=True, dict_type=dict)
# sort_keys
plistlib.dump(value, fp, *, fmt=FMT_XML, sort_keys=True, skipkeys=False)
```
合理设置这两个参数，可以保证在读解析和保存时，保持 key 的顺序不发生改变。

```py
import plistlib
import collections

data = plistlib.load(open(filename, 'rb'), dict_type = collections.OrderedDict)
# 一些处理 ...
plistlib.dump(data, out_file, fmt = plistlib.FMT_BINARY, sort_keys = False)
```

这个处理，我在 python 3.5.2 上面试验并没有成功，处理后的文件 key 依然会有错乱，但升级到 3.7.3 后就正常了，看文档 3.5.2 已经支持了这两个参数了，为什么处理不成功就不得而知了。

----

在下不才，也写了几个捷径，感兴趣的话，可以关注我的[捷径社区主页](https://sharecuts.cn/user/o1AzeklaGR)。

- [鸡你太美](https://sharecuts.cn/shortcut/1805) - 制作 cxk 鸡头和篮球贴纸照片
- [无限手套](https://sharecuts.cn/shortcut/1479) - 随机删除你相册一半的照片
- [技术雷达](https://sharecuts.cn/shortcut/1295) - 快速搜索 ThoughtWorks 技术雷达

[plist]: https://en.wikipedia.org/wiki/Property_list
[simple-plist]: https://www.npmjs.com/package/simple-plist
[plistlib]: https://docs.python.org/3/library/plistlib.html
