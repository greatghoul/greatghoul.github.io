---
layout: post
title: 缺省语义文件导致润乾报表web应用启动报错
slug: renqian-webapps-exception-on-startup-caused-by-default-semantics-file
date: 2010-11-23 16:01
tags: [java, report]
---

在布署的润乾web发布包启动时，总是报个 **InputStream cannot be null** 异常，但这个异常不影响报表的运行，
即便如此，每次启动时看着一堆stacktrace还是感觉很不舒服。

Stack Trace 详情：

    [2010-11-23 15:25:25] runqianReportLogger : [DEBUG]  - : InputStream cannot be null
    错误来源：InputStream cannot be null
    : InputStream cannot be null
    错误来源：InputStream cannot be null
     at com.runqian.report4.semantics.SemanticsManager.readXMLStream(Unknown Source:174)
     at com.runqian.report4.view.ReportServlet.loadConfig(Unknown Source:364)
     at com.runqian.report4.view.ReportServlet.loadConfig(Unknown Source:95)
     at com.runqian.report4.view.ReportServlet.init(Unknown Source:83)
     (...)
    Caused by: java.lang.IllegalArgumentException: InputStream cannot be null
     at javax.xml.parsers.DocumentBuilder.parse(DocumentBuilder.java:94)
     at com.runqian.report4.semantics.SemanticsManager.readXMLStream(Unknown Source:171)
     ... 30 more
    DEBUG [main] (Unknown Source:22) - : InputStream cannot be null
    错误来源：InputStream cannot be null
    : InputStream cannot be null
    错误来源：InputStream cannot be null
     at com.runqian.report4.semantics.SemanticsManager.readXMLStream(Unknown Source:174)
     at com.runqian.report4.view.ReportServlet.loadConfig(Unknown Source:364)
     at com.runqian.report4.view.ReportServlet.loadConfig(Unknown Source:95)
     at com.runqian.report4.view.ReportServlet.init(Unknown Source:83)
     (...)
    Caused by: java.lang.IllegalArgumentException: InputStream cannot be null
     at javax.xml.parsers.DocumentBuilder.parse(DocumentBuilder.java:94)
     at com.runqian.report4.semantics.SemanticsManager.readXMLStream(Unknown Source:171)
     ... 30 more

错误很明显，缺少语义层文件

    错误来源：InputStream cannot be null
     at com.runqian.report4.semantics.SemanticsManager.readXMLStream(Unknown Source:174)

找到了错误，解决方法就很简单了，指定正确的语义层文件即可。

打开 `WEB-INF` 下面的 `reportConfig.xml` 查找以下XML片断：

在发布报表时，如果没有选择主义层文件，润乾会自动为你生成一个 `/WEB-INF/demo.xml` 的默认值，
而这个文件根本不存在，所以才会报 **InputStream cannot be null** 的异常。
如果应用中没有用到语义层文件， 重新设置正确的文件路径，如果没有用到，将此段代码注释或删除即可。

    <config>
       <name>semanticsFile</name>
       <value>/WEB-INF/demo.xml</value>
    </config>

重启应用，异常排除，控制台又干净了~
