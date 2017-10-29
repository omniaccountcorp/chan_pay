# coding: utf-8
require 'chanpay_helper'

describe '短信充值请求' do
  it '失败' do
    result = client.sms_pay_request((Time.now.to_f * 1000).to_i, 'userid',
                                    'card_id', 'identity_id', 'true_name',
                                    'phone', 100)

    puts "\nresult is: \n#{result.inspect}"

    expect(result[:result]).to eq('F')
  end

  it '成功（需要真实信息）'
end
