---
slug: 258-minecraft-automove-and-click-with-autoit
date: '2024-10-12'
layout: post
title: AutoIt 实现 MineCraft 自动行走长按鼠标左右键
tags:
  - Automation
  - Minecraft
issue: 258
---

![Minecraft 洞穴](https://github.com/user-attachments/assets/576027e3-7cdd-4d20-8d1a-95eb1b24f0bd)

玩我的世界已经有很多年了，虽然版本更新了很多，但是最喜欢的玩法还是探索天然洞穴，现在的版本，洞穴太丰富了，彻底清空一个洞穴，往往需要花费我几个月的时间，挖矿，赶路，自然都变成了一件异乎频繁的操作。

为了解放双手，我自己写了一个 [AutoIt](https://www.autoitscript.com/site/autoit/)脚本，实现自动操作。

主要功能：

- 按 `c` 键 开启/关闭 自动行走（主要用于赶路和游泳）
- 按 `[` 键 开启/关闭 长按鼠标左键（用于挖矿和砍树）
- 按 `]` 键 开启/关闭 长按鼠标右键（用于铺路和开垦农田）

脚本源码：

```au3
#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.16.0
 Author:         greatghoul

 Script Function:
	Minecraft auto right click & left click & move

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#include <WinAPIProc.au3>

Local $mouseDown = Null
Local $moving = False

While 1
	If IsGameActive() Then
		HotKeySet("[", "ToggleMouseLeftDown")
		HotKeySet("]", "ToggleMouseRightDown")
		HotKeySet("c", "ToggleAutoWalk")
	Else
		HotKeySet("[")
		HotKeySet("]")
		HotKeySet("c")
	EndIf

	Sleep(100)
WEnd

Func ToggleMouseLeftDown()
	ConsoleWrite("[ pressed" & @CRLF)
	If $mouseDown Then
		SendMouseUp()
	Else
		SendMouseDown("Left")
	EndIf
EndFunc

Func ToggleMouseRightDown()
	If $mouseDown Then
		SendMouseUp()
	Else
		SendMouseDown("Right")
	EndIf	
EndFunc

Func ToggleAutoWalk()
	If $moving Then
		Send("{w up}")
		$moving = False
	Else
		Send("{w down}")
		$moving = True
	EndIf	
EndFunc

Func IsGameActive()
	Local $processName = _WinAPI_GetProcessName(WinGetProcess("[ACTIVE]"))
	Return $processName == "javaw.exe"
EndFunc

Func SendMouseDown($button)
	MouseDown($button)
	$mouseDown = $button
	ConsoleWrite("Mouse is down: " & $mouseDown & @CRLF)
EndFunc

Func SendMouseUp()
	MouseUp($mouseDown)
	ConsoleWrite("Mouse is up: " & $mouseDown & @CRLF)
	$mouseDown = Null
EndFunc
```

安装 AutoIt 后，将脚本保存为 `Minecraft.au3` 后双击文件即可运行，我对脚本做了优化，如果没有激活游戏窗口，快捷键是不会起作用的。

我玩的 Java 版，如果是其它版本的 MC，需要自己修改 `IsGameActive` 方法里面的进程名。

具体游玩中，我发现其实 `[` 和 `]` 离得比较远，所以我给我的罗技鼠标也单独设置了快捷键，挖起来非常方便。
![鼠标快捷键设定](https://github.com/user-attachments/assets/ca2eafed-a0ee-44e8-9036-7a1de28dfce7)

对于自动行走，我之前有用一个叫 [YDM's Auto-Run](https://www.curseforge.com/minecraft/mc-mods/ydms-auto-run) 的 Mod，除了不能更改快捷键外，其实也蛮方便的。 YDM's Auto-Run 的快捷键是 `v` ，而我安装的 [Traveler's Backpack](https://www.curseforge.com/minecraft/mc-mods/travelers-backpack)  的快捷键是 `b` ，两个离得太近了，好几次我打开背包时误触，自动跑到悬崖下面摔死了（虽然关闭了死亡掉落，但是得重跑很多路就很烦）

