---
layout: post
title: 魔兽世界切换战斗和钓鱼模式宏
slug: wow-macro-toggle-fishing
date: 2011-11-28 23:52
tags: [game, wow, wow-macro]
---

在玩 wow 时, 发现渔点后,我经常需要做的操作是

 - 装备上钓杆
 - 切换动作条到第二页(钓鱼技能放在第二页的1号位置)
 - 开始钓鱼
 - 切换动作条到第一页
 - 装备原先的武器

虽然整个过程太繁琐了,于是想着用宏来搞定,参考 [WowWiki][1] 的教程后,写了一个切换钓鱼模式的宏.

    /script if (GetMouseButtonClicked() == 'LeftButton') then EquipItemByName('纳特·帕格的超级钓鱼竿FC-5000型');ChangeActionBarPage(2); else EquipItemByName('纠结长杖'); ChangeActionBarPage(1); end

**大致作用为：** 如果在宏上左键点击，则装备钓杆，切换动作条到第二页，如果是右键点击，则装备武器，切换动作条到第一页
此过程在未脱离战斗的状态下无效)

 - `ChangeActionBarPage(index)` 切换动作条 index代表页数
 - `EquipItemByName(item) ` 装备道具, item代表道具名称

替换代码中钓杆,武器,及动作条页数即可适应各自的需要了.

**参考文章：**

 - [Shrinking a macro][2]
 - [World of Warcraft API][3]


[1]: http://www.wowwiki.com/
[2]: http://www.wowwiki.com/Shrinking_a_macro
[3]: http://www.wowwiki.com/World_of_Warcraft_API
