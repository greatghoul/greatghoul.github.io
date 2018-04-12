---
layout: post
title: Python发送简单电子邮件
slug: python-send-simple-text-email
date: 2011-08-31 05:54
tags: [python]
---

尝试了 python 的 [smtplib][1] ，才发现发送邮件可以这么简单，行云流水，畅快自然。

    # coding: utf-8
    import smtplib
    from email.mime.text import MIMEText

    if __name__ == '__main__':
        MAIL_FROM = 'greatghoul@163.com'
        MAIL_TO = ['greatghoul@gmail.com']

        msg = MIMEText('Hello smtplib!')
        msg['Subject'] = 'Hello smtplib!'
        msg['From'] = MAIL_FROM

        try:
            smtp = smtplib.SMTP()
            smtp.connect('smtp.163.com')
            smtp.login('greatghoul', '****')
            smtp.sendmail(MAIL_FROM, MAIL_TO, msg.as_string())
            print 'email sent.'
            smtp.close()
        except Exception, e:
            print e

[1]: http://docs.python.org/library/smtplib.html
