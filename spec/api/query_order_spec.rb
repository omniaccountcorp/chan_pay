# coding: utf-8
require 'chanpay_helper'

describe '查询快捷支付的订单状态' do
  it '处理中' do
    result = client.query_order((Time.now.to_f * 1000).to_i, 'xxx')

    puts "\nresult is: \n#{result.inspect}"

    expect(result[:result]).to eq('P')
  end

  it '成功（需要正式账号）'
end
