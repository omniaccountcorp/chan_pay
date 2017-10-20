# coding: utf-8

# 4.2.13 商户余额查询

module ChanPay
  module Api
    module QueryBalance

      SERVICE_NAME = 'cjt_dsf'

      # 商户余额查询
      #
      # @param flow_id [String] 订单号（需要保证唯一）
      #
      # @return [Hash] 返回结果集
      #
      def query_balance(flow_id)
        params = {
          :TransCode => 'C00005',
          :OutTradeNo => flow_id,
        }

        response = Http.post(@partner_id, @private_key, @public_key, @server_uri, SERVICE_NAME, params)

        {
          result: response[:AcceptStatus],
          balance: response[:RecBalance].to_f,
        }
      end

    end
  end
end
