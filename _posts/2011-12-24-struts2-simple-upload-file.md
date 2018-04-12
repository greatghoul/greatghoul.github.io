---
layout: post
title: Struts2上传文件并限定文件类型和大小
slug: struts2-simple-upload-file
date: 2011-12-24 00:33
tags: [apache-commons, java, struts2]
---

[Struts2][1] 为文件上传提供了非常使得的支持，你几乎不用至尊操作 io 流，就可以实现对文件的上传操作。其实为了跑起来 
truts2，必须要引入一些 [apache-commons][2] 的包，这更为文件操作提供了捷径，完全没有必要自己去操作流并处理 io 异常。

![Struts工作机制](http://pic.yupoo.com/greatghoul_v/BC7UzCuQ/bK4uh.gif)

在上传文件时，struts2 其实经历了如下几个过程：

 1. 用户发送上传文件的请求到 `FilterDispatcher`
 2. `dispatcher `中转请求到拦截器
 3. 拦截器检验上传的文件，包括类型，大小等
 4. 如果检验失败，直接转到 `input`，并附加异常信息
 5. 如果检验成功，将文件交由 `Action `继续处理
 6. `Action `对文件进行后续处理，最后返回结果给客户端页面

配置拦截器
---------------

要对上传的文件进行类型和大小等限制的检验，需要显式的引入 `defaultStack`，并且需要配置 `fileUpload`，定义 
`allowedTypes` 及 `maximumSize`

 - `**allowedTypes **`为一组用英文半角逗号分隔的 [MIME Type][3]，不在列表中的文件类型会导致上传失败
 - `**maximumSize **`为以 `byte `为单位的最大文件限制，超过这个限制的文件将会导致上传失败
   
配置如下：

    <!DOCTYPE struts PUBLIC
    "-//Apache Software Foundation//DTD Struts Configuration 2.0//EN"
    "http://struts.apache.org/dtds/struts-2.0.dtd">

    <struts>
        <package name="default" extends="struts-default">
            <action name="upload" class="g2w.struts2.FileUploadAction">
                <interceptor-ref name="fileUpload">
                    <param name="allowedTypes">
                    text/plain,text/css,text/javascript
                    </param>
                    <param name="maximumSize">1000000</param>
                </interceptor-ref>
                <interceptor-ref name="defaultStack" />
                <param name="savePath">/uploads</param>
                <result name="success">/success.jsp</result>
                <result name="error">/failure.jsp</result>
                <result name="input">/failure.jsp</result>
            </action>
        </package>
    </struts>

编写 Action
------------

配置了拦截器，就可以编写 `Action `以对文件进行后续的操作了，我们需要做的就是定义几个成员变量，写几个 `setter`,
`getter `而已。

    package g2w.struts2;

    import java.io.File;
    import java.io.IOException;

    import org.apache.commons.io.FileUtils;
    import org.apache.struts2.ServletActionContext;

    import com.opensymphony.xwork2.ActionSupport;

    public class FileUploadAction extends ActionSupport {
        private static final long serialVersionUID = 1L;

        private File file;
        private String fileContentType;
        private String fileFileName;

        private String savePath;

        // setters &amp; getters

        public String execute() {
            try  {
                File destFile = new File(this.getSavePath(), fileFileName);
                FileUtils.copyFile(this.file, destFile);
                // ....
            } catch (IOException e) {
                this.setMessage(e.getMessage());
                return ActionSupport.ERROR;
            }
            return SUCCESS;
        }
    }

struts2 默认会将文件上传至一个临时目录，比如

`.../tomcat/work/Catalina/localhost/Struts2/upload__605bceb9_1346ba7a~0000.tmp`

并将该临时文件的引用赋值给你所定义的文件对象，比如 `file `。

需要注意的一点是，如果你的文件对象的变量名为 `file`，那它对应的 `contentType` 及 `fileName` 属性的变量名应该为 
`**file**ContentType` 及 `**file**FileName`，以保证文件的类型和文件名正确的设置到属性里。

有了这个文件对象，接下来的事，就随你的便了，比如你可以利用 [apache-commons-io][4] 包里的 [FileUtils][5] 将文件
制到指定的路径下

    File destFile = new File(this.getSavePath(), fileFileName);
    FileUtils.copyFile(this.file, destFile);

这里你完全没有必要自已去操作io流，apache-commons 已经替你做了你能想到的很多事，甚至在复制文件时，如果目标路径不存
，自动创建该路径对应的文件夹！

编写Form
------------

当然你还需要写一个上传页面，你必须保证你的 `form` 标签定义了 `enctype="multipart/form-data"` 并设置了提交方式为 `POST`

    <s:form action="upload.action" method="POST" enctype="multipart/form-data">
        <s:file name="file" label="File" />
        <s:submit label="Upload" />
    </s:form>

除此之外，你还需要编写一些结果页面，包括一个 `input `结果页面，因为如果拦截器检验不通过，将会返回到这个页面，并提示
误信息，[详见附件][6]。

[1]: http://struts.apache.org/2.x/
[2]: http://commons.apache.org/
[3]: http://en.wikipedia.org/wiki/MIME
[4]: http://commons.apache.org/io/
[5]: http://commons.apache.org/io/api-release/org/apache/commons/io/FileUtils.html#copyFile(java.io.File, java.io.File)
[6]: http://www.kuaipan.cn/index.php?ac=file&amp;oid=1206417658743244
