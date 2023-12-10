---
slug: 190-transit-v1-3-released
date: '2015-03-11'
layout: post
title: Chrome 划词翻译扩展 TransIt V1.3 发布
tags:
  - Chrome Extension
issue: 190
---

时隔将近一年，TransIt 又迎来了一次大的更新：V1.3

这次的更新包括了下面的一些特性和改进：

- 添加独立的偏好设定页面，并精简弹出窗口
- 鼠标移上页面翻译结果时，结果面板不消失，移出后重新计时
- 解决页面翻译结果被页内查找框遮盖的问题
- 页面划词翻译结果分为两种显示形式，就近和窗口边缘
- 将链接划词的激活快捷键修改为敲击两次 Caps Lock
- 弹出窗口中支持长文本的翻译
- 添加百度翻译的服务，可以在有道和百度之间切换了

## 新的链接划词方式

以前的链接划词使用 Shift 作为快捷键，经常和系统的选择文本的快捷键冲突，带来很多不便，
但是使用 Ctrl+XXOO 等组件键又很不方便，所以我将激活链接划词的快捷键换成了 Caps Lock。

连续两次敲击 Caps Lock 就可以激活链接划词模式了，此时页面的链接都会失效，
划词完成后，链接就会恢复了，如果临时又不想划词了，可以点击页面任何一下或者再次双击 
Caps Lock 就可以。

让链接失效的方法也有所改进，之前是更改了页面链接的结构（有一定破坏性），现在是使用了
CSS3 的 [pointer-events]，对页面完全无损。

## 更加简洁的弹出窗口

![单词](https://github.com/greatghoul/greatghoul.github.io/assets/208966/26d6a60d-4bde-4b9f-85d5-34c212b2f886)

这个版本将不常用的用户偏好都转移到了独立的设置页面中去，只在弹出窗口中保留了
划词翻译、链接划词和前往设置页面的链接。

另外，TransIt 能更好的支持长文本的翻译了，考虑到在页面中显示对长文本的翻译结果
体验不好，所以页面只会响应单词的划词翻译，但你依然可以选中一段文本，然后打开弹出窗口，
选中的文本会在弹出窗口中显示出翻译结果，这个设定对于一些翻译一些在嵌套页面（Iframe）
中的文本非常方便。

![句子](https://github.com/greatghoul/greatghoul.github.io/assets/208966/bf1ab382-baca-488b-bb8b-6f8a067088f6)

## 添加了百度翻译的支持

因为有道翻译的服务接口配额有限，所以这一版本加入了百度翻译作为可选的翻译服务，
可以在设置页面中进行切换，以后也会陆续加入其它的翻译服务。

其实最想加入的是 Google 翻译，只不过目前它的接口还是付费的，而且还不便宜。

## 页面划词翻译结果的优化

之前有用户提到划词翻译的结果总是显示在页面的边缘，对于大屏的用户来说，体验很不好，
所以这一版本又加入了让翻译结果在单词附近显示的设定，以方便适应不同屏蔽的用户。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/d9145940-cc40-4d4d-945c-4cd9c9375b61)

对位置靠近的几个单词划词，翻译结果会有重叠，但只要将鼠标划过某个结果，它自动会置顶。
另外，鼠标移到翻译结果时，它的自动消失的计时会暂停，移开后又会继续，方便阅读。

----

此外，TransIt 也有了自己的宣传网站

<http://gdgxian.org/crx-transit/>

欢迎安装试用：

https://chrome.google.com/webstore/detail/transit/pfjipfdmbpbkcadkdpmacdcefoohagdc

[pointer-events]: https://developer.mozilla.org/en-US/docs/Web/CSS/pointer-events
