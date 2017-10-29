# coding: utf-8
require 'chanpay_helper'

describe ChanPay do
  it '设置版本号' do
    expect(ChanPay::VERSION).not_to be nil
  end
end
