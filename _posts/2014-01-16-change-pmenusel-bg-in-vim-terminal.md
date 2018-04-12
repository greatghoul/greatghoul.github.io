---
layout: post
title: 修改终端下vim的PopupMenu选种项的背景颜色
slug: change-pmenusel-bg-in-vim-terminal
date: 2014-01-16 15:35
tags: [vim, terminal]
---

我平常比较喜欢使用终端下的 VIM，最方便的就是随时可以使用 `ctrl+z` 切换到终端下执行命令，
然后再通过 `fg` 切换回 VIM。如果再有个透明效果，那就更赞了。不过最近换了一个配色**ron** 后，
有个比较困扰的问题：自动完成的弹出菜单中选中项的背景颜色和文字颜色相同！

![shit](http://pic.yupoo.com/greatghoul_v/DsVle2aC/Qwl0Y.png)

这样完全无法看清到底选择的项是什么，虽然 `set background=light` 可以解决，但是配色会变化，
有些刺眼。所以还是需要通过其它方式解决：覆盖颜色！

在 `.vimrc` 中加入如下配置

    colors ron
    hi PmenuSel ctermbg=lightblue

注意第二行，一定要在 colors ron 之后调用，不然不会生效。

治疗效果：

![screenshot](http://pic.yupoo.com/greatghoul_v/DsVhL9TK/11Dm46.png)

当然，你也可以修改其它的颜色，比如：

    :hi Pmenu ctermbg=red  "for vim
    :hi Pmenu guibg=red    "for gvim

参考：<http://stackoverflow.com/a/10988620/260793>

更多的设置详见： `:help hi`
