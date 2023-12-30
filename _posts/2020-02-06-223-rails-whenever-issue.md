---
slug: 223-rails-whenever-issue
date: '2020-02-06'
layout: post
title: 记一次排查 rails 项目 whenever 定时任务未运行问题
tags:
  - Ruby on Rails
issue: 223
---


我的 Rails 项目中，设置了如下的 [whenever](https://github.com/javan/whenever/) 定时任务

```ruby
# config/schedule.rb

every 1.hour do
  runner "PostWeightUpdate.call"
end
```

## 添加日志，排查问题

但是奇怪的是，部署到服务器后，定时任务从来都没有运行过。

使用 `crontab -l` 命令查看生成的规则得到如下结果

```erb
0 * * * * /bin/bash -l -c 'cd /home/deploy/eleduck_svc/releases/20200206094503 && bundle exec bin/rails runner -e production '\''PostWeightUpdate.call'\'''
```

尝试直接在服务器运行

```erb
/bin/bash -l -c 'cd /home/deploy/eleduck_svc/releases/20200206094503 && bundle exec bin/rails runner -e production '\''PostWeightUpdate.call'\'''
```

发现是没有问题的，于是给 whenever 加上日志，重新部署。

```ruby
set :output, 'log/whenever.log'

every 1.hour do
  runner "PostWeightUpdate.call"
end
```

任务运行后，查看日志得到以下结果。

```bash
$ cat eleduck_svc/current/log/whenever.log
bundler: failed to load command: bin/rails (bin/rails)
ExecJS::RuntimeUnavailable: Could not find a JavaScript runtime. See https://github.com/rails/execjs for a list of available runtimes.
  /home/deploy/eleduck_svc/shared/bundle/ruby/2.6.0/gems/execjs-2.7.0/lib/execjs/runtimes.rb:58:in `autodetect'
  /home/deploy/eleduck_svc/shared/bundle/ruby/2.6.0/gems/execjs-2.7.0/lib/execjs.rb:5:in `<module:ExecJS>'
  /home/deploy/eleduck_svc/shared/bundle/ruby/2.6.0/gems/execjs-2.7.0/lib/execjs.rb:4:in `<main>'
  /home/deploy/eleduck_svc/shared/bundle/ruby/2.6.0/gems/bootsnap-1.4.4/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:22:in `require'
```

直觉上是环境变量的问题，查了 whenever 的 issue，在下面这个 issue 中，找到了解法。

https://github.com/javan/whenever/issues/714

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/2bfdea1d-9bfc-49a4-b56f-e27bcf070281)

再次修改 `schedule.rb` 重新部署，发现定时任务正常运行了，`whenever.log` 中也不再输出错误日志了。

```ruby
env :PATH, ENV['PATH']
set :output, 'log/whenever.log'

every 1.hour do
  runner "PostWeightUpdate.call"
end
```

## 直接修改 crontab 以方便验证结果

我这个例子中的任务是每个小时执行，如果每次修改后都等一小时去看结果，未免太浪费时间。 所以我选择部署后直接在服务器上修改 crontab 来快速验证。

通过 `crontab -e` 命令用 vim 去修改命令定时任务的时间，比如改成下面这样让它每分钟运行

```erb
*/1 * * * * /bin/bash ....
```

得到验证结果后，再改回去。

记得每次修改完之后，运行 `sudo service cron reload` 来让配置生效。
