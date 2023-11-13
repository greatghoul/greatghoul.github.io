---
slug: 55-javascript-string-format
date: '2011-02-09'
layout: post
title: javascript简单实现String.format()
tags:
  - JavaScript
issue: 55
---

在 java 中有 [String.format()][1]，而 python 和 c, c++, php 中，都有自己优雅的实现，而 javascript 中就没有现成的函数了。


我写了个超简陋的，能实现最简单的功能，但离完善还相当遥远，不过也可以简化不少工作了。

    function str() {
        var s = arguments[0];
        for (var i = 1; i < s.length; i++) {
            s = s.replace('%s', arguments[i]);
        }
        return s;
    }
    alert(str('what a %s day!', 'fuck'));
    alert(str('ping 192.168.100.%s', 129));
    alert(str('%s + %s = %s', 12, 13, 12 + 13));
    alert(str('what a %s day!'));
    alert(str('what a %s day!', 'fuck', 'fuck1'));
    alert(str('what a %s day!', '%sss', ''));

里面有很多相当不足的地方，不过程序员都是爱折腾的一族，google 一下，你就知道。

 * [Stack Overflow: Javascript printf/string.format][2]
 * [sprintf() and printf() in JavaScript][3]
 * [JavaScript sprintf()][4]

[1]: http://download.oracle.com/javase/1.5.0/docs/api/java/lang/String.html
[2]: http://stackoverflow.com/questions/610406/javascript-printf-string-format
[3]: http://jan.moesen.nu/code/javascript/sprintf-and-printf-in-javascript/
[4]: http://www.diveintojavascript.com/projects/javascript-sprintf
