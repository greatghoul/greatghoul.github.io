---
title: Java启动画面类
slug: java-splash-window
date: 2009-02-23 19:13
tags: [java, swing]
---

最近编写了几个 java 桌面程序,打成jar后启动速度不是很理想,很长一段时间主窗口才能完全加载，于是想到加一个启动画面。
在网上找了好久也没有找到一个满意的，于是自已写了一个，虽然简陋，但好歹可以用。

**构造方法：**

    public GSplashWindow(String imgPath) 通过路径构造
    public GSplashWindow(Image bgImage)  通过图像对象构造

**方法：**

    public void start() 显示启动画面
    public void end() 销毁启动画面
    public void setStatus(String statusText) 设置状态信息

**完整代码：**

    import java.awt.BorderLayout;
    import java.awt.Color;
    import java.awt.Dimension;
    import java.awt.Graphics;
    import java.awt.Image;
    import java.awt.Toolkit;
    import javax.swing.BorderFactory;
    import javax.swing.ImageIcon;
    import javax.swing.JLabel;
    import javax.swing.JPanel;
    import javax.swing.JWindow;

    /**
     * 启动画面类
     * 
     * @author GreatGhoul
     */
    public class GSplashWindow extends JWindow {

        /** 当前状态信息 */
        JLabel status = null;

        /** 背景图像 */
        private Image bgImage = null;

        /**
         * 通过路径构造启动画面
         * 
         * @param imgPath 背景图像路径
         */
        public GSplashWindow(String imgPath) {
            this.bgImage = new ImageIcon(imgPath).getImage();
            initComponents();
        }

        /**
         * 通过图像对象构造启动画面
         * 
         * @param bgImage 背景图像对象
         */
        public GSplashWindow(Image bgImage) {
            this.bgImage = bgImage;
            initComponents();
        }

        private void initComponents() {
            // 获取图片尺寸
            int imgWidth = bgImage.getWidth(this);
            int imgHeight = bgImage.getHeight(this);

            // 设置窗口大小
            setSize(imgWidth, imgHeight);

            // 设置窗口背景
            JPanel background = new JPanel() {
                protected void paintChildren(Graphics g) {
                    g.drawImage(bgImage, 0, 0, this);
                    super.paintChildren(g);
                }
            };
            background.setLayout(new BorderLayout());
            setContentPane(background);

            // 设置窗口位置 
            Toolkit toolkit = Toolkit.getDefaultToolkit();
            Dimension scmSize = toolkit.getScreenSize();
            setLocation(scmSize.width / 2 - imgWidth / 2, 
                    scmSize.height / 2 - imgHeight / 2);

            // 加入状态条
            status = new JLabel("状态条..........", JLabel.RIGHT);
            status.setForeground(Color.WHITE);
            status.setBorder(BorderFactory.createEmptyBorder(4, 4, 4, 4));
            getContentPane().add(status, "South");
        }

        public void start() {
            setVisible(true);
            toFront();
        }

        /**
         * 设置状态信息
         * 
         * @param statusText 状态信息
         */
        public void setStatus(String statusText) {
            status.setText(statusText);
        }

        public void stop() {
            setVisible(false);
            dispose();
        }
    }
