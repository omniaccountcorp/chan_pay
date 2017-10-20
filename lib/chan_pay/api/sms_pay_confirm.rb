# coding: utf-8

# 4.4.2.6 支付确认接口（API）

module ChanPay
  module Api
    module SmsPayConfirm

      SERVICE_NAME = 'nmg_api_quick_payment_smsconfirm'

      # 支付确认接口
      #
      # @param flow_id [String] 订单号（需要保证唯一）
      # @param ori_flow_id [String] 原发短信验证码订单号
      # @param sms [String] 验证码
      #
      # @return [Hash] 返回结果集
      #
      def sms_pay_confirm(flow_id, ori_flow_id, sms)
        params = {
          :TrxId => flow_id.to_s, # 最长 32 位唯一订单号
          :OriPayTrxId => ori_flow_id,
          :SmsCode => sms,
        }

        # 这里是明文参数输出
        puts "\n[#{SERVICE_NAME}] 请求参数为：\n#{params.inspect}"

        response = Http.post(@partner_id, @private_key, @public_key, @server_uri, SERVICE_NAME, params)

        res = {
          result: 'P', # 默认 pending
          msg: response[:RetMsg],
          ret_code: response[:RetCode],
          # TODO(tony): 本来这个字段应该是 flow_id，但是目前返回不是，畅捷正在和技术确认中
          # flow_id: response[:TrxId],
          flow_id: flow_id,
          vendor_order_id: response[:OrderTrxid],
          extension: response[:Extension],
          log: [params.to_json, response.to_json],
        }

        # 受理失败 || 受理成功但是结果失败
        if response[:AcceptStatus] == 'F' || (response[:AcceptStatus] == 'S' && response[:Status] == 'F')
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
