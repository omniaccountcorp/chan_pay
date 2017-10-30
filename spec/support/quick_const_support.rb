# coding: utf-8
# 代付代扣相关常量

module QuickConstSupport
  def quick_server_url
    'https://pay.chanpay.com/mag-unify/gateway/receiveOrder.do'
  end

  def quick_partner_id
    '200001160102' # 测试
  end

  def quick_seller_id
    ''
  end

  def quick_private_key
    # 测试
    <<-EOF
-----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgQDQeXEOaX/kBxfWdvg46wF7LXcUByQx8q54tTx4oylZ+VR8v/jj
YhFMEneZ8dXf1vprWCscnOh4jfuZYFkgeQxYpsmAojiJ4d7RkLTfqTfwLRNHYTIe
CfTV2ndFxHrSz0YJme/eTv7GWU5wN8qOeDQark9fYo2H674tCVX9wWPYJQIDAQAB
AoGARXUgqMeXl5aRZ5/tpbEOpkaIlQCoG4gafxcLFbpuzY5XitS/DKsgzjKc7Ip5
UoGin18Zxge1IG1VtU03hK0v4kNOs8d6+AjTA3iBtZWMIlFLoLiAzHnSCcc0jV35
OuQYabN+5ZtdvQBP1ZyHnKSsc3pWlLs8hhKBVmBnr8HP5UECQQDztJhlMTkf9Hg8
6rH+3oRPiKvbRK/ms7T1WnKy7BAQMKjo1BGAAbxGrCYgVY+LRAp24BsV3mQMMkAC
eWJoLHi1AkEA2v3YL4lv+FDK2PnEJ811UmXsCEioP27/p1ta7G55PjTcHVQcUdPY
+4n8YPQ50DZNRHWq3abt8+4qRw0wvs+3sQJADOZZTrntSSi6mJbftxr2K/OTDTc0
jGSkxnv0KE5gh0rcFf7rsjflTGReXEXLJFcEqsgwBtdPummKg9cDA3qfJQJAUAaF
UtHJjheQGPwk11q4bdT7DQfoG84nNHQo5M92FOpiKYGMG8bruvfwt0loOxMs50CM
oRUYTZSR9Ib4cjIb8QJBALn+wza4JjiY0T3JgF35G2mVH/heIivrM6YIDmfV7ygI
SfiRnft/PeGP9ObmGEYRApkpT7+eQgQD8HfFVLEm/9c=
-----END RSA PRIVATE KEY-----
    EOF
  end

  def quick_public_key
    <<-EOF
-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDPq3oXX5aFeBQGf3Ag/86zNu0VICXmkof85r+DDL46w3vHcTnkEWVbp9DaDurcF7DMctzJngO0u9OG1cb4mn+Pn/uNC1fp7S4JH4xtwST6jFgHtXcTG9uewWFYWKw/8b3zf4fXyRuI/2ekeLSstftqnMQdenVP7XCxMuEnnmM1RwIDAQAB
-----END PUBLIC KEY-----
    EOF
  end

  def quick_client
    @quick_client ||= ChanPay::Client.new(partner_id: quick_partner_id,
                                          seller_id: quick_seller_id,
                                          server_url: quick_server_url,
                                          private_key: quick_private_key,
                                          public_key: quick_public_key)
  end
end
