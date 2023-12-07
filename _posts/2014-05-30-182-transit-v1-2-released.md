---
slug: 182-transit-v1-2-released
date: '2014-05-30'
layout: post
title: Chrome 划词翻译扩展 TransIt V1.2 发布
tags:
  - Chrome Extension
issue: 182
---

非常荣幸的宣布，TransIt 又升级了一个版本，这是自[开源][1]以来的第一个版本。
也算是对即将到来的双节的一个献礼，感谢大家对 TransIt 的支持，我们会一如继往的改进这个产品。

这个版本版本包括下面的更新：

## 页面划词翻译结果支持在选中的文本附近显示

TransIt 的页面划词翻译现在支持两种显示方式了：**窗口右侧显示**和**就近显示**，
可以同时照顾到大屏幕和小屏幕的用户了，大家选择自己喜欢的方式就好了。

![设置页面](https://github.com/greatghoul/greatghoul.github.io/assets/208966/862d78eb-846e-4492-9652-af761e4d11f3)

![就近显示](https://github.com/greatghoul/greatghoul.github.io/assets/208966/614c4d84-862c-472e-b8de-4c34fdf62196)

## 支持在框架页面内划词

之前的 TransIt 对框架页内的内容无能为力，现在这个问题也已经解决了。
可以畅快的在框架页面内划词翻译了，由于框架页面类型的限制，划词翻译的显示方式并不能完全兼顾。

- 对于顶层是 [FrameSet] 的页面，只能使用**就近显示**
- 普通页面内嵌框架页面，可以切换使用**就近显示**和**窗口右侧显示**

下面是在 [RunJS] 上的效果

![边缘显示](https://github.com/greatghoul/greatghoul.github.io/assets/208966/1a70ab9c-5cde-4f20-8bad-c5f428158c81)

![就近显示](https://github.com/greatghoul/greatghoul.github.io/assets/208966/289134e5-a720-4f1b-873a-a6c0437f2259)

## 支持 Tuborlinks 技术的网站

对于使用了 [Turbolinks] 技术的网站，网站在跳页时，会忽略掉划词脚本的加载，
导致跳页后划词脚本就失效了，现在 TransIt 也能搞定这种网站了。

下面是 [Ruby China] 上的效果

![RubyChina](https://github.com/greatghoul/greatghoul.github.io/assets/208966/38ba59f7-b916-404d-bb1d-5af73f0f87ff)

## 遵循有道 API 的调用规则，增加 Logo，去除缓存

TransIt 使用了[有道翻译API][2]来提供翻译服务，之前没有细心阅读其[使用条款][3]，
擅自在扩展里面对已经翻译的词进行缓存，以加快查过的词的翻译速度，这显示违反了条款。

所以这一版本， TransIt 去除了缓存的功能，其实有道的速度已经很快了，所以影响也不是很大。

此外，有道要求使用其 API，需要在适当的地方进行[品牌露出][4]，
所以目前在扩展弹出窗口中，也加入了有道的 Logo。

---

TransIt 以 MIT 协议开源在 <https://github.com/GDG-Xian/crx-transit>

欢迎喜欢或者不喜欢 TransIt 的朋友[提出意见或者建议][5]，
同时也欢迎热爱 Chrome 扩展开发的朋友 Fork 或者提交 PR.

[前往 Webstore 安装 TransIt][6]

[FrameSet]: http://htmlcss.wikia.com/wiki/Frameset
[Turbolinks]: https://github.com/rails/turbolinks
[Ruby China]: https://ruby-china.org/
[RunJS]: http://runjs.cn/code

[1]: https://groups.google.com/forum/#!topic/xian-gdg/Lf-dbAEA81Y
[2]: http://fanyi.youdao.com/openapi?path=data-mode
[3]: http://www.youdao.com/help/fanyiapi/privacy/
[4]: http://www.youdao.com/help/fanyiapi/brand/
[5]: https://github.com/GDG-Xian/crx-transit/issues
[6]: https://chrome.google.com/webstore/detail/transit/pfjipfdmbpbkcadkdpmacdcefoohagdc?utm_source=chrome-ntp-icon
