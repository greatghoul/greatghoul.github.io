---
title: "jquery Uncaught Error: NOT_FOUND_ERR: DOM Exception 8"
slug: jquery-uncaught-error-not-found-err-dom-exception-8
date: 2012-07-19 14:12
tags: [jquery]
---

使用 jquery 进行 ajax 登陆较验时，需要把返回的错误信息显示到对应表单元素后的 
`<span class="help-inline"></span>` 中，代码如下：

    $.each(data.fieldErrors, function(key, value) {
        console.log(value); // <-- value是数组类型
        $this.find('input.' + key).parents('.control-group').addClass('error');
        $this.find('input.' + key).nextAll('.help-inline').html(value).show();
    });

但是 console 却输出了如下异常

    ["验证码不正确"]
    Uncaught Error: NOT_FOUND_ERR: DOM Exception 8

从 `console` 的输出可以看出，`value` 是数据组类型，这导致 jquery 处理` html()` 
方法时出现异常。

只要确保 `html()` 方法中传入的是字符串，就可以解决这个问题了。

    $this.find('input.' + key).nextAll('.help-inline').html(value[0]).show();

**效果图**

![ajax-validation](http://pic.yupoo.com/greatghoul_v/C7Rb4I7R/4UloC.png)

