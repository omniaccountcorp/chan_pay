# coding: utf-8

# 通用工具类方法

module ChanPay
  module Utils

    # 把 hash 中的 key，都转化为 symbol 类型
    #
    # @param hash [Hash] 需要更改的 hash
    # @return [Hash] 更改后的 hash
    def self.symbolize_keys(hash)
      new_hash = {}
      hash.each do |key, value|
        new_hash[(key.to_sym rescue key) || key] = value
      end
      new_hash
    end

  end
end
