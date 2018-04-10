---
title: FactoryGirl 中 create_list 未生效
date: 2015-10-29 23:36 CST
tags:
  - RSpec
  - Ruby On Rails
  - FactoryGirl
---

在 [RSpec] 中使用 [FactoryGirl] 的 `create_list` 批量生成记录时，经常出现记录并未创建的问题。

    let(:posts) { create_list(:post, 3) }

    it 'returns post list' do
      get '/api/v1/posts'
      expect(json.size).to eq 3 # Fail: expect 3, got 0
    end

这里期望是返回长度 3 的，结果返回了 0，本来以为是 FactoryGirl 的 Bug，
并且在官方的 Repo 里面也找到了同样的 [Issue][1]，
但今天仔细查过 RSpec 的文档之后才发现，是自己的用法有错误。

> Note that let is lazy-evaluated: **it is not evaluated until the first time
> the method it defines is invoked**. You can use let! to force the method's
> invocation before each example.
>
> <https://www.relishapp.com/rspec/rspec-core/v/2-5/docs/helper-methods/let-and-let>

也就是说，如果在 `let` 的 block 中使用 `create_list`，除非变量被引用到，
否则 block 的内容并不会被执行，比如上面的例子，在 Example 中并没有引用到 `posts`，
返回的结果自然是 0。

要让 `let` 的 block 在定义时就被执行，需要使用 `let!`

    let!(:posts) { create_list(:post, 3) }

使用时一定要谨慎，切记切记。

[RSpec]: http://rspec.info/
[FactoryGirl]: https://github.com/thoughtbot/factory_girl

[1]: https://github.com/thoughtbot/factory_girl/issues/766