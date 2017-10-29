# coding: utf-8
module ChanPay
  module Http

    module RetCode
      UNKNOWN_ERROR = 'UNKNOWN_ERROR'
      NET_TIMEOUT = 'NET_TIMEOUT'

      def self.general_error_response(http_status, code)
        {
          :AcceptStatus => "F", # 业务受理失败
          :RetCode => code,
          :RetMsg => "网络异常（#{http_status}）",
          :Status => "F", # 业务失败
        }
      end
    end

    module OriginalRetCode
      Codes = {
        "000000" => "成功",
        "111111" => "失败",
        "000001" => "未知",
        "000002" => "已发送",
        "000004" => "已受理",
        "000005" => "错误",
        "000006" => "未受理",
        "000010" => "超时",
        "000050" => "重复",
        "900001" => "无对应批次信息",
        "900002" => "批次下无明细信息",
        "900003" => "无对应明细",
      }

      def self.success?(code)
        ['000000'].include?(code.to_s)
      end

      # 同步代付错误代码
      def self.quick_draw_fail?(code)
        ['111111', '000005', '000006', '000010', '000050'].include?(code.to_s)
      end

      # 订单错误代码
      # TODO(tony): 还需和用友畅捷支付的人沟通确认
      def self.query_quick_order_fail?(code)
        ['111111'].include?(code.to_s)
      end

    end # OriginalRetCode

  end # Http
end # ChanPay
