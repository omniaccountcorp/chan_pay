# coding: utf-8

# 4.4.2.18 快捷代扣请求接口（API）

module ChanPay
  module Api
    module WithholdPay

      SERVICE_NAME = 'nmg_api_quickpay_withhold'

      # 快捷代扣
      #
      # @param flow_id [String] 订单号（需要保证唯一）
      # @param card_id [String] 支付银行卡号
      # @param identity_id [String] 身份证号
      # @param true_name [String] 真实姓名
      # @param phone [String] 银行卡预留手机号
      # @param money [String] 支付金额（单位：元，精确到 2 位小数点）
      #
      # @return [Hash] 返回结果集
      #
      def withhold_pay(flow_id, card_id, identity_id, true_name, phone, money)

        params = {
          :TrxId => flow_id.to_s, # 最长 32 位唯一订单号
          :OrdrName => '快捷充值', # 商品名称
          :SellerId => @seller_id, # 畅捷提供的商户编号
          :ExpiredTime => '90m', # 订单有效期
          :BkAcctNo => card_id, # 卡号，需要 rsa 加密
          :IDTp => '01', # 证件类型，01 身份证
          :IDNo => identity_id, # 证件号，rsa 加密
          :CstmrNm => true_name, # 持卡人姓名，rsa 加密
          :MobNo => phone, # 银行预留手机号，rsa 加密
          :TradeType => '11', # 交易类型（即时 11 担保 12）
          :TrxAmt => money.to_s, # 交易金额
          # 'NotifyUrl' => '', # 异步通知地址，可空
          # 'Extension' => '', # 扩展字段，可空
        }

        # 这里是明文参数输出
        puts "\n[#{SERVICE_NAME}] 请求参数为：\n#{params.inspect}"

        # 敏感字段加密
        params[:BkAcctNo] = Encrypt::RSA.encrypt(@public_key, card_id)
        params[:IDNo]     = Encrypt::RSA.encrypt(@public_key, identity_id)
        params[:CstmrNm]  = Encrypt::RSA.encrypt(@public_key, true_name)
        params[:MobNo]    = Encrypt::RSA.encrypt(@public_key, phone)

        response = Http.post(@partner_id, @private_key, @public_key, @server_uri, SERVICE_NAME, params)

        res = {
          result: 'P', # 默认 pending
          msg: response[:RetMsg],
          ret_code: response[:RetCode],
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

    end # module QuickPay
  end # module Api
end # module Chanpay
