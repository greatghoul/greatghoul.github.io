---
layout: post
title: SAE 中 Flask Blueprint 指定 template folder 无效问题分析
slug: dive-into-sae-flask-blueprint-template-folder-not-work-issue
date: 2011-12-01 01:39
tags: [python, flask, jinja, sae]
---

之前的 [解决 SAE 中 Flask Blueprint 指定 template folder 无效问题][1] 的方案中，是使用 `render_template_string()` 间接
实现 `render_template()`，但是这一方案有一个很大的缺陷，就是会丢失 `jinja` 模板的一些特性，比如继承，`include` 等一些
相关路径的操作，而且还要手动处理编码问题。

在 flask 的邮件列表中，有一个比较细致的讨论 [Templates for blueprints][2] 以及 [SO 中的规避的方案][3]：

> Two options come to mind.
> 
> - Rename each of the index.html files to be unique (e.g. admin.html and main.html).
> - In each of the template folders, put each of the templates in a subdirectory of 
>   the blueprint folder and then call the template using that subdirectory. 
>   Your admin template, for example, would be `yourapp/admin/pages/admin/index.html`, 
>   and then called from within the blueprint as `render_template('admin/index.html')`.

其实在[官方的文档][4]中描述的也很明确：

> The template folder is added to the searchpath of templates but with a lower priority 
> than the actual application’s template folder.
> 
> 模板目录会添加到模板搜索路径中，但是相比于 app 的模板目录, 它的优先级比较低。

在 `blueprint` 中请求 `render_template()` 时，`flask` 会优先搜索 `app` 的 `template_folder` 下的模板，
如果找不到，再到其它路径中找。

这个过程在 SAE 中会出一个问题：app 的 `template_folder` 不存在，那 SAE 在访问默认 `template_dir`，也就是 `templates` 
目录时，会如 [nkchenz][5] 所言，[报一个IOError][6]。

比如我的应用根目录中根本 `templates` 文件夹，SAE 在试图访问 `..../greatghoul/1/templates/index.html` 时，就会 `IOError`

    IOError: Permission denied: /data1/www/htdocs/562/greatghoul/1/templates/index.html

如果你建立一个空的 `templates` 目录，`flask` 便不会报错了，不过这还是不能解决模板搜索路径优先级的问题。

我们先看下下 `flask` 对于优先级的处理:

    class DispatchingJinjaLoader(BaseLoader):
        """A loader that looks for templates in the application and all
        the blueprint folders.
        """

        # ...

        def _iter_loaders(self, template):
            loader = self.app.jinja_loader
            if loader is not None:
                yield loader, template

            # old style module based loaders in case we are dealing with a
            # blueprint that is an old style module
            try:
                module, local_name = posixpath.normpath(template).split('/', 1)
                blueprint = self.app.blueprints[module]

                if blueprint_is_module(blueprint):
                    loader = blueprint.jinja_loader
                    if loader is not None:
                        yield loader, local_name
            except (ValueError, KeyError):
                pass

            for blueprint in self.app.blueprints.itervalues():
                loader = blueprint.jinja_loader
                if loader is not None:
                    yield loader, template

通过代码可以看出来，搜索顺序为 `app -> module(不推荐使用) -> 各blurprint` ，给人的感觉是，`blueprint` 的模板设置，就像
皇宫的二线嫔妃一样，正宫娘娘享受完了皇帝，才有她们的份。

很明显 `app` 的优先级是最高的，那我们是不是可以在请求之前，将 `app` 的 `jinja_loader` 引用，更新为当前 `blueprint` 
的 `jinja_loader` 呢?

尝试后,不负责任的说,是可行的:

    home = Blueprint('home', __name__, 
            url_prefix='/',
            static_folder='static',
            template_folder='templates')

    @home.before_request
    def before_request():  
        # 使用当前blueprint的jinja_loader替代app的jinja_loader
        ctx = _request_ctx_stack.top
        ctx.app.jinja_loader = home.jinja_loader

这样在调用 `render_template()` 方法时，实际作用的 `jinja_loader` 是当前请求的`jinja_loader`，这样就会只优先读取当前 
`blurprint` 下的模板文件了。

但是我测试的只是单用户的情况，如果是多个用户并发访问，一个用户在访问 `blurprint` 时修改了 `app` 的 `jinja_loader` 
引用，会不会影响到别的用户访问 `app` 时的模板处理行为？ 这个还需要考正。

不过即使这种方法是可行的, 依然是不推荐使用的，因为它属于一种破坏性的行为，**与其插上一手去影响 flask 的默认习惯，
不如去适应它的哲学**，采用官方推荐的方式布局应用。

[1]: http://www.g2w.me/2011/11/issue-flask-blueprint-template-folder-not-work-solved/
[2]: http://flask.pocoo.org/mailinglist/archive/2011/9/17/templates-for-blueprints/#b383c6c41f5bef3152cd7a179385d95b
[3]: http://stackoverflow.com/a/8198325/260793
[4]: http://flask.pocoo.org/docs/blueprints/#templates
[5]: https://github.com/nkchenz
[6]: https://github.com/SAEPython/saepythondevguide/issues/2#issuecomment-2959987
