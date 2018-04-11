---
layout: post
title: HTA中两种方法转码文本文件
slug: 2-ways-to-convert-encodings-in-hta
date: 2011-07-14 08:09
tags: [hta, javascript, vbscript]
---

web这方面编码是一个相当头疼的问题，这两种方法进行编码转换（ie only）

方法一：借助 vbscript 进行编码转换
-----------------------------------

    <SCRIPT language="VBScript" type="text/VBScript">
    Function bytes2BSTR(vIn)
        strReturn = ""
        For i = 1 To LenB(vIn)
            ThisCharCode = AscB(MidB(vIn,i,1))
            If ThisCharCode < &H80 Then
                strReturn = strReturn & Chr(ThisCharCode)
            Else
                NextCharCode = AscB(MidB(vIn,i+1,1))
                strReturn = strReturn & Chr(CLng(ThisCharCode) * &H100 + CInt(NextCharCode))
                i = i + 1
            End If
        Next
        bytes2BSTR = strReturn
    End Function
    </script>

    <script language="javascript">
    function GetData()
    {
        loadcontent.innerText=getDatal("index.php")
        setTimeout("GetData()",1000);
    }

    function getDatal(url){  
           var xmlhttp = new ActiveXObject("MSXML2.XMLHTTP.4.0");
           xmlhttp.open("post",url,false);   
           xmlhttp.send();              
           return bytes2BSTR(xmlhttp.responsebody);       
           xmlhttp=nothing
    }  
    </script>

    <BODY onload="javascript:GetData();">
    <span id="loadcontent">数据载入中……</span>
    </BODY>


方法二：用ADODB.RecordSet解决
-------------------------------

    <body text=00ff00 bgcolor=black></body>
    <script>
        xml=new ActiveXObject("Microsoft.XmlHttp");
        rs=new ActiveXObject("ADODB.RecordSet");
        xml.open("GET","index.php",false,"","");
        xml.send();
        rs.fields.append("a",201,1);
        rs.open();
        rs.addNew();
        rs(0).appendChunk(xml.responseBody);
        rs.update();
        document.body.innerText=rs("a").value;
        rs.close();
        document.charset="gbk";
    </script>

