# coding: utf-8

# 查询代付代收订单

module ChanPay
  module Api
    module QueryQuickOrder

      SERVICE_NAME = 'cjt_dsf'

      def query_quick_order(flow_id, ori_flow_id)
        params = {
          :TransCode => 'C00000',
          :OutTradeNo => flow_id,
          :OriOutTradeNo => ori_flow_id,
        }

        response = Http.post(@partner_id, @private_key, @public_key, @server_uri, SERVICE_NAME, params)

        res = {
          result: 'P', # 默认 pending
          msg: response[:OriginalErrorMessage] || response[:PlatformErrorMessage],
          ret_code: response[:OriginalRetCode],
          flow_id: flow_id,
          vendor_order_id: response[:FlowNo],
          log: [params.to_json, response.to_json],
        }

        # AcceptStatus 是请求是否成功， PlatformRetCode 是畅捷支付是否受理成功了，OriginalRetCode 是否交易成功，只要看 OriginalRetCode 是否成功即可

        # 受理成功但是结果失败
        if response[:AcceptStatus] == 'S' && Http::OriginalRetCode.query_quick_order_fail?(response[:OriginalRetCode])
          res[:result] = 'F'
        end

        if response[:AcceptStatus] == 'S' && Http::OriginalRetCode.success?(response[:OriginalRetCode])
          res[:result] = 'S'
        end

        res
      end

    end
  end
end
