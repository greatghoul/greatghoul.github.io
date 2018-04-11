---
layout: post
title: python遍历C盘下的所有dll文件
slug: list-all-dlls
date: 2011-02-09 19:12
tags: [python]
---

python 的 [fnmatch][1] 还真是省心，相比于 java 中的 [FilenameFilter][2] ，真是好太多了，你完成不需要去实现什么接口。

fnmatch 配合 [os.walk()][3] 或者 [os.listdir()][4] ，你能做的事太多了，而且用起来相当 easy。

    # coding: utf-8
    """
    遍历C盘下的所有dll文件
    """
    import os
    import fnmatch

    def main():
        f = open('dll_list.txt', 'w')
        for root, dirs, files in os.walk('c:\\'):
            for name in files:
                if fnmatch.fnmatch(name, '*.dll'):
                    f.write(os.path.join(root, name))
                    f.write('\n')
        f.close()
        print 'done...'

    if __name__=='__main__':
        main()</pre>

[1]: http://docs.python.org/library/fnmatch.html
[2]: http://download.oracle.com/javase/1.4.2/docs/api/java/io/FilenameFilter.html
[3]: http://docs.python.org/library/os.html#os.walk
[4]: http://docs.python.org/library/os.html#os.listdir
