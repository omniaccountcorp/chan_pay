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
  end
end
