---
slug: 222-capistrano-deploy-js-project
date: '2019-11-27'
layout: post
title: 使用 capistrano 实现本地编译部署 js 项目
tags:
  - Ruby
  - Node.js
issue: 222
---

最近一年多经历了两个前后端分离的产品，捷径社区 [https://sharecuts.cn/](https://sharecuts.cn/) 和电鸭社区 [https://eleduck.com/](https://eleduck.com/)

无一例外，都经历了 build 的烦恼，应用部署时需要 build，耗费很高的 CPU 和内存，但是应用跑起来后并不占用多少资源。这导致每次部署时因为资源占用过高，导致部署过程卡死，甚至影响线上服务的访问。

* 单独为了 build 而升高服务器配置非常不划算，资源不能有效利用
    
* 把 build 结果打到版本库里面直接部署虽然解决了服务器资源的问题，但是会污染版本库
    

为了解决这一情况，受了 ruby china 以前本地编译 assets 然后 rsync 到服务器的处理方法的启发，使用 capistrano 为实现简单的 js 应用部署。大致流程如下。

1. 服务器上建立临时部署目录
    
2. 接取最新代码
    
3. 安装依赖
    
4. 本地执行 build 项目代码
    
5. rsync build 后的代码到服务器临时部署目录
    
6. 临时目录切换为激活目录并重启服务
    

因为小的应用，我们开发用的电脑配置，远远高于服务器配置，本地 build 毫无压力。

要使用 capistrano，首先你需要有 ruby 的环境，安装 ruby 环境可以参考[这篇文章](https://ruby-china.org/wiki/rvm-guide)，本文不作缀述。

在项目的根目录创建一个文件 Gemfile

```ruby
source 'https://gems.ruby-china.com'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
ruby '2.6.3'
gem 'capistrano'
gem 'capistrano-nvm'
```

然后执行以下命令安装依赖

```erb
bundle install
```

安装完成后，初始化 capistrano

```erb
cap install
```

这个命令会生成一些必要的配置文件。

```erb
├── Capfile
├── config
│   ├── deploy
│   │   ├── production.rb
│   │   └── staging.rb
│   └── deploy.rb
└── lib
    └── capistrano
            └── tasks
```

因为依赖中有 nvm，所以我们需要在 Capfile 中启用它

```ruby
# ...

require 'capistrano/nvm’

# ...

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
```

为了实现预统计上传，我们需要在 config/deploy.rb 中配置相关的任务

```ruby
namespace :deploy do
  after 'deploy:updated', 'yarn:install'
  after 'deploy:updated', 'prebuild:clean'
  after 'deploy:updated', 'prebuild:build'
  after 'deploy:updated', 'prebuild:sync'
  after 'deploy:publishing', 'deploy:restart'
end
```

在部署时，拉取应用最新代码到临时版本目录后，会执行以下动作

1. yarn install 安装新的依赖
    
2. 清除本地 build 文件夹，我因为是 nextjs 项目，所以是 .next
    
3. 重新使用 NODE\_ENV=production 进行 build
    
4. rsync build 结果到临时版本目录
    

```ruby
# config valid for current version and patch releases of Capistrano
lock "~> 3.11.2"


set :application, “your_app_name"
set :repo_url, “your git repo"


# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, “/path/to/your/app"

# Default value for :format is :airbrussh.
# set :format, :airbrussh


# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, false

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

append :linked_dirs, "node_modules"

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
set :ssh_options, verify_host_key: :always

set :default_env, {
  'PATH' => "/home/deploy/.nvm/versions/node/v12.6.0/bin:$PATH",
  'NODE_ENV' => 'production'
}

set :nvm_type, :user
set :nvm_node, 'v12.6.0' # change to your node version number
set :nvm_map_bins, %w[node npm yarn pm2 next]
set :nvm_custom_path, "/home/deploy/.nvm/versions/node"
set :nvm_path, "/home/deploy/.nvm"

# pm2 tasks
namespace :pm2 do
  task :start do
    on roles(:app) do
      within shared_path do
        execute :pm2, 'start app.json'
      end
    end
  end


  task :restart do
    on roles(:app) do
      within shared_path do
        execute :pm2, 'reload app.json'
      end
    end
  end


  task :stop do
    on roles(:app) do
      within shared_path do
        execute :pm2, 'stop app.json'
      end
    end
  end
end

namespace :prebuild do
  desc 'Sycning local build to server'
  task :sync do
    on roles(:app), in: :parallel do |role|
      run_locally do
        execute "rsync -avr -e ssh .next #{role.username}@#{role.hostname}:#{release_path}/"
      end
    end
  end

  desc 'Buiding locally'
  task :build do
    on primary(:app) do
      run_locally do
        execute 'NODE_ENV=production yarn build'
      end
    end
  end

  desc 'Cleaning locally build'
  task :clean do
    run_locally do
      execute 'rm -rf .next'
    end
  end
end

namespace :yarn do
  task :install do
    on roles(:app) do
      within release_path do
        execute :yarn, 'install --frozen-lockfile'
      end
    end
  end
end

namespace :deploy do
  after 'deploy:updated', 'yarn:install'
  after 'deploy:updated', 'prebuild:clean'
  after 'deploy:updated', 'prebuild:build'
  after 'deploy:updated', 'prebuild:sync'
  after 'deploy:publishing', 'deploy:restart'

  task :restart do
    invoke 'pm2:restart'
  end

  task :start do
    invoke 'pm2:start'
  end

  task :stop do
    invoke 'pm2:stop'
  end
end
```

具体运行的指令，可以根据自己的应用进行修改，我使用的 pm2 配置如下

`/path/to/your/app/shared/app.json`

```erb
{
  "apps" : [{
    "name": “your_app_name",
    "script": "/path/to/your/app/current/node_modules/.bin/next",
    "args": "start",
    "cwd": "/path/to/your/app/current",
    "exec_interpreter": "/home/deploy/.nvm/versions/node/v12.6.0/bin/node",
    "instances": 1,
    "exec_mode": "cluster",
    "watch": true,
    "env": {
      "NODE_ENV": "production"
    }
  }]
}
```

接下来是配置环境文件。

`config/deploy/production.rb`

```ruby
set :stage, :production
set :branch, 'master'
set :server_name, ‘example.com'
server ‘xxx.xxx.xxx.xx', user: 'deploy', roles: %w{app}, primary: true
```

一切准备就绪。检查一下配置。

```erb
cap production deploy:check
```

填补必要的配置文件，然后就可以执行部署了。

```erb
cap production deploy
```

这个方案不是一个科学的部署方案，因为它依赖于本地的仓库，无法完全自动化，执行前你需要确保

1. 要部署的分支和本地当前的分支的代码是一致的。
    
2. 部署过程中，需要中断本地 dev server，避免 build 文件混乱。
    
3. 只适合我这种服务器配置低，不想为部署额外升级配置的穷人
