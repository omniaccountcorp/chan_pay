# coding: utf-8

# 4.4.2.14 确认收货接口

module ChanPay
  module Api
    module QueryOrder

      SERVICE_NAME = 'nmg_api_query_trade'

      # 确认收货接口
      #
      # @param flow_id [String] 订单号（需要保证唯一）
      # @param ori_flow_id [String] 原业务订单号
      #
      # @return [Hash] 返回结果集
      #
      def query_order(flow_id, ori_flow_id)
        params = {
          :TrxId => flow_id,
          :OrderTrxId => ori_flow_id,
          :TradeType => 'pay_order',
        }

        response = Http.post(@partner_id,
                             @private_key, @public_key, @server_uri,
                             SERVICE_NAME, params)

        res = {
          result: 'P', # 默认 pending
          msg: response[:RetMsg],
          ret_code: response[:RetCode],
          flow_id: flow_id,
          vendor_order_id: response[:OrderTrxid],
          extension: response[:Extension],
          log: [params.to_json, response.to_json],
        }

        # 因为是查询，所以如果受理失败，状态还是按 P
        if response[:AcceptStatus] == 'F'
          res[:result] = 'P'
        end

        # 受理成功但是结果失败
        if response[:AcceptStatus] == 'S' && response[:Status] == 'F'
          res[:result] = 'F'
        end

        # 受理成功并且结果成功，才是成功
        if response[:AcceptStatus] == 'S' && response[:Status] == 'S'
          res[:result] = 'S'
        end

        res
      end

    end
  end
end
