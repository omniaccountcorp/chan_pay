# coding: utf-8
require 'chanpay_helper'

describe '短信充值确认' do
  it '失败' do
    result = client.sms_pay_confirm((Time.now.to_f * 1000).to_i, 'flow_id',
                                    '666666')

    puts "\nresult is: \n#{result.inspect}"

    expect(result[:result]).to eq('F')
  end

  it '成功（需要真实原 request 订单号）'
end
