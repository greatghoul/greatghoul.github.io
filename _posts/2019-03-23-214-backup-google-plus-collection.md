---
slug: 214-backup-google-plus-collection
date: '2019-03-23'
layout: post
title: ♥ I Love Pigtails ♥ | 批量下载 Google+ Collection 图片
tags:
  - JavaScript
issue: 214
---

万恶的 Google 又要[关闭 G+](https://seo-hacker.com/google-plus-shutting-down/) 了，双马尾控的建哥在 G+ 上还关注着一个 [♥ I Love Pigtails ♥](https://plus.google.com/collection/IfDvSB) 的 Collection，里面有很多金发+双马尾+好身材的欧美性感妹子图，和亚洲的双马尾完全不一样的风格，真要是关闭了，以后就看不到了。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/7d39191c-48d1-495c-965f-1fc90782c16e)

**可恶，得想办法把这些妹子取回家！**。

然而 Google 提供的工具却只支持下载自己的数据，别人的数据，就没有什么好的办法了，大致的找了一个，没有什么趁手的工具，这时就需要用爱发电，自己创造工具了。

数据抓取，成本最小的，应该就是 DevTools Console 运行 JavaScript 了，不需要安装什么额外的编程环境，只要拿到所有的图片链接，剩下的事情就简单了。

Google Plus 是瀑布流式加载的，所以只要不断的把页面向下滚动，就可以拿到所有数据了，但是张张手动保存是不现实的，这里就需要编程了。

```javascript
(function() {
  const images = [];

  const timer = window.setInterval(() => {
    window.scrollBy({ top: 2000, behavior: 'smooth' });
    const imageElements = document.querySelectorAll('img[alt="Photo"]');
    for (let imageElement of imageElements) {
      images.push(imageElement.src);
      document.title = images.length;
      imageElement.remove();
    }
    console.log(`${images.length} at ${new Date()}`);
  }, 3000);

  window.printImages = () => {
    window.clearInterval(timer);
    console.log(images.join("\n"));
  };
})();
```

在打开的 Google Plus 页面的 JavaScript Console 中运行上面的代码，它做了下面几件事。

1. 每 3 秒把把滚动条向下拉一些，触发瀑布流的“加载更多”动作
    
2. 每次滚动后找到所有照片的 img 标签，取到图片 url 后立即删除图片，避免加载等待浪费时间
    
3. 每次滚动后把取到的图片数量写在网页标题里面，便于观察
    
4. 加载了 Collection 中所有的 Post 后（标题中计数停止，或者页面底部显示没有更多记录），在控制台执行 `window.printImages()` 输出所有的图片 url
    

最后得到这样的结果

```
https://lh3.googleusercontent.com/-aTqAXM2yNBk/XGO2AbuCRII/AAAAAAAF1DI/MEUyqicEA1QWtkVjzj5StgKQHcaZ5w23ACJoC/w530-h942-n-rw/29c5149a-a50e-4674-bd03-d9604852f7ff
https://lh3.googleusercontent.com/-gDGFzfVXG0U/W_OkIsV307I/AAAAAAAFt2M/lsyCaag9p3wJ39n7jiUHtF3IRMP1e5aHgCJoC/w530-h795-n-rw/001
https://lh3.googleusercontent.com/-Axm9bkR4rZY/W77pVTvB1eI/AAAAAAAFljI/eKp5glhZpt0qjNiQtllJjySvaFF_3keQgCJoC/w530-h942-n-rw/9d5387a9-a502-4559-a2b0-07b9f26398ac
....
```

接下来就是批量下载了，我的电脑上装有 [FDM](https://www.freedownloadmanager.org/)，所以我直接用它下载，你当然也可以换成其它批量下载的方法。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/bdf4939d-fcf3-412f-90cb-58deed30fa9f)

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/227fdea1-02d5-4e21-8932-7653ca35b4cf)

下载完成后遇到一个小问题，下载的图片都是 webp 格式，这个格式在 macOS 下面是没有办法预览的，你需要安装一个插件。

https://github.com/emin/WebPQuickLook

```bash
curl -L https://raw.github.com/emin/WebPQuickLook/master/install.sh | sh
```

至此，发电完成。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/e138f8c0-3c4f-4ac6-a83f-c960af9b1b21)
