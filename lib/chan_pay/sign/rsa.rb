# coding: utf-8
module ChanPay
  module Sign
    module RSA

      def self.sign(key, hash)
        content = link_hash(hash)
        rsa = OpenSSL::PKey::RSA.new(key)
        Base64.strict_encode64(rsa.sign('sha1', content))
      end

      def self.verify?(key, hash, sign)
        content = link_hash(hash)
        rsa = OpenSSL::PKey::RSA.new(key)
        result = rsa.verify('sha1', Base64.strict_decode64(sign), content)
        puts "\nrsa verify：#{result}; 回过来的 sign 为：#{sign}\n" unless result
        result
      end

      private

      def self.link_hash(hash_in)
        hash = Marshal.load Marshal.dump(hash_in)
        hash.delete_if do |key, value|
          key == :Sign || key == :SignType || value.nil? || value == ''
        end
        values = []
        hash.sort.to_h.each{|k,v|
          if v.kind_of?(Hash)
            v = v.to_json
          end
          values << "#{k}=#{v}"
        }

        values.join("&")
      end

    end
  end
end
