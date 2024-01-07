---
slug: 228-windows-vscode-port-forwarded
date: '2021-05-01'
layout: post
title: 解决 Windows 下 VS Code 总是把 3000 端口转发到 3001 的问题
tags:
  - Windows
  - VS Code
issue: 228
---


我在 Windows 上面用 VS Code + Remote SSH 在开发 Rails 应用时，端口总被转发到 3001，我就很奇怪，3000 被占用了？试了其他端口，都很正常。而且用 3000 也依然能够访问转发的应用，这就很奇特了。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/1475e228-06f1-4cfd-8c6f-a6fbb5dad2e9)

查看占用端口的进程

```erb
netstat -aon|findstr "3000"
```

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/1b5cd26d-225e-40da-b13c-946c0d65d107)

再查看进程对应的应用

```erb
tasklist |findstr "9236"
```

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/912308e7-b5e0-421c-9a85-a65080953650)

发现竟然是 VirtualBox，简单的搜索了下，终于找到了地方，我之前在配置时，有常识在 VirtualBox 上面配置端口映射，但是没有移除。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/fe1e68df-6a72-4fb6-95f8-2e2cc0e2a16a)

删除这一条记录后，回归正常。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/70f576fd-0bcf-4f6a-b95b-60aced9d8faf)

参考链接

* [Windows下如何查看某个端口被谁占用 | 菜鸟教程](https://www.runoob.com/w3cnote/windows-finds-port-usage.html)
    
* [php - How do I stop VirtualBox from running on localhost:8000? - Stack Overflow](https://stackoverflow.com/questions/43783497/how-do-i-stop-virtualbox-from-running-on-localhost8000)
