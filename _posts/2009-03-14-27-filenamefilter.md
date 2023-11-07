---
slug: 27-filenamefilter
date: '2009-03-14'
layout: post
title: FileNameFilter接口应用 - 指定多个扩展名过滤规则
tags:
  - Java
issue: 27
---

学 java 的经常会写一些 `FileNamesFilter` 以方面自已获取文件列表.
捉摩了下这个接口.也写了一个自已的应用来获取能匹配扩展名列表的文件集合.
大家 pp 。

用匿名实现

    /**
     * Returns a list of files that the extension name matchs one of extensions.
     * 
     * Usage: getFilesByNameExtensions(dir, "txt", "JPEG");
     * @author greatghoul http://www.g2w.me
     * @param dir The directory to scan in.
     * @param extensions Extensions collection.
     * @return A list of matched files.
     */
    public static List getFilesByNameExtensions(File dir, final String... extensions) {
        return Arrays.asList(dir.listFiles(new FilenameFilter()  {
            @Override
            public boolean accept(File dir, String name) {
                File file = new File(dir, name);
                boolean accept = false;
                for (String extension : extensions) {
                    if (file.isDirectory()) break;
                    if (name.toLowerCase().endsWith("." + extension.toLowerCase())) {
                        accept = true;
                        break;
                    }
                }
                return accept;
            }    
        }));
    }

Enjory it.
