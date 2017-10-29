# coding: utf-8

# 单笔同步代付

module ChanPay
  module Api
    module QuickDraw

      SERVICE_NAME = 'cjt_dsf'

      def quick_draw(flow_id,
                     bank_business_name, card_id, true_name,
                     money,
                     business_type='0')

        params = {
          :TransCode => 'T10000',
          :OutTradeNo => flow_id,
          :BusinessType => business_type, # 0=私人，1=公司
          :BankCommonName => bank_business_name,
          :AcctNo => card_id,
          :AcctName => true_name,
          :TransAmt => money,
        }

        # 这里是明文参数输出
        puts "\n[#{SERVICE_NAME}] 请求参数为：\n#{params.inspect}"

        # 敏感字段加密
        params[:AcctNo] = Encrypt::RSA.encrypt(@public_key, card_id)
        params[:AcctName]  = Encrypt::RSA.encrypt(@public_key, true_name)

        response = Http.post(@partner_id, @private_key, @public_key, @server_uri, SERVICE_NAME, params)

        res = {
          result: 'P', # 默认 pending
          msg: response[:OriginalErrorMessage],
          ret_code: response[:OriginalRetCode],
          flow_id: flow_id,
          vendor_order_id: response[:FlowNo],
          log: [params.to_json, response.to_json],
        }

        # AcceptStatus 是请求是否成功， PlatformRetCode 是畅捷支付是否受理成功了，OriginalRetCode 是否交易成功，只要看 OriginalRetCode 是否成功即可

        # 受理失败 || 受理成功但是结果失败
        if response[:AcceptStatus] == 'F' || (response[:AcceptStatus] == 'S' && Http::OriginalRetCode.quick_draw_fail?(response[:OriginalRetCode]))
          res[:result] = 'F'
        end

        if response[:AcceptStatus] == 'S' && Http::OriginalRetCode.success?(response[:OriginalRetCode])
          res[:result] = 'S'
        end

        res
      end

    end # module QuickPay
  end # module Api
end # module Chanpay
