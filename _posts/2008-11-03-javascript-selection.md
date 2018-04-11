---
layout: post
title: 用javascript选中页面指定文本
slug: javascript-selection
date: 2008-11-03 19:16
tags: [javascript]
---

其实相当于页内查找功能。

**用法：** `selectText("要选中的文本");`

    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Demo</title>
    </style>
    </head>
    <body>
    所需阅读发新话题权限
    </body>
    </html>
    <script language="JavaScript" type="text/javascript">
    function selectText(key) {
        try {
            window.find(key);
        } catch (e) {
            var range = document.body.createTextRange();
            range.findText(key);
            range.select();
        }
    }
    selectText("阅读发新");
    </script> 
