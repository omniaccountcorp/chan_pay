# coding: utf-8

# 客户端

module ChanPay
  class Client

    # 快捷支付的 api
    include ChanPay::Api::SmsPayRequest
    include ChanPay::Api::SmsPayConfirm
    include ChanPay::Api::SmsPayResend
    include ChanPay::Api::WithholdPay
    include ChanPay::Api::QueryOrder
    # 代付代扣的 api
    include ChanPay::Api::QuickDraw
    include ChanPay::Api::QueryQuickOrder
    # 通用 api
    include ChanPay::Api::QueryBalance

    def initialize(options_arg)
      options = Utils.symbolize_keys(options_arg)

      @partner_id = options[:partner_id]
      @seller_id = options[:seller_id]
      @server_uri = URI options[:server_url]
      @private_key = options[:private_key]
      @public_key = options[:public_key]
    end

  end
end
