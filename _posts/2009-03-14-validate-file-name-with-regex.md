---
layout: post
title: 用正则验证文件名是否合法(仅限win平台)
slug: validate-file-name-with-regex
date: 2009-03-14 19:30
tags: [java, regex, windows]
---

的 java 中用到文件操作时，经常要验证文件名是否合法。
我以前都是用 `File` 类的 `createNewFile()` 方法。当然，这个方法的确很管用，但当要批量验证时，总不能一个个创建文件吧。

于是想到了正则, 正则匹配的开销比创建文件小了不知道多少倍。Google 了一下 Windows 平台的文件名规则，并实践了一下.

![文件名](http://pic.yupoo.com/greatghoul_v/BcHkr5xV/r9vZS.jpg)

那么一个合法的文件应该符合如下规则。


 1. 文件名不能为空,空在这里有两个意思
   * 文件名(包括扩展名)长度为 0 或仅由空字符组成(包括 `\t\b` 等不可见的转义字符)
   * 文件名和扩展名不能同时为空。但实际上我们可以用程序创建出类似 `.project,..txt` 等形式的文件，但却创建不出类似 
     `abc.`的文件也不能被创建
 2. 文件名中不能包含 `\/:*?"<>|` 中的任意字符
 3. 文件名(包括扩展名)的长度不得大于 255 个字符

事实上形如 `..` 的文件也不能被创建.
不合法的文件还有类似 ` aa`, `aa `, `aa.` (会被创建为 `aa`, 也把它算作不合法), 
`a\ta`(`\t`为制表符等不可见字符(除空格外))

于是我们得到了文件名命名规则的更详细规定:

 1. 首尾不能有空字符(空格、制表符、换页符等空白字符的其中任意一个),文件名尾不能为.号
 2. 文件名和扩展名不能同时为空
 3. 文件名中不能包含 `\/:*?"<>|` 中的任意字符
 4. 文件名(包括扩展名)的长度不得大于 255 个字符
 5. 在 **1** 的条件下，文件名中不能出出现除空格符外的任意空字符。出现控制字符其实也算不合法，
    但因为情况太复杂，就不做判断了。

于是有如下匹配

    首字符: [^\s\\/:\*\?\"<>\|]
    尾字符: [^\s\\/:\*\?\"<>\|\.]
    其它字符: (\x20|[^\s\\/:\*\?\"<>\|])*

`\s` 只能匹配下面六种字符（via: `java.util.regex.Pattern`）： 

    半角空格（ ） 
    水平制表符（\t） 
    竖直制表符 
    回车（\r） 
    换行（\n） 
    换页符（\f）

用 Java 语言实现:

    public static boolean isValidFileName(String fileName) {
        if (fileName == null || fileName.length() > 255) 
            return false;
        else
            return fileName.matches(
               "[^\\s\\\\/:\\*\\?\\\"<>\\|](\\x20|[^\\s\\\\/:\\*\\?\\\"<>\\|])*[^\\s\\\\/:\\*\\?\\\"<>\\|\\.]$");
    }


用于测试:

    System.out.println("null(未初始化)" + "\t" + isValidFileName(null));
    System.out.println(" .xml" + "\t" + isValidFileName(" .xml"));
    System.out.println(".xml " + "\t" + isValidFileName(".xml "));
    System.out.println(" .xml " + "\t" + isValidFileName(" .xml "));
    System.out.println(".xml." + "\t" + isValidFileName(".xml."));
    System.out.println(".xml" + "\t" + isValidFileName(".xml"));
    System.out.println("    .xml(制表符)" + "\t" + isValidFileName("    .xml"));
    System.out.println(".." + "\t" + isValidFileName(".."));
    System.out.println("fdsa    fdsa(制表符)" + "\t" + isValidFileName("fdsa    fdsa(制表符)"));
    System.out.println("a.txt" + "\t" + isValidFileName("a.txt"));
