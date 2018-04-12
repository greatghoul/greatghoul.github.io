---
layout: post
title: 同步 Chrome 扩展的用户偏好
slug: sync-chrome-extension-options
date: 2014-08-02 10:22
tags: chrome-extension
---

![Chrome Dev](http://pic.yupoo.com/greatghoul_v/DX0sH1zD/lKBwV.png)

我在之前介绍过一些 Chrome 扩展的[特性][1]，而 [Storage][2] 就是其中之一，
**Storage** 允许将一些数据同步到用户的 Google 帐户中，这是一个非常棒的特性，
即使它的存储容量[非常有限][3]。

Storage 一个非常典型的应用场景就是**保存用户偏好**，如果我们开发的应用定制性很强，
有了 Storage 这个利器，用户更换了机器，就不需要再重新定制一次了，真是太方便了。

那么如何使用 Storage 来同步用户的偏好数据呢？本文就以 [TransIt] 为例，抛砖引玉。

## 需要实现的效果

扩展中的用户数据同步，包括两个方面：

1. 用户不同设备间的数据同步
2. 扩展内部不同页面的数据同步

第一点直接使用 Storage 的 API 就能实现，但第二点却需要自己做许多工作了，它包括：

- 背景页面 (Event Page / Background Page)
- 设定页面 (Options Page)
- 弹出窗口 (Browser Action Popup)
- 页面脚本 (Content Script)
- 其它非标准页面

其中任意一个页面的偏好数据更改后，其它页面会自动同步，还有一个好处就是，
扩展在一个页面改了偏好后，扩展的其它页面不需要刷新就可以用到最新的偏好。

## 定义用户数据的默认值

默认值很重要，因为扩展数据同步也会有时间花费，这此之前，扩展要正常工作，
在数据同步完之前，用户就会使用默认值作为偏好运行扩展。

默认值会被定义在全局的命名空间上，方便直接引用。

    // application.js
    
    var options = {
        notifyTimeout: 5,     // 页面划词结果显示时间
        pageInspect: true,    // 是否启用页面划词
        linkInspect: true,    // 是否启用链接划词
        pushItem: false,      // 是否推送单词到服务端
        notifyMode: 'margin', // 结果默认显示在右上角
    };

将这个脚本在每个扩展页面都引用，这样在任意页面都可以直接使用 `options.optionName`
来取得偏好值了。要让 `options` 的值为用户的最新设置，下面会介绍到。

## 同步数据到服务器

扩展运行时，应该先从服务器取得最新的数据，再与默认值合并，然后重新推回给服务器。
这样做有个好处：如果我们的扩展增加了一个配置项（在默认值里），那新的配置项不会被服务器数据覆盖掉，
新增加的项也会立即作为更新后的数据重新推送并与其它设备保持同步。

    // 从 storage 中读取配置，如果没有配置，则初始化为默认值
    function initOptions(callback) {
        chrome.storage.sync.get(null, function(data) {
            $.extend(options, data);
            chrome.storage.sync.set(options);
            callback && callback();
        });
    }

为了确保使用最新的配置数据运行扩展，读取服务器数据的方法中可以加入一个回调，
保证在取完数据后再执行扩展里的逻辑，类似 [jQuery.ready]。

    initOptions(function() {
       // do something with options 
    });

## 同步用户数据到扩展各页面

因为 Storage API 的取值方法是异步的[回调模式][storage.get]，没有办法像取
`localStorage` 那样直接使用 `localStorage['optionName']` 来获取数据，
但是如果每次如果使用回调的方法，又不免太麻烦了。

    chrome.storage.sync.get('pageInspect', function(data) {
        console.log(data.pageInspect);
    });

试想每次要取个值都要来上这么一段，还必须在回调里面再处理后面的逻辑！

![](http://pic.yupoo.com/greatghoul_v/DX0cnm1Y/133eUr.png)

所以，需要这样一种机制，任务页面修改一个配置项，则直接将其推送服务器，像这样。

    options.optionName = ‘new Value;
    chrome.storage.sync.set(options);

然后其它页面利用 [storage.onChanged] 事件来获取变更内容，覆盖页面中的 options 对应的项。
这样不需要手动从服务器取值。

    // 监听设置项的变化
    chrome.storage.onChanged.addListener(function(changes) {
        for (var name in changes) {
            var change = changes[name];
            options[name] = change.newValue;
        }
    });

这样直接引用 `options.optionName` 就可以拿到最新的内容了。简直就和使用 `localStorage` 一样，
甚至更加便利。

## 在扩展各页面中加入同步的处理

当然，这段监听的调用需要遍布扩展的各个页面。将处理同步的相关代码放入一个单独的 JS 文件中，
比如 `application.js`。
    
    var options = {
        notifyTimeout: 5,     // 页面划词结果显示时间
        pageInspect: true,    // 是否启用页面划词
        linkInspect: true,    // 是否启用链接划词
        pushItem: false,      // 是否推送单词到服务端,
        notifyMode: 'margin', // 结果默认显示在右上角
    };
    
    // 从 storage 中读取配置，如果没有配置，则初始化为默认值
    function initOptions(callback) {
        chrome.storage.sync.get(null, function(data) {
            $.extend(options, data);
            chrome.storage.sync.set(options);
            callback && callback();
        });
    }
    
    // 监听设置项的变化
    chrome.storage.onChanged.addListener(function(changes) {
        for (var name in changes) {
            var change = changes[name];
            options[name] = change.newValue;
        }
    });

对于 Background Page 和 Content Scripts，直接在 `manifest.json` 中指定就可以了。

    {
      "background": {
        "scripts": [
          "js/application.js",
          "js/event.js"
        ],
        "persistent": true
      },
      
      "content_scripts": [
        {
          "matches": ["<all_urls>"],
          "js": [
            "application.js",
            "contentscript.js"
          ],
          "all_frames": true
        }
      ],
       
      "permissions": [
        "tabs",
        "storage"
      ]
    }

**不要忘记在 `permissions` 里加入 `storage` 权限。**

其它页面，则可以直接在其 HTML 文件中引用脚本。

    <script type="text/javascript" src="application.js"></script>

然后在各个页面的处理脚本中，这样使用

    initOptions(function() {
       // do something with options 
    });

[1]: https://github.com/greatghoul/slides/blob/master/charming-chrome-extension-features/slides.md
[2]: https://developer.chrome.com/extensions/storage
[3]: https://developer.chrome.com/extensions/storage#property-sync-QUOTA_BYTES

[TransIt]: https://github.com/GDG-Xian/crx-transit
[storage.get]: https://developer.chrome.com/extensions/storage#method-StorageArea-get
[jQuery.ready]: http://api.jquery.com/ready/
[storage.onChanged]: https://developer.chrome.com/extensions/storage#event-onChanged