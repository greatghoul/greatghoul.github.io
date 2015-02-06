---
title: 推荐非常棒的 RSS 阅读应用 ReadKit
date: 2015-02-03 17:14 CST
tags: mac, reading
cover: http://greatghoul.b0.upaiyun.com/1502/uwsrmc1esr_-.png
---

2013年3月13日，[Google 宣布将关闭 Google Reader][1]，大家都震惊与惋惜的同时，
也都纷纷寻找可以替代的服务，我自然也加入到了这个大军之中。虽然 Twitter 与 Facebook 
这些社交网站已经替代 RSS 成为了更及时，传播更迅速的资料来源，但我还是衷情于 RSS。
唯一的原因是，**技术成长的路上，一直有 RSS 的帮助，而且我已经习惯了这一获取信息的方式**。

当时来说，Google Reader 无疑是最好用 RSS 阅读服务，要找一个[替代品][2]真的是非常困难，
所以最好能让 Google Reader 死而复生，于是加入了一个开源项目 [gReader]，企图使用 
Chrome Extension 保留 Google Reader 的大部分功能和体验，但毕竟精力有限，GR 又很复杂，最后这个项目就不了了这了。

在那之后，我觉得还是付费的服务比较靠谱，于是就花了 50 软妹币购买了 [NewsZeit] 一年的服务，
但使用后还是觉得这个服务的体验真的很一般，于是还没有到期就弃了。此时 [Aol Reader] 也
出生了，界面漂亮、扁平、响应式，还想什么，就是它了，于是很长一段时间，我都在使用这个服务。
Aol Reader 也有自己的一些问题，比如有些源有时突然就抓不到更新，需要删除后重新添加一下，
不过这些问题都能忍受，它真的是一个相当棒的服务。

去年，我终于入手了一台 RMBP，于是又把视线转入了 Mac App。

## Reeder2 还是 ReadKit？

桌面应用的响应无疑要比网页 App 快速许多，而且我阅读 RSS 的场景，大多都是在电脑前的，
所以我决定买一款 RSS 阅读器，Mac 下面有两个非常出名的 RSS 阅读器，[ReadKit] 
和 [Reeder]，两者价格相同，都是 68 软妹币，但基于下面几个原因，我选择了 ReadKit。

- Reeder 升级一个大版本就会重新收费，这点不是有些怕怕的
- ReadKit 虽然没有 Reeder 精美，但完全可以接受
- ReadKit 的功能对于我的阅读需要来说，完全够用了

## 调教 ReadKit

既然选择了 ReadKit，便不再反悔，不然太对不起我的软妹币了。

ReadKit 默认的设置并不太方便，所以我需要慢慢调教她了。

### Feed 账户

因为偶尔会在移动设备上阅读一些资讯，所以我没有使用 ReadKit 内建的 Feed 管理服务，
而是绑定了 [Feedly] 的服务，用它来托管我的订阅源，比较可惜的是，ReadKit 不支持
Aol Reader，而我又不太习惯 Feedly 杂志式的阅读体验，万幸 Feedly 的移动应用体验非常棒，
所以迁移到 Feedly 也还算 OK。电脑上阅读就用 ReadKit，移动设备上就用 Feedly 的 App。

### 稍后阅读

ReadKit 还支持 [Readability] 和 [Pocket]，这两个服务我都在用，
刚好可以都集成到 ReadKit 里面来。

![](http://greatghoul.b0.upaiyun.com/1502/fwsxmhgfFxab.png)

而 ReadKit 的 Smart Folder 会自动将 Readability 和 Pocket 的未读条目汇总到
**Read Later** 类别下，方便至极。

![](http://greatghoul.b0.upaiyun.com/1502/uwsrmc1esr_-.png)

### 快捷键

ReadKit 默认的一些快捷键并不好用，比如进入 Focus Mode 是 `Shift+Cmd+L`，
进行 Focus Mode 进行阅读是非常常用的操作，这个组合键略显麻烦，所以稍稍做一些修改。

- 专注模式：`→`
- 阅读原文：`Cmd →`

这样如果一个文章比较长，可以方便的通过右方向键进入专注阅读的模式，如果想查看原文，
可以按下 `Cmd →`，而从原文返回到阅读器页面或者返回列表，只需要按下左方向键就可以了。

**专注阅读模式**
![](http://greatghoul.b0.upaiyun.com/1502/SmmIpRjbxARD.png)

整个过程非常顺滑。

### 强迫症选项

ReadKit 在有新阅读条目时，会有系统通知，但强迫症患者还希望 Docker 图标中提示下未读数，
以激起阅读的欲望。

在相关账户的设定中，勾选 **Show in dock badge** 就可以了。

![](http://greatghoul.b0.upaiyun.com/1502/gvmn6iThrz4D.png)

### 分享的乐趣

遇到好的文章，当然要与人分享了，遇到暂时没有空读的长文章，也可以添加到稍后再读。

![](http://greatghoul.b0.upaiyun.com/1502/3IxRzYXjIfaN.png)

---

最后感慨一下，Mac 下面的好软件好多呀。

[gReader]: https://github.com/amoblin/gReader
[NewsZeit]: https://www.newszeit.com/
[Aol Reader]: http://reader.aol.com/
[ReadKit]: http://readkitapp.com/
[Reeder]: http://reederapp.com/mac/
[Feedly]: http://feedly.com/
[Readability]: https://readability.com/
[Pocket]: https://getpocket.com/

[1]: http://www.williamlong.info/archives/3405.html
[2]: http://alternativeto.net/software/google-reader/