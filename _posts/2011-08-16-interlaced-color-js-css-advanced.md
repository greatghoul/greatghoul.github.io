---
title: 隔行变色(JS+CSS) 高级
slug: interlaced-color-js-css-advanced
date: 2011-08-16 22:13
tags: [css, html, javascript]
---

目录
------

 - [隔行变色(CSS)][m1]
 - [隔行变色(JS+CSS)][m2]
 - 隔行变色(JS+CSS) 高级

隔行变色(JS+CSS) 高级
---------------------------

[隔行变色(JS+CSS)][m2]存在的问题：

 - 只能对指定的一个列表进行渲染，不能重用
 - 不能指定变色的起始位置，在处理表格的变色时，得专门写处理
 - 代码全在 onload 事件中，对页面的依赖太高

将其代码进行改进并移入到一个单独的函数中去：

    /**
     * 此方法用于列表的隔行变色效果，可以灵活得为指定ID的列表指定隔行的颜色。
     *
     * @param id 列表的id
     * @param item 要变色的行的标签
     * @param odd 奇数行的样式类名，如果不指定，则默认为odd
     * @param even 偶数行的样式类名，如果不指定，则默认为even
     * @param start 开始变色的行的索引，如果不指定，则默认为0
     * @param end 结束变色的行的索引，如果不指定，则默认为列表长度
     */
    function rowRender(id, item, odd, even, start, end) {
        // 获取列表容器
        var list = document.getElementById(id);
        // 获取列表
        var items = list.getElementsByTagName(item);
        
        // 修正初始位置，如果不是一个数字或者越界，则从0开始
        if (isNaN(start) || (start < 0 || start >= items.length)) {
            start = 0;
        }
        
        // 修正结束位置，如果不是一个数字或者越界，则为列表末尾
        if (isNaN(end) || (end < start || end >= items.length)) {
            end = items.length;
        }
        
        // 如果没有指定odd，则默认为'odd'
        odd  = odd  || 'odd';
        // 如果没有指定even, 则默认为'even'
        even = even || 'even'; 
        
        // 遍历列表并渲染效果
        for (var i = start; i < end; i++) {
            var className = ' ' + ((i % 2 == 0) ? odd : even);
            items[i].className += className;
        }
    }

用法：
--------

    window.onload = function() {
        // 渲梁list1下所有的li标签，使用默认的样式和起始位置
        rowRender('list1', 'li');

        // 渲梁list2下所有的li标签，使用指定的odd和默认的even，使用指定的起始位置
        rowRender('list2', 'li', 'odd1', null, 2, 6);

        // 渲梁table1下所有的tr标签，使用指定的odd和even，使用默认的起始位置
        rowRender('table1', 'tr', 'tr-odd', 'tr-even');
        // 渲梁table2下所有的tr标签，使用指定的odd和even，使用指定的起始位置
        rowRender('table2', 'tr', 'tr-odd', 'tr-even', 1);
    }

示例：
--------

### List 1

`rowRender('list1', 'li');`

<ul id="list1" style="list-style-type: none; padding: 0px; margin: 0px;">
	<li class="odd"  style="background-color: #e8bda6;>Item 1</li>
	<li class="even" style="background-color: #e8aa89;>Item 2</li>
	<li class="odd"  style="background-color: #e8bda6;>Item 3</li>
	<li class="even" style="background-color: #e8aa89;>Item 4</li>
	<li class="odd"  style="background-color: #e8bda6;>Item 5</li>
	<li class="even" style="background-color: #e8aa89;>Item 6</li>
	<li class="odd"  style="background-color: #e8bda6;>Item 7</li>
	<li class="even" style="background-color: #e8aa89;>Item 8</li>
	<li class="odd"  style="background-color: #e8bda6;>Item 9</li>
	<li class="even" style="background-color: #e8aa89;>Item 10</li>
	<li class="odd"  style="background-color: #e8bda6;>Item 11</li>
</ul>

### List 2

`rowRender('list2', 'li', 'odd1', null, 2, 6);`

