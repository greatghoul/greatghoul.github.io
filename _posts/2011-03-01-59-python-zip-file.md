---
slug: 59-python-zip-file
date: '2011-03-01'
layout: post
title: ' python压缩和解压zip'
tags:
  - Python
issue: 59
---

python 的 [zipfile][1] 提供了非常便捷的方法来压缩和解压 [zip][2] 文件。

例如，在py脚本所在目录中，有如下文件：

    readability/readability.js
    readability/readability.txt
    readability/readability-print.css
    readability/sprite-readability.png
    readability/readability.css

将 `readability` 目录中的文件压缩到脚本所在目录的 `readability.zip` 文件中，保持相同的文件结构，然后打印出生成的压缩包
的文件列表，再用两种方式分别解压文件到脚本所在目录的 `output` 目录和 `output/bak` 目录中。

脚本如下：

    #!/usr/vin/env python
    # coding: utf-8
    """
    压缩和解压zip文件
    """

    import os
    import zipfile

    def compress(zip_file, input_dir):
        f_zip = zipfile.ZipFile(zip_file, 'w')
        for root, dirs, files in os.walk(input_dir):
            for f in files:
                # 获取文件相对路径，在压缩包内建立相同的目录结构
                abs_path = os.path.join(os.path.join(root, f))
                rel_path = os.path.relpath(abs_path, os.path.dirname(input_dir))
                f_zip.write(abs_path, rel_path, zipfile.ZIP_STORED)

    def extract(zip_file, output_dir):
        f_zip = zipfile.ZipFile(zip_file, 'r')

        # 解压所有文件到指定目录
        f_zip.extractall(output_dir)

        # 逐个解压文件到指定目录
        for f in f_zip.namelist():
            f_zip.extract(f, os.path.join(output_dir, 'bak'))

    def printdir(zip_file):
        f_zip = zipfile.ZipFile(zip_file, 'r')
        print '== printdir() ============================'
        f_zip.printdir()
        print
        print '== namelist() ============================'
        for f in f_zip.namelist():
            print f

    if __name__ == '__main__':
        zip_file = 'readability.zip'
        compress(zip_file, os.path.join(os.getcwd(), 'readability'))
        printdirzip_file)
        extract(zip_file, 'output')</pre>

[1]: http://docs.python.org/library/zipfile
[2]: http://en.wikipedia.org/wiki/ZIP_(file_format)
