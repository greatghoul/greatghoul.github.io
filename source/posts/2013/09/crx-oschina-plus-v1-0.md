---
title: Chrome扩展：开源中国增强版
slug: crx-oschina-plus-v1-0
date: 2013-09-23 17:47
tags: [chrome-extension]
---

[开源中国]最近的发展势头很猛，相继推出了许多新板块，比如[代码仓库]和[翻译]，不过最喜欢的还是翻译板块了，有时碰到一些比较
好的英文文献，读不太懂又找不到译文的就顺手投递上去，审核通过后就会有许多好心人帮你翻译出来，虽然翻译结果良莠不齐，但随
着时间的积累，还是会有许多不错的译文放出来。

吃白食时间长了，于是也想自己动手翻译一些资料，开源中国的翻译功能是按段落进行划分的，一次翻译一个段落，但因为自己的英文
功底还是太差，翻译一个段落也是很吃力的，而如果不翻译完整个段落，又无法提交，于是就想着自己动手改造出一个**保存草稿**的
功能。

上次[西安GDG DevFest][devfest] 活动中，开始起草这个插件，再利用一些闲暇时间，终于完成了这个小功能。

![screenshot](http://pic.yupoo.com/greatghoul_v/DbryYjhZ/LIi4N.png)

在商店中安装扩展后，打开开源中国的翻译板块，找一篇文章，点击段落旁边的我要翻译，会在翻译工具的提交按钮旁边增加一个
**保存草稿** 的按钮，点击保存后会将当前的翻译结果保存下来，下次打开这个段落的翻译页面会自动恢复上次的内容。

这样一来我这种英文小白就可以利用零散的时间去翻译一个段落，而不用等到全部翻译完整段后再提交。

当然，代码是开源的 :)

 * 项目地址： <https://github.com/GDG-Xian/crx-oschina-plus>
 * 商店地址： [https://chrome.google.com/webstore/detail/开源中国增强版/lancdlcgdlbhdicajpcfgbncijpaolha][webstore]

[开源中国]: http://www.oschina.net/
[代码仓库]: http://git.oschina.net/
[翻译]: http://www.oschina.net/translate/
[devfest]: https://plus.google.com/photos/107383738221775294288/albums/5924033235835155313?sqi=111347222679273125825&sqsi=b6e64350-0acb-4523-8d13-ebd7806463e6
[webstore]: https://chrome.google.com/webstore/detail/%E5%BC%80%E6%BA%90%E4%B8%AD%E5%9B%BD%E5%A2%9E%E5%BC%BA%E7%89%88/lancdlcgdlbhdicajpcfgbncijpaolha

