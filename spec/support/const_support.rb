# coding: utf-8
# 快捷支付相关常量

module ConstSupport
  def server_url
    'https://pay.chanpay.com/mag-unify/gateway/receiveOrder.do'
  end

  def seller_id
    '200001280051' # 测试
  end

  def partner_id
    '200001280051' # 测试
  end

  def private_key
    <<-EOF
-----BEGIN RSA PRIVATE KEY-----
MIICXgIBAAKBgQDM6kPXW49A4ibon0D0gaxbmHrQISJ+k3hb7Z8qhMJ3vb337K/O
ZD/KPngiMiyWBuoJugCvfAxldnvU/oT8TjnZiEshATEtWrE40TFsGMf1eL8ir/6J
jpJzAvsoIJD4O9gu2mV2pekIM/6MmWQ2ls7zTxSFddNwq5dMM4cYFc4ACQIDAQAB
AoGBALFQzd+e5PkaONz2YXiydPjVmwBai8THy1CQ8DgUpUqEL8xHTWHlMaXKJJ5C
mH5CAWblQw6W4wsxWbpXe6/v6PGbwAiHHlL/bADAtuBi49UkFtVEnvnA3SlQCvFn
ODCVjQWeg0S6UzH45ZzcIWVxRAobOF9xVu4qzzaYWCvO2lYZAkEA+XP8IKPRGoqg
5HFixMpFSADrx5Qh+2uHQTs+eo0x6HNdATMMOUCgNYNIwi2KdAf00SwYIXCd2AkR
v8ugRJ/YQwJBANJLCk0o7ZKcjr+sTe+V01RJtL0vxcTLhpaaEXQ0+vZil+yj3GHz
VNzMZ3xlVUL+Mk8hMdDXOELzXfZ1vbgk18MCQQCCuS1fTXm/FvbJwEGqLvWvjgwB
QresMeVnYcyUHHoS/qG2hzHYru1GHc57M7Jiq+i31QuwOnv9QoNypxsN21ZRAkEA
mx5LLPthsuHU0kHxAydLSUNNFLgmc7GFR5XCBiwGarPzSNTd/UqWcIA+XZ4JtG75
ATGFI319vLTzvJbBKRHULQJAJRxg6I9m9u+uaRcxI5SKJapb38HBCwHVYvrSaKDi
MCPLO09hpYJyUTiof7RWaJEruCaANCid/VTxds0wxjWZPQ==
-----END RSA PRIVATE KEY-----
    EOF
  end

  def public_key
    <<-EOF
-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDPq3oXX5aFeBQGf3Ag/86zNu0VICXmkof85r+DDL46w3vHcTnkEWVbp9DaDurcF7DMctzJngO0u9OG1cb4mn+Pn/uNC1fp7S4JH4xtwST6jFgHtXcTG9uewWFYWKw/8b3zf4fXyRuI/2ekeLSstftqnMQdenVP7XCxMuEnnmM1RwIDAQAB
-----END PUBLIC KEY-----
    EOF
  end

  def client
    @client ||= ChanPay::Client.new(partner_id: partner_id,
                                    seller_id: seller_id,
                                    server_url: server_url,
                                    private_key: private_key,
                                    public_key: public_key)
  end
end
