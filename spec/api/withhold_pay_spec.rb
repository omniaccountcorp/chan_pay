# coding: utf-8
require 'chanpay_helper'

describe '快捷代扣' do
  it '失败' do
    result = client.withhold_pay((Time.now.to_f * 1000).to_i,
                                 '430000000000000', 'identity_id',
                                 'XXXXXX', '1380000000', 0.06)

    puts "\nresult is: \n #{result.inspect}"

    expect(result[:result]).to eq('F')
    expect(result[:ret_code]).to eq('ILLEGAL_ARGUMENT')
  end

  it '成功（需要真正的银行卡）'
end
