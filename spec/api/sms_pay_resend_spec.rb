# coding: utf-8
require 'chanpay_helper'

describe '短信充值，验证码重复' do
  it '失败' do
    result = client.sms_pay_resend((Time.now.to_f * 1000).to_i, 'flow_id')

    puts "\nresult is: \n#{result.inspect}"

    expect(result[:result]).to eq('F')
  end

  it '成功（需要有一个真正的订单号）'
end
