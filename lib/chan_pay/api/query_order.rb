# coding: utf-8

# 4.4.2.14 确认收货接口

module ChanPay
  module Api
    module QueryOrder

      SERVICE_NAME = 'nmg_api_query_trade'

      def query_order(flow_id, vendor_order_id)
        params = {
          :TrxId => flow_id,
          :OrderTrxId => vendor_order_id,
          :TradeType => 'pay_order',
        }

        response = Http.post(@partner_id, @private_key, @public_key, @server_uri, SERVICE_NAME, params)
      end

    end
  end
end
