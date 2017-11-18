# coding: utf-8
module ChanPay
  module Http

    VERSION = '1.0'
    SIGN_TYPE = 'rsa'

    def self.post(partner_id, private_key, public_key, server_uri,
                  service_name, params, time=Time.now)

      body = pack_body(partner_id, private_key, service_name, params, time)

      url_encoded_body = url_encode(body)

      puts "\n[#{service_name}] 发送报文为: \n#{url_encoded_body}\n"

      result = {}

      begin
        response = Net::HTTP.post_form(server_uri, url_encoded_body)

        if response.is_a?(Net::HTTPSuccess) # 返回 200 才处理
          result = Utils.symbolize_keys(JSON.parse(response.body))

          unless Sign::RSA.verify?(public_key, result, result[:Sign])
            # 验签失败, status 状态处于 pending，这样之后再去询问确保
            result[:AcceptStatus] = 'S'
            result[:Status] = 'P'
          end
        else
          # 非 200 请求
          result = RetCode.general_error_response(response.code,
                                                  RetCode::UNKNOWN_ERROR)
        end
      rescue Net::ReadTimeout # 请求超时，当 pending 处理
        result = {
          :AcceptStatus => "S", # 业务受理成功
          :RetCode => RetCode::NET_TIMEOUT,
          :RetMsg => "网络异常（0）",
          :Status => "P", # 业务 PENDING
        }
      end

      puts "\n[#{service_name}] 返回结果为：\n#{result}"

      result
    end

    private

    def self.pack_body(partner_id, private_key, service_name, params, time)
      header = {
        :Service => service_name,
        :Version => VERSION,
        :PartnerId => partner_id,
        :InputCharset => 'UTF-8',
        :TradeDate => time.strftime('%Y%m%d'),
        :TradeTime => time.strftime('%H%M%S'),
      }

      body = params.merge(header)
      sign = Sign::RSA.sign(private_key, body)

      body.merge({:Sign => sign, :SignType => SIGN_TYPE})
    end

    def self.url_encode(body)
      arr = {}
      body.each{ |k, v|
        str = URI.encode_www_form({"test": v})
        arr[k] = str[5, str.size]
      }
      puts {}
      arr
    end

  end
end
