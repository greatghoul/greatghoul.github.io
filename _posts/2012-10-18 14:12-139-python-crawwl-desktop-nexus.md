---
slug: 139-python-crawwl-desktop-nexus
date: '2012-10-18 14:12'
layout: post
title: 批量下载DesktopNexus壁纸
tags:
  - Python
issue: 139
---

[DesktopNexus][1] 是我最喜爱的一个壁纸下载网站，上面有许多高质量的壁纸，几乎每天必上，
每月也必会坚持分享我这个月来收集的壁纸

但是 DesktopNexus 壁纸的下载很麻烦，而且因为壁纸会通过浏览器检测你当前分辨率来展示
合适你当前分辨率的壁纸，再加上是国外的网站，速度上很不乐观。

于是我写了个脚本，检测输入的页面中壁纸页面的链接，然后批量下载到指定文件夹中。

脚本使用 python 写的，所以需要机器上安装有 python 。

用法：
--------

    $ python desktop_nexus.py -p http://www.desktopnexus.com/tag/cat/ -s 1280x800 -o wallpapers

 - `-p` 包含 DesktopNexus 壁纸链接的页面，比如我的壁纸分享
 - `-s` 壁纸尺寸，可选，缺省为 `1440x900`
 - `-o` 壁纸输出的文件夹，可选，缺省为当前目录下的 `wallpapers`， 如果不存在会自动创建

代码：
--------

```py
#-*- coding: utf-8 -*-
from argparse import ArgumentParser

import os, re, sys
import urllib2, cookielib, urlparse

RE_WALLPAPER = r'http\:\/\/[^\/\.]+\.desktopnexus\.com\/wallpaper\/\d+\/'
CHUNK_SIZE = 1024 * 3

class DesktopNexus:
    def __init__(self, page=None, size=None, output_dir=None):
        self.page = page
        self.size = size
        self.output_dir = output_dir

    def start(self):
        print 'Making output directory:', self.output_dir
        if not os.path.exists(self.output_dir):
            os.makedirs(self.output_dir)

        # Setup cookie
        cookie = cookielib.CookieJar()
        processer = urllib2.HTTPCookieProcessor(cookie)
        opener = urllib2.build_opener(processer)
        urllib2.install_opener(opener)

        self._read_page()

    def _get_pic_info(self, url):
        pic_id = url.split('/')[-2]
        html = urllib2.urlopen(url).read()
        pattern = r'&lt;a href=\"\/get\/%s\/\?t=(?P&lt;token&gt;.*?)\"' % pic_id
        match = re.search(pattern, html, flags=re.I|re.M|re.S)
        if match:
            return {'id': pic_id,
                    'token': match.group('token'),
                    'size': self.size}
        else:
            raise Exception('Cound not find wallpaper')

    def _get_pic_file(self, pic_info):
        redirect_url = 'http://www.desktopnexus.com/dl/inline/%(id)s/%(size)s/%(token)s' % pic_info

        request = urllib2.urlopen(redirect_url)
        return request.geturl()

    def _download_pic(self, url):
        pic_info = self._get_pic_info(url)
        pic_file = self._get_pic_file(pic_info)
        filename = os.path.split(urlparse.urlparse(pic_file).path)[-1]
        filename = os.path.join(self.output_dir, filename)
        with open(filename, 'wb') as output:
            resp = urllib2.urlopen(pic_file)
            total_size = int(resp.info().get('Content-Length'))
            saved_size = 0.0
            while saved_size != total_size:
                chunk = resp.read(CHUNK_SIZE)
                saved_size += len(chunk)
                output.write(chunk)
                self._print_progress('Saving file: %s' % filename, \
                        saved_size / total_size * 100)

    def _print_progress(self, msg, progress):
        sys.stdout.write('%-71s%3d%%\r' \
                % (len(msg) &lt;= 70 and msg or msg[:67] + '...', progress))
        sys.stdout.flush()
        if progress &gt;= 100:
            sys.stdout.write('\n')

    def _read_page(self):
        try:
            print 'Fetching content:', self.page
            html = urllib2.urlopen(self.page).read()
            links = set(re.findall(RE_WALLPAPER, html, re.M|re.I))
            count = len(links)

            print 'Downloading wallpapers:'
            for i, link in enumerate(links):
                print '[%d/%d]: %s' % (i + 1, count, link)
                try:
                    self._download_pic(link)
                except Exception as e:
                    print 'Error downloading wallpaper.', e.message
        except Exception as e:
            print 'Error fetching content.', e

if __name__ == '__main__':
    # Setup argparser
    parser = ArgumentParser('python desktop_nexus.py')
    parser.add_argument('-p', '--page', dest='page', required=True, \
            help='specific a page that includes wallpaper list')
    parser.add_argument('-s', '--size', dest='size', default='1440x900', \
            help='specific the wallpaper size, default to 1440x900')
    parser.add_argument('-o', '--output', dest='output_dir', default='wallpapers', \
            help='specific the output directory, default to "wallpapers"')
    args = parser.parse_args()
    dn = DesktopNexus(**args.__dict__)
    dn.start()
```

[1]: http://www.desktopnexus.com/
