---
title: LayoutManager删除Component的的误区
slug: java-swing-removelayoutcomponent
date: 2009-03-23 19:39
tags: [java, swing]
---

最近在写ui时，一时糊涂，用 `LayoutManager` 的 `removeLayoutComponent` 方法移除组件，结果组件是移除了，但重新在容器内添加新组件内，显示的竟然还是原来的（我的布局是 `BorderLayout` )，起初还以为是界面没更新了，折腾了半天，重新查API，结果找到了原因。

> BorderLayout (Java 2 Platform SE 6)

> **removeLayoutComponent**
>
> **public void removeLayoutComponent(Component comp)**
>
>   从此边框布局中移除指定组件。当容器调用其 remove 或 removeAll 方法时，可调用此方法。大多数应用程序并不直接调用此方法。
>
>   **指定者：**
>
>   接口 LayoutManager 中的 removeLayoutComponent
>
>   **参数：**
>
>   comp - 要移除的组件。
>
>   **另请参见：**
>
>   Container.remove(java.awt.Component), Container.removeAll()

从布局中移除指定组件，也就是说并没有从容器中移除。所以还是建议使用容器的 `remove` 方法移除组件，以保万无一失。
偶然遇到这样的情况，和大家分享下。
