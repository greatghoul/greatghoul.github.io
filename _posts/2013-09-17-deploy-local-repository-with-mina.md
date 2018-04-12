---
layout: post
title: 使用Mina部署本地仓库的Rails应用
slug: deploy-local-repository-with-mina
date: 2013-09-17 16:41
tags: [rails, mina]
---

众所周知，[mina] 是一个非常方便的 Rails 应用部署工具，简单一条命令就可以完成应用部署，
并且相比 [capistrano] 更加易于学习和使用。但是 mina 不像 cap 那样，[支持使用本地仓库部署][1]

我们公司的 Rails 代码仓库在公司局域网中，而要部署 Rails 的服务器却访问不到这个局域网中的仓库，
VPN 应该能够解决，但是太麻烦，所以只能寻找其它解决方法。

mina 虽然不支持原生的本地仓库部署，但我们可以使用一些绕路的方式，虽然稍微麻烦一些，但是还是能
在付出较小代价的情况下将本地仓库的 Rails 应用通过 mina 部署到外部服务器上去。

这个 [issue] 中提到的解决方法给了很好的指引，**我们可以先在服务上建立一个临时的仓库，然后在部署前
将本地代码 push 到这个临时仓库时，然后以服务器上的这个仓库作为部署的仓库来拉代码。**

建立临时仓库
-----------------------

登陆到要部署应用的服务器上建立一个临时的仓库

    ssh username@servername -p 2222
    mkdir -p /path/to/your/repository.git
    cd /path/to/your/repository.git
    git init --bare

添加临时仓库
--------------

将服务器上的的临时仓库添加到本地仓库的 remote 中

    git remote add server ssh://username@servername:2222/path/to/your/repository.git

修正 deploy 配置
------------------

然后你就可以修改 `config/deploy.rb` 将服务器上的临时仓库作为部署的仓库了

    set :repository, '/path/to/your/repository.git'

当然，我们还有件重要的事，在执行部署前将本地的代码推送到临时仓库中

修改 `config/deploy.rb` 定义如下的 task

    desc "Push repository to the remote server"
    task :before_clone do
        system "git push server #{branch}"
    end

然后在部署前调用这个 task

    desc "Deploys the current version to the server."
    task :deploy => :environment do
      deploy do
        # Put things that will set up an empty directory into a fully set-up
        # instance of your project.
        invoke :before_clone # <-- push本地仓库到服务器

        invoke :'git:clone'
        invoke :'deploy:link_shared_paths'
        invoke :'bundle:install'
        invoke :'rails:db_migrate'
        invoke :'rails:assets_precompile'

        to :launch do
          # queue "touch #{deploy_to}/tmp/restart.txt"
          queue "service httpd restart"
        end
      end
    end

做完这些，你就可以开始你熟悉的 `mina deploy` 了！

[1]: http://stackoverflow.com/a/5538027/260793
[issue]: https://github.com/nadarei/mina/issues/54
[mina]: https://github.com/nadarei/mina
[capistrano]: https://github.com/capistrano/capistrano/

