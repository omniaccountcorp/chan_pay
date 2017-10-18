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
        rsa.verify('sha1', Base64.strict_decode64(sign), content)
      end

      private

      def self.link_hash(hash)
        hash.delete_if do |key, value|
          key == :Sign || key == :SignType || value.nil? || value == ''
        end
        values = []
        hash.sort.to_h.each{|k,v|
          values << "#{k}=#{v}"
        }

        values.join("&")
      end

    end
  end
end
