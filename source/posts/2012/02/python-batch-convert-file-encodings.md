---
title: python批量转换文件编码
slug: python-batch-convert-file-encodings
date: 2012-02-03 02:26
tags: [python]
---

今天在 eclipse 中导入了个之前的 swing 项目，结果跑起来后乱码，检查代码发现竟然一部分 java 文件是 utf-8 编码，一部分却
是 gb2312 的，而文件又比较多，一个一个去看显示太麻烦了，于是又该 python 出手了。

这里需要用到一个 python 的库 [chardet 1.0.1][1] ，用于自动检测文件的编码，使用起来非常方便。

    >>> import chardet
    >>> chardet.detect(open(r'E:\Workspaces\java\GCHMCreator\main\g2w\app\gchm\gui\ContentElement.java').read())
    {'confidence': 0.99, 'encoding': 'GB2312'}

detect 文件返回的是一个字典，其中 `encoding` 的值为检测到的编码类型，`confidence` 为该编码的符合度，

我需要做这样的事：

 1. 遍历项目中所有的 `.java` 文件，并检测其编码
 2. 备份每个 `.java` 文件中 `.java.bak` 以便于恢复
 3. 将 .java 文件从检测到的编码格式转换成 utf-8 格式
 4. 提供一个恢复工具，在转换错误后能够恢复到原来的文件
 5. 提供一个清理工具，在确保文件转换正确后，可以清除备份的文件

其中最关键的部分在第二条，利用 chardet 检测出文件的编码 `source_encoding`，将文本内容通过 `source_encoding` `decode` 
成 unicode ，再利用 [codecs][2] 将文件输出成正确的编码格式。

**完整代码**

    #-*- coding: utf-8 -*-

    import codecs
    import os
    import shutil
    import re
    import chardet

    def convert_encoding(filename, target_encoding):
        # Backup the origin file.
        shutil.copyfile(filename, filename + '.bak')

        # convert file from the source encoding to target encoding
        content = codecs.open(filename, 'r').read()
        source_encoding = chardet.detect(content)['encoding']
        print source_encoding, filename
        content = content.decode(source_encoding) #.encode(source_encoding)
        codecs.open(filename, 'w', encoding=target_encoding).write(content)

    def main():
        for root, dirs, files in os.walk(os.getcwd()):
            for f in files:
                if f.lower().endswith('.java'):
                    filename = os.path.join(root, f)
                    try:
                        convert_encoding(filename, 'utf-8')
                    except Exception, e:
                        print filename

    def process_bak_files(action='restore'):
        for root, dirs, files in os.walk(os.getcwd()):
            for f in files:
                if f.lower().endswith('.java.bak'):
                    source = os.path.join(root, f)
                    target = os.path.join(root, re.sub('\.java\.bak$', '.java', f, flags=re.IGNORECASE))
                    try:
                        if action == 'restore':
                            shutil.move(source, target)
                        elif action == 'clear':
                            os.remove(source)
                    except Exception, e:
                        print source

    if __name__ == '__main__':
        # process_bak_files(action='clear')
        main()

[1]: http://pypi.python.org/pypi/chardet
[2]: http://docs.python.org/library/codecs.html
