---
layout: post
title: Rails Assets 与前端原型 Assets 同步 
slug: sync-assets-between-rails-and-prototype
date: 2013-02-01 09:17
tags: [rails, shell, assets, prototype]
---

## 背景

公司项目中设计MM先开发网站的原型，然后我们移植到 rails 中来，但因为工期很紧，所以初期需要经常在 rails 
和原型之间同步样式、脚本和图片文件。

于是问题出来了，因为 rails 中的图片引用路径和原型的引用路径有些差异，而且设计MM们都是在 windows 下进行
原型开发，而我们是在 linux 下进行开发，每次比较合并时，换行符差异会让合并变得异常困难。

 * 换行符： windows 为 ``\r\n``，而 linux 为 ``\n``
 * 图片路径：原型中为 ``../images/xxx.png``，而 rails 中为 ``xxx.png`` 
   (**因为rails中样式和图片都是地址 ``/assets/`` 下面**)

在文件比较少时，手工同步还比较快，但一旦当样式文件多起来，效率太低下，还容易出错，于是不得不寻找更加高
效的解决方法。

## 解决方法

原型是使用 svn 进行版本管理，而项目是使用 git 进行版本管理，我使用 [meld][meld] 作为合并工具。样式、脚本
和图片都分布在不同的文件夹，而且原型和项目的文件夹结构也自然不会一致。

图片和脚本的同步问题不大，因为不存在引用其它文件的情况，可以直接进行文件夹比较同步，最大的问题在于同步
样式，因为样式中会引用图片。

经过对差异的分析，可以这样解决问题：

 1. 通过 ``svn update`` 更新原型的文件
 2. 通过 ``sed`` 替换所有样式文件中的 ``\r\n`` 为 ``\n``
 3. 通过 ``sed`` 删除所有样式文件中的 ``../images/``
 4. 调用 meld 进行文件夹比较(**这时因为文件换行和图片路径一致，合并起来非常容易**)
 5. 合并完成后 ``svn revert`` 通过恢复原型中样式文件的更改

通过这样的步骤，每次合并前都临时将样式文件的格式与项目中的文件调整为一致的状态，使合并更加容易。

## 附上脚本文件

    #!/bin/bash
    NAME=assets_diff
    PROJECT_ASSETS=/path/to/your/project
    PROTOTYPE_ASSETS=/path/to/your/prototype

    # Update prototype pages before compare
    echo 'Update prototypes ...'
    cd $PROTOTYPE_ASSETS
    svn update

    case "$1" in
        styles)
            echo "Fix line separator and images path"
            sed -i 's/\r\n/\n/g' `find $PROTOTYPE_ASSETS/css/ -type f` 
            sed -i 's/\.\.\/images\///g' `find $PROTOTYPE_ASSETS/css/ -type f` 
            meld $PROJECT_ASSETS/stylesheets $PROTOTYPE_ASSETS/css
            echo "Revert changes in prototype directory"
            svn revert -R $PROTOTYPE_ASSETS/css 
        ;;

        scripts)
            meld $PROJECT_ASSETS/javascripts $PROTOTYPE_ASSETS/scripts
        ;;

        images)
            meld $PROJECT_ASSETS/images $PROTOTYPE_ASSETS/images
        ;;

        *)
            echo "Usage: $NAME styles|scripts|images"
    esac

## 用法

为脚本加上可执行权限

    chmod +x assets_diff

然后这样调用

    ./assets_diff styles
    ./assets_diff scripts
    ./assets_diff images

[meld]: http://meldmerge.org/

