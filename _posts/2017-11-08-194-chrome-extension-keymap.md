---
slug: 194-chrome-extension-keymap
date: '2017-11-08'
layout: post
title: Chrome 扩展中使用自定义快捷键
tags:
  - Chrome Extension
  - JavaScript
issue: 194
---

## Chrome Command vs. 页面键盘事件

要为扩展加入快捷键的支持，一般有两种做法：

* 监听页面键盘事件（一般是 contentscript）
    
* 使用 [Chrome Command](https://developer.chrome.com/apps/commands)
    

要监听页面键盘事件，有很多 JavaScript 的库可以用，比如 [jquery.hotkeys](https://github.com/jeresig/jquery.hotkeys)，你可以完全自定义按键的组合，非常灵活，很多扩展都使用的这种方法，不过设置快捷键的 UI 也得自己来编写。如果你想让设置快捷键的 UI 与扩展的其它页面风格一致，拥有自主权无疑是件好事，但如果你只是单纯的想为用户提供几组快捷键来触发一些动作，并且想让这些快捷键可以更改，以适应不同用户的偏好，那 Chrome Command 可能更适合你。

* 为不同的操作系统预留不同的快捷键（比如 Mac 用户偏好使用 Cmd 替代 Ctrl）
    
* 可以操作系统全局响应，无需限制用户一定得在定义的快捷键的页面上触发。
    
* Chrome 自带了更改快捷键的 UI（虽然很丑而且很难找）
    

当然，Chrome Command 也有一些限制。

* 快捷键中必须包含 Ctrl (Cmd) 或者 Alt，但 Ctrl 和 Alt 不能同时使用。
    
* 不能自定义编辑快捷键的 UI，而 Chrome 又没有提供一个方便的设置入口。
    
* 不能使用ESC 或者 Tab 来组合快捷键（Supported keys: A-Z, 0-9, Comma, Period, Home, End, PageUp, PageDown, Space, Insert, Delete, Arrow keys (Up, Down, Left, Right) and the Media Keys (MediaNextTrack, MediaPlayPause, MediaPrevTrack, MediaStop）
    
* 不能使用单键，比如 `Q`。
    

## 定义键盘映射

使用 Command 不需要额外的权限，只需要在 `manifest.json` 中添加相关的定义即可。

```json
{
  "manifest_version": 2,
  "commands": {
    "toggle-link-inspect": {
      "suggested_key": {
        "default": "Ctrl+Shift+L",
        "mac": "MacCtrl+Shift+L"
      },
      "description": "打开/关闭链接划词模式"
    }
  },
}
```

其中 `toggle-link-inspect` 是快捷键按下时触发的 Command 事件名称，你可以自己定义这个名称，`suggested_keys` 分别定义各操作系统下的预设快捷键，如果没有特别定义哪个操作系统的快捷键，会使用 default。需要注意的是，在 macOS 下，Ctrl 会被 Cmd 取代，如果要在 macOS 下使用 Ctrl 作为快捷键，需要使用 MacCtrl。

Command 的一大好处就是，你可以定义扩展 Popup 窗口的快捷键，它有一个预留的名称：`_execute_browser_action` 。

```json
"_execute_browser_action": {
  "suggested_key": {
    "windows": "Ctrl+Shift+Y",
    "mac": "Command+Shift+Y",
    "chromeos": "Ctrl+Shift+U",
    "linux": "Ctrl+Shift+J"
  }
},
```

扩展窗口的快捷键为扩展带来了很多便利以及可能性，比如我日常使用的一个扩展 [Go to Tab](https://chrome.google.com/webstore/detail/hjfkaobgkmaeomgdhmhhipdbjdhhjkoi)，我把它的快捷键定义为 `Cmd + P`（打印这个功能，一年都用不了几次，占着这么好的一个快捷键，太浪费了），这样我就可以像使用 Sublime Text 一样，快速在各个标签页之间跳转，而无需费力的移动鼠标然后从密密麻麻的标签页中寻找再点击了。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/30742267-d62c-421b-999e-c9071fb6edd2)

## 响应 Command 事件

Chrome Commands 提供了一个 `onCommand` 事件用于监听快捷键的触发，这个监听必须在 background 页面设置。

```javascript
chrome.commands.onCommand.addListener(command => {
  if (command === 'toggle-link-inspect') {
    // do something
  }
})
```

需要注意的是，你无法监听到 `_execute_browser_action`。

## 快捷键设置页面

接受了 Chrome Commands 的美好，也要忍受一些它的不便，而它最大的不便就是快捷键设置的入口非常不好找。你需要打开 Chrome 扩展列表页面 `chrome://extensions/` 然后把滚动条拉到页面的最底端，然后才能看到设置快捷键页面的那个不起眼的入口。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/419aa127-9d1a-4eda-bd71-1d5bd0599aa0)

当然，我们也有一些方法可以引导用户前往设置页面，Chrome 提供了一个特殊的网址，跳转到扩展列表页面后会自动打开快捷键设置的对话框。

```
chrome://extensions/configureCommands
```

虽然这是一个网站，但因为 Chrome 的限制，你没有办法通过设置一个 a 标签的 href 属性来让链接点击时跳转到 `chrome://` 相关的页面。

此路不通，自然还有其它方法，你可以给链接或者 button 注册一个点击事件，在事件触发后使用 chrome.tabs.create 来创建指向设置页面的新标签页。

```javascript
chrome.tabs.create({ url: 'chrome://extensions/configureCommands' })
```

比如可惜的是，虽然快捷键设置的对话框中，每个快捷键的所在区域的 DIV 标签上都会有唯一的 ID，但使用锚点链接 `chrome://extensions/configureCommandscommand-moemcchllmpolofhmjgmbkfoeinepaln-toggle-link-inspect`依旧无法在打开页面时自动定位到该区域所在位置。

虽然想引导用户修改快捷键的路子不好走，但向用户展示当前可用的快捷键还是可以做到的。

我们可以调用 `chrome.commands.getAll` 来获取扩展定义的快捷键。

```javascript
let linkInspectShortcut

function getLinkInspectShortcut () {
  chrome.commands.getAll(commands => {
    linkInspectShortcut = _.find(commands, { name: 'toggle-link-inspect' }).shortcut
  })
}
```

## 总结

Chrome Commands API 还不完善，虽然提供了一些不错的功能，免去了我们自己开发的功夫，但它其实是把一个扩展的界面强行分割，用户在设置扩展的偏好和设置快捷键的体验是割裂的，而 Chrome 没有提供一个很好的入口方便开发者把用户导向浏览器快捷键设置的页面。虽然有 `chrome://extensions/configureCommands`这个勉强可用的解决方法，但如果想把扩展移植到其它浏览器，比如 Firefox 和 Opera，还需要做一些适配，Opera 需要修改 `chrome://` 为 `opera://`，而 Firefox 没有提供设置快捷键的地方。

如果你的扩展对快捷键有很强的定制要求，那么推荐使用一些成熟的库来定制，如果只是简单的想添加一些基本的快捷键支持，或者想能够全局响应快捷键，那 Chrome Commands 会比较适合你。

## 参考资料

* [chrome.commands](https://developer.chrome.com/apps/commands)
    
* [Assign command keyboard shortcut from popup or options](https://stackoverflow.com/questions/45347403/assign-command-keyboard-shortcut-from-popup-or-options)
