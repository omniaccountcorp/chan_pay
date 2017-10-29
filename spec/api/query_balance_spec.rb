# coding: utf-8
require 'chanpay_helper'

describe '查询帐户余额' do
  it '失败' do
    result = client.query_balance((Time.now.to_f * 1000).to_i)

    puts "\nresult is: \n#{result.inspect}"

    expect(result[:result]).to eq('F')
    expect(result[:balance]).to eq(0)
  end

  it '成功（需要正式账号）'
end
