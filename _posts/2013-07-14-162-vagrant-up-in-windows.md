---
slug: 162-vagrant-up-in-windows
date: '2013-07-14'
layout: post
title: Windows 下配置 Vagrant 环境
tags:
  - Tool
  - Windows
issue: 162
---

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/764321df-cc0a-4cf2-b2b8-b54d8af56ef8)

[Vagrant] 是一个基于 Ruby 的工具，用于创建和部署虚拟化开发环境。它使用 Oracle 的开源 [VirtualBox] 虚拟化系统。

Vagrant 在快速搭建开发环境方面是很赞的，试想一个团队中，大家开发同一个东西，以前每个人都要自己搭建一套开发环境
，有了 Vagrant，你只需要搭建一份，然后分发给所有团队成员，这样大家都立刻就有完全相同的开发环境了，即便有成员在
Windows 下，也可以方便的使用 Linux 环境开发。如果团队中来了新人，也不需要手把手教他怎么搭建开发环境，给他丢一个
Box 就好了，只要他掌握了 Vagrant 的使用方法，立刻就可以融入到开发中来，而不需要费心去安装复杂的环境。

Vagrant 的跨平台的特性简直是太棒了，这都要利益于 VirtualBox 这样一款优秀的软件和 Vagrant 这些天才工程师们。

Vagrant 还支持使用 [Chef] 和 [Puppet] 来维护你的虚拟开发环境，不过因为我对这两个工具并不熟悉，本文中不作介绍，只简单
介绍如果在 Windows 下配置一个 Vagrant 环境。

[Vagrant]: http://www.vagrantup.com/
[VirtualBox]: https://www.virtualbox.org/
[Chef]: http://www.opscode.com/chef/
[Puppet]: https://puppetlabs.com/

安装 Vagrant
-------------------

从 Vagrant 官网下载最新的 Vagrant 和对应的 VirtualBox 安装后，新建一个文件夹用来配置 Vagrant

因为使用 `vagrant init precise32 http://files.vagrantup.com/precise32.box` 命令下载 box 会比较慢，
所以最好是提前使用迅雷等工具下载好 box 放在一个文件中，然后初始化时使用本地路径，会快很多。

    vagrant init precise32 ..\boxes\precise32.box

需要注意的是，这里使用本地路径时，需要使用 Windows 风格的路径，即用 `\` 来作为路径分隔符。

**PS:** 可用的 Vagrant Boxes 见这里：<http://www.vagrantbox.es/>

端口转发
------------

Vagrant 中配置端口转发非常方便

    Vagrant.configure("2") do |config|
      # other config here

      config.vm.network :forwarded_port, guest: 80, host: 8080
    end

上面的配置会将 Vagrant 中的 80 端口和你本机的 8080 端口建立转发关系，这样你在本机访问 http://localhost:8080 
就相当于访问 Vagrant 中的 http://localhost:80 了。

**端口转发可以配置多组。**

共享文件夹
------------

使用 Vagrant 有一个非常重要的一步就是共享文件夹（得益于强大的 VirtualBox）

在 `Vagrantfile` 中设置

    config.vm.synced_folder "E:/Blog", "/home/vagrant/Blog"

其中第一个参数 `E:/Blog` 为本机上需要共享的文件夹路径，第二个参数为 Vagrant 虚拟机中的映射路径，注意第二个参数需要
使用绝对路径，如 `/home/vagrant/Blog`

连接至 Vagrant
----------------

配置好后，就可以启动虚拟机并连接到 Vagrant 了。

首先，执行 `vagrant up` ，等待片刻，vagrant 就启动好了。 ::

    e:\Vagrant\precise32>vagrant reload
    [default] Attempting graceful shutdown of VM...
    [default] Setting the name of the VM...
    [default] Clearing any previously set forwarded ports...
    [default] Creating shared folders metadata...
    [default] Clearing any previously set network interfaces...
    [default] Preparing network interfaces based on configuration...
    [default] Forwarding ports...
    [default] -- 22 => 2222 (adapter 1)
    [default] -- 5000 => 5000 (adapter 1)
    [default] -- 3000 => 3000 (adapter 1)
    [default] Booting VM...
    [default] Waiting for VM to boot. This can take a few minutes.
    [default] VM booted and ready for use!
    [default] Configuring and enabling network interfaces...
    [default] Mounting shared folders...
    [default] -- /vagrant
    [default] -- /home/vagrant/Blog
    [default] -- /home/vagrant/Notes
    [default] -- /home/vagrant/Projects

如果你 ``vagrant up`` 后又修改了 Vagrantfile，要使之生效，需要执行 ``vagrant reload``

在 Windows 下，不能使用 `vagrant ssh` 来直接访问 vagrnat，不过该命令会告诉你如何通过 ssh 连接 vagrant ::

    e:\Vagrant\precise32>vagrant ssh
    `ssh` executable not found in any directories in the %PATH% variable. Is an
    SSH client installed? Try installing Cygwin, MinGW or Git, all of which
    contain an SSH client. Or use the PuTTY SSH client with the following
    authentication information shown below:

    Host: 127.0.0.1
    Port: 2222
    Username: vagrant
    Private key: C:/Documents and Settings/greatghoul/.vagrant.d/insecure_private_key

这样你就可以使用类似 putty 的 ssh 客户端来访问 vagrant 来进行开发了，这里极力推荐 Chrome 扩展 [Secure Shell]

[Secure Shell]: https://chrome.google.com/webstore/detail/pnhechapfaindjhompbnflcldabbghjo?utm_source=chrome-ntp-launcher

