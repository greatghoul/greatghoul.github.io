---
layout: post
title: 润乾报表中文参数乱码
slug: reqian-report-messy-code
date: 2010-11-23 14:37
tags: [java, report]
---

由于在[润乾报表][^1]中用到了超链接链到另一张报表，链接中有传递中文参数。

在设计器的IE预览中，参数传递均正常，但是布署到服务器后，中文变成了乱码，更改 `reportConfig.xml` 中的字符集，亦无济于事，客户等着要东西，只能更改`showReport.jsp` ，强制转换编码格式（我这里使用的是GBK）。

    /*/
    String paramName  = (String) paramNames.nextElement();
    String paramValue = request.getParameter(paramName);
    /*/
    String paramName  = new String(((String) paramNames.nextElement()).getBytes("iso-8859-1"), "GBK");
    String paramValue = new String(request.getParameter(paramName).getBytes("iso-8859-1"), "GBK");
    System.out.println(paramValue);
    //*/

不过说实话，这种处理方式让人很蛋疼，[官方似乎也推荐的这种方式][^1]。很奇怪为什么设计器中的 **IE中预览报表** 就正常呢，
难说是它在 tomcat 中有什么配置？因为我我服务器上布署的应用完全是设计器中IE预览使用的应用的一份拷备而已。

**PS:** 代码中的注释方式简直就是艺术，只需要把第一个注释在 `/*/` 和 `//*/` 之间切换，就可以快速地在两段代码之间切换，
从[师傅][^3]那里学来的。

[^1]: http://www.runqian.com.cn
[^2]: http://www.runqian.com.cn/archives/28.html "润乾报表参数传入时产生中文乱码 - 润乾报表知识库"
[^3]: http://hexun.com/okhaoba/default.html "Java Study @okhaoba"

