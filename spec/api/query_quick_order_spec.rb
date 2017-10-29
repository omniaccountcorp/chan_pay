# coding: utf-8
require 'chanpay_helper'

describe '查询代付代收订单' do
  it '处理中' do
    result = quick_client.query_quick_order((Time.now.to_f * 1000).to_i,
                                            'ori_flow_id')

    puts "\nresult is: \n #{result.inspect}"

    expect(result[:result]).to eq('P')
  end

  it '成功（需要正式账号）'
end
