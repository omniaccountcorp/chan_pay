# ChanPay

用友畅捷支付 API ruby sdk，目前提供以下接口

1. 直接支付请求接口
2. 支付确认接口
3. 短信验证码重发接口
4. 确认收货接口
5. 商户余额查询
6. 快捷代扣请求接口

**说明** 测试中的用例，会因为测试账号的权限问题（畅捷如果改变测试账号权限）导致有些接口测试失败，根据具体返回错误修正即可

## 安装

Gemfile 中增加:

```ruby
gem 'chan_pay'
```

然后执行命令:

    $ bundle

或者直接安装:

    $ gem install chan_pay

## 快速指南

1. 初始化

```ruby
    client = ChanPay::Client.new(
      partner_id: partner_id,
      seller_id: seller_id,
      server_url: server_url,
      private_key: private_key,
      public_key: public_key,
    )
```

2. 调用各个 api，比如查询接口：

```ruby
    client.query_balance(商户自定义唯一订单号)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/chan_pay. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Make a pull request

1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request
6. Please write unit test with your code if necessary.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

