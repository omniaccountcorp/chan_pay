# coding: utf-8

# 客户端

module ChanPay
  class Client

    include ChanPay::Api::QuickPay
    include ChanPay::Api::QueryOrder

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
