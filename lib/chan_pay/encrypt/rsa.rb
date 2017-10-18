# coding: utf-8

module ChanPay
  module Encrypt
    module RSA

      def self.encrypt(key, content)
        rsa_pkey = OpenSSL::PKey::RSA.new(key)
        content_str = rsa_pkey.public_encrypt(content)
        Base64.strict_encode64(content_str)
      end

    end
  end
end
