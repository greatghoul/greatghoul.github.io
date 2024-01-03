---
slug: 225-rspec-optional-loading-files
date: '2020-08-20'
layout: post
title: RSpec 根据命令行参数选择性的加载
tags:
  - Ruby on Rails
  - RSpec
issue: 225
---

在运行 rspec 是，如果希望在指定了特定的命令行参数是才加载某个文件，或者执行某段代码，可以在代码中用 ARGV 来进行检测。

比如

```
rspec --format Rswag::Specs::SwaggerFormatter
```

我希望在指定了 Rswag::Specs::SwaggerFormatter 时加载一个特定的 after hook，可以用下面的方式。

```ruby
module SwaggerDocSupport
  extend ActiveSupport::Concern

  included do
    after do |example|
      # ...
    end
  end
end

RSpec.configure do |config|
  if ARGV.include?('Rswag::Specs::SwaggerFormatter')
    config.include SwaggerDocSupport, swagger_doc: true
  end
end
```
