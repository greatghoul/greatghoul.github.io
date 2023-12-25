---
slug: 212-start-rails-devserver-using-rake-task
date: '2019-02-12'
layout: post
title: 使用 rake task 统一管理 rails 开发环境的相关服务和日志
tags:
  - Ruby on Rails
issue: 212
---

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/ee9ab3e6-02a2-4444-b6d2-06a16ebd4aa5)


日常开发 rails 项目的时候，有可能需要通过终端去执行一些临时的任务，比如

```
rails posts:fetch
rails r ‘PullUserProfile.call(7)'
```

这些任务中，日志是打在 `development.log` 里面的，但是通过 `rails s` 启动的 rails 进程的日志中压根看不到这些单独执行的任务中的日志。虽然可以 `tail -f log/development.log` 的方式，但还是稍显麻烦。

复杂一些的项目，可能除了 rails 本身，还会有 sidekiq 的日志，会有测试的日志，你可能要开三四个终端窗口，窗口之间切来切去，又繁琐，又混乱。

我想了一个办法，将所有日志集中在一个终端窗口查看，并且统一管理 rails 和相关服务的进程。

## 启动 rails 开发服务及相关依赖的服务

为了避免开多个终端窗口，我们把 rails 和相关服务都配置为 daemon 模式，这里以 rails 和 sidekiq 为例：

```
sidekiq -d --config config/sidekiq.yml --logfile log/sidekiq.log --pidfile tmp/pids/sidekiq.pid
rails server -d --pid=tmp/pids/server.pid
```

明确的指定 pid 路径，是为了后面杀进程方便。

## 合并查看日志

开发环境启动后，经常要查看 `development.log` 和 `test.log`，为了方便，把它们合并显示。

```
tail -f log/development.log log/test.log log/sidekiq.log
```

## 结束 rails 相关的 daemon 进程

要关闭 rails 开发环境的相关服务，就要用到之前指定的 pid 文件了

```
pkill -F tmp/pids/server.pid
rm -f tmp/pids/server.pid
```

如果你有洁癖，还可以结束掉 spring 和 fsevent\_watch 的进程

```
pkill fsevent_watch
spring stop
```

## 通过 rake tasks 简化命令

像上面那样敲命令是非常繁琐的，所以我把相关的命令做出了一个 rake task.

```ruby
# lib/tasks/dev.rake
namespace :dev do
  def kill_process(pidfile)
    sh "pkill -F tmp/pids/#{pidfile}"
    sh "rm -f tmp/pids/#{pidfile}"
  rescue
  end

  desc 'start dev server and sidekiq'
  task :start => :environment do
    sh 'sidekiq -d --config config/sidekiq.yml --logfile log/sidekiq.log --pidfile tmp/pids/sidekiq.pid'
    sh 'rails server -d --pid=tmp/pids/server.pid'
    Rake::Task['dev:logs'].invoke
  end

  task :stop => :environment do
    kill_process 'sidekiq.pid'
    kill_process 'server.pid'
    sh 'pkill fsevent_watch'
    sh 'spring stop'
  end

  task :logs => :environment do
    sh 'tail -f log/development.log log/test.log log/sidekiq.log'
  end

  task :restart => :environment do
    Rake::Task['dev:stop'].invoke
    Rake::Task['dev:start'].invoke
  end
end
```

然后使用下面的命令来开启和结束服务就可以了。

```
rails dev:start
rails dev:stop
rails dev:logs
rails dev:restart
```

如果你不喜欢 rake task 的形式，也可以自己改写成 shell 脚本或者别的形式，经过上面的修改，rails 开发环境就只需要占用一个终端窗口，很省空间，干净整洁。
