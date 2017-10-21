# coding: utf-8
require 'spec_helper'

describe ChanPay do
  let(:server_url) do
    'https://pay.chanpay.com/mag-unify/gateway/receiveOrder.do'
  end

  let(:partner_id) do
    '200001280051' # 测试
  end

  let(:seller_id) do
    '200001280051' # 测试
  end

  let(:private_key) do
    # 测试

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

  let(:public_key) do
    <<-EOF
-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDPq3oXX5aFeBQGf3Ag/86zNu0VICXmkof85r+DDL46w3vHcTnkEWVbp9DaDurcF7DMctzJngO0u9OG1cb4mn+Pn/uNC1fp7S4JH4xtwST6jFgHtXcTG9uewWFYWKw/8b3zf4fXyRuI/2ekeLSstftqnMQdenVP7XCxMuEnnmM1RwIDAQAB
-----END PUBLIC KEY-----
    EOF
  end

  it '设置版本号' do
    expect(ChanPay::VERSION).not_to be nil
  end

  it '快捷代扣失败' do
    client = ChanPay::Client.new(
      partner_id: partner_id,
      seller_id: seller_id,
      server_url: server_url,
      private_key: private_key,
      public_key: public_key,
    )

    result = client.quick_pay((Time.now.to_f * 1000).to_i,
                              '430000000000000', 'identity_id',
                              'XXXXXX', '1380000000', 0.06)

    expect(result[:result]).to eq('F')
    expect(result[:ret_code]).to eq('ILLEGAL_ARGUMENT')
  end

  # 只要用正确的银行卡信息，就会正常扣款
  it '快捷代扣成功'

  it '查询订单情况' do
    client = ChanPay::Client.new(
      partner_id: partner_id,
      seller_id: seller_id,
      server_url: server_url,
      private_key: private_key,
      public_key: public_key,
    )

    result = client.query_order((Time.now.to_f * 1000).to_i, 'xxx')

    expect(result[:result]).to eq('P')
  end

  it '查询帐户余额' do
    client = ChanPay::Client.new(
      partner_id: partner_id,
      seller_id: seller_id,
      server_url: server_url,
      private_key: private_key,
      public_key: public_key,
    )

    result = client.query_balance((Time.now.to_f * 1000).to_i)

    expect(result[:result]).to eq('S')
    expect(result[:balance] >= 0)
  end

  it '短信充值'

  it '短信确认' do
    client = ChanPay::Client.new(
      partner_id: partner_id,
      seller_id: seller_id,
      server_url: server_url,
      private_key: private_key,
      public_key: public_key,
    )

    result = client.sms_pay_confirm((Time.now.to_f * 1000).to_i, 'xxx', '123456')

    expect(result[:result]).to eq('F') # 因为 xxx 不存在
  end

  it '重发短信' do
    client = ChanPay::Client.new(
      partner_id: partner_id,
      seller_id: seller_id,
      server_url: server_url,
      private_key: private_key,
      public_key: public_key,
    )

    result = client.sms_pay_resend((Time.now.to_f * 1000).to_i, 'xxx')

    expect(result[:result]).to eq('F') # 因为 xxx 不存在
  end
end