<ul id="list2" style="list-style-type: none; padding: 0px; margin: 0px;">
    <li>Item 1</li>
    <li>Item 2</li>
	<li class="odd1" style="background-color: #bc8a6f;>Item 3
	<li class="even" style="background-color: #e8aa89;>Item 4
	<li class="odd1" style="background-color: #bc8a6f;>Item 5
	<li class="even" style="background-color: #e8aa89;>Item 6
    <li>Item 7</li>
    <li>Item 8</li>
    <li>Item 9</li>
    <li>Item 10</li>
    <li>Item 11</li>
</ul>

### Table 1

`rowRender('table1', 'tr', 'tr-odd', 'tr-even');`

<table id="table1">
    <tbody>
        <tr class="tr-odd"  style="background-color: #e6dfd9;">
            <td>001</td>
            <td>data1</td>
        </tr>
        <tr class="tr-even" style="background-color: #efebe7;">
            <td>002</td>
            <td>data2</td>
        </tr>
        <tr class="tr-odd"  style="background-color: #e6dfd9;">
            <td>003</td>
            <td>data3</td>
        </tr>
        <tr class="tr-even" style="background-color: #efebe7;">
            <td>004</td>
            <td>data4</td>
        </tr>
        <tr class="tr-odd"  style="background-color: #e6dfd9;">
            <td>005</td>
            <td>data5</td>
        </tr>
        <tr class="tr-even" style="background-color: #efebe7;">
            <td>006</td>
            <td>data6</td>
        </tr>
        <tr class="tr-odd"  style="background-color: #e6dfd9;">
            <td>007</td>
            <td>data7</td>
        </tr>
        <tr class="tr-even" style="background-color: #efebe7;">
            <td>008</td>
            <td>data8</td>
        </tr>
        <tr class="tr-odd"  style="background-color: #e6dfd9;">
            <td>009</td>
            <td>data9</td>
        </tr>
        <tr class="tr-even" style="background-color: #efebe7;">
            <td>0010</td>
            <td>data10</td>
        </tr>
        <tr class="tr-odd"  style="background-color: #e6dfd9;">
            <td>0011</td>
            <td>data11</td>
        </tr>
    </tbody>
</table>

### Table 2

`rowRender('table1', 'tr', 'tr-odd', 'tr-even', 1);`

<table id="table2">
    <tbody>
        <tr>
            <th style="background-color: #929292;">ID</th>
            <th style="background-color: #929292;">DATA</th>
        </tr>
        <tr class="tr-even" style="background-color: #efebe7;">
            <td>001</td>
            <td>data1</td>
        </tr>
        <tr class="tr-odd" style="background-color: #e6dfd9;">
            <td>002</td>
            <td>data2</td>
        </tr>
        <tr class="tr-even" style="background-color: #efebe7;">
            <td>003</td>
            <td>data3</td>
        </tr>
        <tr class="tr-odd" style="background-color: #e6dfd9;">
            <td>004</td>
            <td>data4</td>
        </tr>
        <tr class="tr-even" style="background-color: #efebe7;">
            <td>005</td>
            <td>data5</td>
        </tr>
        <tr class="tr-odd" style="background-color: #e6dfd9;">
            <td>006</td>
            <td>data6</td>
        </tr>
        <tr class="tr-even" style="background-color: #efebe7;">
            <td>007</td>
            <td>data7</td>
        </tr>
        <tr class="tr-odd" style="background-color: #e6dfd9;">
            <td>008</td>
            <td>data8</td>
        </tr>
        <tr class="tr-even" style="background-color: #efebe7;">
            <td>009</td>
            <td>data9</td>
        </tr>
        <tr class="tr-odd" style="background-color: #e6dfd9;">
            <td>0010</td>
            <td>data10</td>
        </tr>
        <tr class="tr-even" style="background-color: #efebe7;">
            <td>0011</td>
            <td>data11</td>
        </tr>
    </tbody>
</table>

[m1]: http://www.g2w.me/2011/08/interlaced-color-css/
[m3]: http://www.g2w.me/2011/08/interlaced-color-js-css/

