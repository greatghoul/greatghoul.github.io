---
title: swing中JTabbedPane的例子
slug: simple-swing-jtabbedpane
date: 2011-09-14 23:48
tags: [java, swing]
---

其实swing中一些组件的使用其实也挺简单的，比如 JTabbedPane，

下面是一个简单的例子，呈现三个标签页，没有时间，默认样式和布局：

    import javax.swing.JFrame;
    import javax.swing.JLabel;
    import javax.swing.JTabbedPane;

    public class JTabbedPaneTest extends JFrame {
        public JTabbedPaneTest() {
            super("JTabbedPane Test");
            setDefaultCloseOperation(EXIT_ON_CLOSE);
            setSize(400, 300);

            JTabbedPane book = new JTabbedPane();
            book.addTab("Tab 1", null, new JLabel("Tab 1 Content"), "Tab 1");
            book.addTab("Tab 2", null, new JLabel("Tab 2 Content"), "Tab 2");
            book.addTab("Tab 3", null, new JLabel("Tab 3 Content"), "Tab 3");

            add(book);
        }

        public static void main(String[] args) {
            JTabbedPaneTest test = new JTabbedPaneTest();
            test.setVisible(true);
        }
    }

**效果：**

![JTabbedPane](http://pic.yupoo.com/greatghoul_v/BmURmpc6/NiAMV.png)

PS: 使用 javac 编译 java 文件时，如果文件编码与操作系统编码不同的，可以使用 encoding 参数来指定编码，还可以使用 `&&` 
一行中执行两条命令，编译运行一次搞定。

    javac -encoding utf-8 JTabbedPaneTest.java && java JTabbedPaneTest

