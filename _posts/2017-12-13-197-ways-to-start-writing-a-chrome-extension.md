---
slug: 197-ways-to-start-writing-a-chrome-extension
date: '2017-12-13'
layout: post
title: 开始写一个 Chrome 扩展的 N 种姿势
tags:
  - Chrome Extension
issue: 197
---

想不想在浏览器上加一个小功能方便自己的日常使用？ 想不想改变一下经常访问的网站页面内容或者样式以适合自己阅读？ 找不到符合自己需要的现成的浏览器扩展？也许你根本不需要别人， 稍微掌握一些 Web 开发的知识，你可能自己就能解决自己的需求！ 从简单到复杂，从小白到大师，我这里有各种入门扩展开发的姿势， 你一定可以找到适合自己的姿势，轻松的打造一个属于自己的扩展。

## 小书签

写一个 Chrome 扩展最简单的方法，大概就是 [Bookmarklet](https://zh.wikipedia.org/zh-cn/%E5%B0%8F%E4%B9%A6%E7%AD%BE) 了。

> **小书签**（bookmarklet），又叫**书签小程序**，是以网址的形式被存为浏览器中的书签，一般由 JavaScript 编写，在用户点击时，小书签会执行一些诸如搜索，导出数据的操作。

比如你可以直接在浏览器地址栏里面执行下面的代码：

```
javascript:alert('Hello World');
```

这是最简单的情况，为了防止全局变量污染，小书签的代码一般会被包含在一个闭包中。

```js
(function() {
  alert("Hello World!");
})()
// javascript:(function()%7Balert(%22Hello%20World!%22)%7D)()
```

例如：[缩短网址](http://codepen.io/greatghoul/full/bBzLXW/)

推荐一个在线制作小书签的工具：[Bookmarklet Creator with Script Includer](http://mrcoles.com/bookmarklet/)

## 使用 Stylish

如果你只想改变一下某个网站的样式，虽然用小书签也可以做到，但需要每次点击才行，这种情况下，更合适的一个选择是 [Stylish](https://chrome.google.com/webstore/detail/stylish/fjnbnpbmkenffdnngjfgmeleoegfcffe?hl=zh-CN)。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/8cbe810d-c30b-4282-853c-94c448a1f67c)

只要会写 css，就可以把网页定制成自己想要的样子，你也可以在 [userstyles](https://userstyles.org/) 网站寻找优秀的作品。

## 使用 TamperMonkey

与 Stylish 类似，你不但可以改变一个网页的样貌，还可以改变它的行为，[TamperMonkey](https://chrome.google.com/webstore/detail/tampermonkey/dhdgffkkebhmkfjojejmpbldmpobfkfo) 会是一个不错的选择。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/b586dd15-9ec9-464f-bc57-0cd3586ffb6d)

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/d18cf8de-f99b-4ac7-99bb-4dd9bcd3646e)

你除了发挥自己的 JavaScript 能力自己写，也可以在[这个页面](http://tampermonkey.net/scripts.php)提供的网站中寻找优秀的作品直接安装，或者在其基础上改写。

## 自己动手，从 0 开始开发

以上介绍的都不是真正意义上独立的扩展，如果你想写一个真正的 Chrome 扩展，那就得自己动手，从 0 开始了。

Chrome 官方有非常不错的入门教程：[Getting Started: Building a Chrome Extension](https://developer.chrome.com/extensions/getstarted) ，如果你是防火墙的受害者，也可以通过图灵的免费电子书来学习扩展开发：[Chrome扩展及应用开发（首发版）](http://www.ituring.com.cn/book/1421)。

开始写一个扩展，大致需要以下的步骤：

1. 建立一个文件夹，比如 MyFirstExtension
    
2. 在文件夹中建立一个 manifest.json 文件，按 Chrome 要求的格式填写扩展的名称，描述，版本，页面以及权限等信息
    
3. 编写扩展需要的脚本（比如 contentscript 和 event page script）和页面（比如 popup 和 options page）
    
4. 在 Chrome 扩展管理中打开开发者模式，载入开发中的扩展
    
5. 其它修改
    

这些步骤并不复杂，但却是必须的。

## 使用可定制的模板

如果你是一个新手，对于一个扩展需要怎样组织文件，页面和脚本又怎么联系不是很清楚，你可以阅读教程来一步步的操作，但如果你已经差不多熟悉了扩展的开发，每次开发一个新扩展，都需要做一系列重复的步骤，大概也会觉得麻烦。

当然，有人同样觉得麻烦，并且已经动手解决了，[Extensionizr](http://extensionizr.com/) 就是这样一个让人省心的工具，它是一个 Web 应用，你只需按自己的需求勾勾选选，然后点击下载按钮，就可以得到一个已经建立好了所有必要文件，并且结构良好的压缩包，解压它就可以直接开始动手编码，省去了建立文件和结构的过程。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/a7b9562b-877e-425e-ad26-1f27c6345975)

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/7caee0c8-5e11-4648-bab7-928518acbd9a)

## 使用生成器

对于一个专业的前端，可能会选择基于 gulp+babel+sass 来构建一个应用程序，但编写一个适配 Chrome 扩展的 gulpfile 并不轻松，你需要编写很多 tasks。JavaScript 世界优秀的工程师们自然不会对这种重复工作视而不见，感谢 [yeoman](http://yeoman.io/) ，提供了各种各样方便的生成器，这里面当然也包括 Chrome Extension 生成器。

```
npm install --global yo gulp-cli bower

# Install the generator:
npm install -g generator-chrome-extension

# Make a new directory, and `cd` get into it:
mkdir my-new-chrome-extension && cd $_

# Generate a new project
yo chrome-extension
```

## 直接改别人的扩展

如果你不想从头实现一个扩展，而只是希望对现有的扩展进行修改以满足你自己的需要，你可以获取扩展的源码，然后修改它，直到变成你喜欢的样子。

如果这个扩展并没有开源，你可以直接[在电脑上寻找](http://www.howtogeek.com/255653/how-to-find-your-chrome-profile-folder-on-windows-mac-and-linux/)它的源码尝试修改

Windows 7, 8.1, and 10:

```
C:\Users\<username>\AppData\Local\Google\Chrome\User Data\Default
```

Mac OS X El Capitan:

```
/Users/<username>/Library/Application Support/Google/Chrome/Default
```

Linux:

```
/home/<username>/.config/google-chrome/default
```

如果这个扩展是开源的，你大可以 Fork 然后修改，甚至最近提交一个 Pull Request。

我有在整理一个中文 Chrome 开源扩展的列表，你或许会感兴趣：

https://github.com/GDG-Xian/OpenSourceChromeApps-CN
