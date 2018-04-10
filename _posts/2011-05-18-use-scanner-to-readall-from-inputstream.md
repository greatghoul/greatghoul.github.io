---
title: 巧用Scanner读取输入流中的所有内容
slug: use-scanner-to-readall-from-inputstream
date: 2011-05-18 13:18
tags: [java]
---

使用 python 后，觉得读写文件非常方便，偶尔用到 java IO 时就开始头疼，想要一次性从输入流中读取全部内容，还挺费事。

折腾了一阵，终于找到了解决方法： `java.util.Scanner`

> **useDelimiter**  
> public Scanner useDelimiter(String pattern)
> Sets this scanner's delimiting pattern to a pattern constructed from the specified `String`.
> An invocation of this method of the form `useDelimiter(pattern)` behaves in exactly the same way as the 
> invocation `hasDelimiter(Pattern.compile(pattern))`.
>
> **Parameters:**  
> `pattern` - A string specifying a delimiting pattern  
> **Returns:** this scanner

如果将 delimeter 设置为文末，不就一次性取得所有的内容了。

    URL url = new URL("http://www.g.cn/");
    Scanner sc = new Scanner(url.openStream());
    sc = sc.useDelimiter("$");
    String content = sc.next();
