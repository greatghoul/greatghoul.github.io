---
layout: post
title: python发送文件夹内容到邮箱
slug: send-files-in-dir-with-python
date: 2011-12-03 01:14
tags: [linux, python, smtp]
---

由于我经常需要备份文件夹下的内容到邮件里面，每个打开邮件，上传文件，发送，太过麻烦，其实每次发送的文件都是放在固定
置的，只是邮件标题不同而已，于是用 python 为自己写了个发送文件到邮箱的小工具，在任意目录下执行该脚本，并指定邮件标
，就将指定文件夹下的文件发送到邮箱中备份起来 。

    #!/usr/bin/env python
    # coding: utf-8

    from smtplib import SMTP, quotedata, CRLF, SMTPDataError
    from email.MIMEMultipart import MIMEMultipart
    from email.MIMEBase import MIMEBase
    from email.MIMEText import MIMEText
    from email import Encoders
    from sys import stderr, stdout
    import os
    import sys

    class ExtendedSMTP(SMTP):
        def data(self, msg):
            self.putcmd("data")
            (code,repl)=self.getreply()
            if self.debuglevel > 0 : print >> stderr, "data:", (code, repl)
            if code != 354:
                raise SMTPDataError(code,repl)
            else:
                q = quotedata(msg)
                if q[-2:] != CRLF:
                    q = q + CRLF
                q = q + "." + CRLF

                # begin modified send code
                chunk_size = 2048
                bytes_sent = 0

                while bytes_sent != len(q):
                    chunk = q[bytes_sent:bytes_sent+chunk_size]
                    self.send(chunk)
                    bytes_sent += len(chunk)
                    if hasattr(self, "callback"):
                        self.callback(bytes_sent, len(q))
                # end modified send code

                (code,msg)=self.getreply()
                if self.debuglevel >0 : print>>stderr, "data:", (code,msg)
                return (code,msg)

    def callback(progress, total):
        percent = 100. * progress / total
        stdout.write('\r')
        stdout.write("%s bytes sent of %s [%2.0f%%]" % (progress, total, percent))
        stdout.flush()
        if percent >= 100: stdout.write('\n')

    def sendmail(subject):
        MAIL_FROM = 'mymail@qq.com'
        MAIL_TO = ['mymail@qq.com']
        BAK_DIR = '/path/to/bak/folder'

        msg = MIMEMultipart()
        msg['From'] = MAIL_FROM
        msg['Subject'] = subject

        msg.attach( MIMEText('test send attachment') )
        for filename in os.listdir(BAK_DIR):
            part = MIMEBase('application', "octet-stream")
            part.set_payload(open(os.path.join(BAK_DIR, filename),"rb").read() )
            Encoders.encode_base64(part)
            part.add_header('Content-Disposition', 'attachment; filename="%s"' % os.path.basename(filename))
            msg.attach(part)

        try:
            smtp = ExtendedSMTP()
            smtp.callback = callback
            smtp.connect('smtp.qq.com', 25)
            smtp.login('mymail', 'mypwd')
            smtp.sendmail(MAIL_FROM, MAIL_TO, msg.as_string())
            smtp.close()
            os.system('rm -f %s/*' % BAK_DIR)
        except Exception, e:
            print e

    if __name__ == '__main__':
        if len(sys.argv) == 1:
            print 'Please specific a subject'
            print 'Usage: send_files <MAIL_SUBJECT>'
        else:
            sendmail(sys.argv[1])

**安装：**

配置好收件人，发件人，smtp地址，用户名，密码及要发送文件所在的路径。

将文件保存为 `send_files`，保存到 `/usr/bin` 下面。

然后设置文件权限为可执行：

    $ chmod +x send_files

**用法：**

    $ send_files '邮件标题'

还带有进度条哦～～
