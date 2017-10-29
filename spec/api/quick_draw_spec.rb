# coding: utf-8
require 'chanpay_helper'

describe '单笔同步代付' do
  it '失败' do
    result = quick_client.quick_draw((Time.now.to_f * 1000).to_i,
                                     '招商银行', '6226095723553456', '王五',
                                     1)

    puts "\nresult is: \n #{result.inspect}"

    expect(result[:result]).to eq('F')
  end

  it '成功（需要真正的银行卡）'
end
