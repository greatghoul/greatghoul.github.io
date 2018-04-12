---
layout: post
title: 解决SAE中Flask Blueprint指定template folder无效问题
slug: issue-flask-blueprint-template-folder-not-work-solved
date: 2011-11-29 19:42
tags: [flask, python, sae]
---

收到 [SAEPython][1] 的邀请后,便开始折腾起 [Flask][2] 了,不过在使用 Blueprint 时,发现一个非常诡异的问题

我在 `/greatghoul/1/gmailgadgets/music1g/__init__.py` 中定义了名为 `music1g` 的 `Blueprint`，并指定其 
`template_folder='templates'`

不过当在在 `Blueprint` 中使用 `render_template('index.html')` 时, 在本地测试时可以正确的解析到

`/greatghoul/1/gmailgadgets/music1g/templates/index.html`

但当我提交代码到 SAE 后,访问应用实际取到的结果是

`/greatghoul/1/templates/index.html`

我查看了本地和 SAEPython 上的 Flask 版本,都是 `0.7.2`，在列表和[小组][3]中提问均未得到解决

于是只好硬着头皮看了看 Flask 的源码，采用了一个临时替代的方案：使用 `render_template_string()` 实现 
`render_template()` 来修正这个模板路径的问题。

    music1g = Blueprint('music1g', __name__, 
            url_prefix='/gmailgadgets/music1g',
            static_folder='static', 
            template_folder='templates')
        
    def render_template(template_name, **context):
        template_file = os.path.join(music1g.template_folder, template_name)
        with music1g.open_resource(template_file) as f:
            return render_template_string(f.read().decode('utf-8'), **context)
     
    @music1g.route('/')
    def index():
        return render_template('index.html')

这样可以像原来那样使用 `render_template()` 方法请求模板，以后如果问题修复了，也可以方便的改回来 .

不过不方便的地方就是每个 `Blueprint` 里面都要自己定义一个 `render_template()` 方法，希望 SAEPython 
方早日解决这一问题。

大家可以访问如下地址测试：

<http://greatghoul.sinaapp.com/gmailgadgets/music1g/module/>

[1]: http://readthedocs.org/docs/sae-python/en/latest/ "SAEPython"
[2]: http://flask.pocoo.org/ "Flask"
[3]: http://www.douban.com/group/373262/ "SAE Python 豆辩讨论组"
