---
title: SkillPages利用用户授权滥用联系人信息
slug: skillpages-sucks
date: 2013-03-07 12:56
tags: [oauth2, google, spam]
---

早上收到社区里面有位朋友的 [Skillpages][^1] 邀请，于是赶紧就注册了，结果因为一时不慎着了道。

![邀请信内容](http://pic.yupoo.com/greatghoul_v/CGZq81LF/MOK4Y.png)

如果使用 Google OAuth2 登陆 SkillPages，在授权时请求了很多权限，但因为没有仔细阅读权限列表，结果害人害已。

![授权页面](http://pic.yupoo.com/greatghoul_v/CGZq6XPE/Hy1I8.png)

> **skillpages.com is** requesting permission to:
> 
>  1. Manage your contacts
>     * **View and manage your Google Contacts**
>  2. View basic information about your account
>     * View your name, public profile URL, and photo
>     * View your gender and birthdate
>     * View your country, language, and timezone
>  3. View your email address
>     * View the email address associated with your account

其中 **View and manage your Google Contacts** 这一项非常危险，它授权应用完全控制你的联系人，不但能拿你所有
联系人的信息，还可以管理你的联系人，换句话说，就是把你的联系人全部删除，你也没有脾气。

SkillPages 拿到联系人数据后，以使用者的身份，随机向其联系人发送邀请邮件，目前为止，我已经有4位朋友被我牵连，
然后他们也会循环这个过程。

![联系人中招](http://pic.yupoo.com/greatghoul_v/CGZq8RDt/OU51l.png)

想象一下，这个连锁效应其实很可怕，最后 SkillPages 能够拿到的联系人信息的数量是非常巨大的，然后他们就可以：
发送推广广告、虚假中奖信息及钓鱼网站等。

今天早上我还接到了润乾公司售前的电话，询问我发给她的邮件是什么东西，如果这样的事件再多几件，会害死人的。

虽然你可以通过 SkillPages 的设置页面将自己的帐户永久删除，或者通过 Google 的应用授权管理页面移除对 SkillPages 
的授权，但其实已经迟了，他们已经拿到了想要的东西。

对于通过用户邮箱联系人邀请用户这样的行为，正规网站的作为是让用户主动去选择邀请哪些朋友，毕竟邀请邮件发送到一些
邮件列表的后果是非常严重的，好在 SkillPages 只是伪造使用者姓名，而不是直接拿使用者的邮件发送邀请邮件，可能对一些
邮件列表还无法染指。

最近再来联想下国内一些第三方登陆的应用，会不会也出来像 SkillPages 这样的流氓行为？

或者是否应该有这样一款 Chrome 扩展，能够在授权操作时醒目的提示出那些可能比较危险的授权，或者能够大家共享一份用授权
胡作非为的网站的黑名单，用户在访问时能够提前得到预警，以避免损失。

[^1]: http://www.skillpages.com/

