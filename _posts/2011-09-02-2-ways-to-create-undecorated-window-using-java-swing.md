---
layout: post
title: Swing无边窗口的两种实现
slug: 2-ways-to-create-undecorated-window-using-java-swing
date: 2011-09-02 15:16
tags: [java, swing]
---

在使用 swing 编写java桌面应用的时候，有时会需要使用无边窗口，比如 [SplashWindow][1]。

这里介绍两种无边窗口的实现方法：

方法1：使用JFrame，并隐藏标题和边框
-------------------------------------

JFrame 在隐藏标题后可以模拟出无边的效果，这里会用到 [JFrame][2] 的 `setUndecorated()` 方法。

    import java.awt.Color;

    import javax.swing.BorderFactory;
    import javax.swing.JFrame;
    import javax.swing.JPanel;

    public class UndecoratedFrame extends JFrame {
        public static void main(String[] args) {
            UndecoratedFrame test = new UndecoratedFrame();

            JPanel panel = new JPanel();
            panel.setBorder(BorderFactory.createLineBorder(Color.BLUE, 5));
            test.add(panel);

            test.setSize(600, 400);
            test.setDefaultCloseOperation(EXIT_ON_CLOSE);
            test.setLocationRelativeTo(null);
            test.setUndecorated(true); // 必须在窗口显示前调用
            test.setVisible(true);
        }
    }

方法2：直接使用 JWindow 构建无边窗口
----------------------------------------

[JWindow][3] 本来就没有标题栏和边框，拿来直接用就好了。

    import java.awt.Color;

    import javax.swing.BorderFactory;
    import javax.swing.JWindow;
    import javax.swing.JPanel;

    public class UndecoratedWindow extends JWindow {
        public static void main(String[] args) {
            UndecoratedWindow test = new UndecoratedWindow();

            JPanel panel = new JPanel();
            panel.setBorder(BorderFactory.createLineBorder(Color.BLUE, 5));
            test.add(panel);

            test.setSize(600, 400);
            test.setLocationRelativeTo(null);
            test.setVisible(true);
        }
    }


[1]: http://www.g2w.me/2011/07/java-splash-window/
[2]: http://download.oracle.com/javase/6/docs/api/javax/swing/JFrame.html
[3]: http://download.oracle.com/javase/6/docs/api/javax/swing/JWindow.html
