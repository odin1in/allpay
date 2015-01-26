require "allpay"

a = Allpay::Client.new(merchant_id: "1037521", key: "yPhcA0G9iPLGnVsv", iv: "12IZiWQWAvMhN7sk")
# a = Allpay::Client.new(merchant_id: 1037521)

p a.get_vaccount(reply_url: "http://google.com", trade_amount: 1000)
# p a.post_cc(trade_amount: 1)
# p a.get_vaccount_callback("XeMYbI2/9Z1p4Xj3XHf96Mo5yYs1khsexkqOCd9Slzd1gTU+12Il3Jxsw3QGMCne1QYnYddwlEbC11KaT/qka0NBikkpZacQpfg9khJBXnUG/DmzoIDuVtjtzExltAvwvxk7luRCK/+TPyANblvZA7VJl/qOzizXia1Mo3zC6acujE/zcvG3xw3Py+POuOW+topoz/kOBDd/N+gSwNuDe3Ry30usiSmGbqxbKB/1jLloywrq+/gSJFCbXTBfBw8pvJvv30YWf7+aanfjhHRT+9OK2mVthIxfV+uwbst626li8lHqvLw7IT6B9hyg1IFTCXLqZgL8Q2Re98gpTGDYkv46o4gj4NzClOhDmpfLp25LTPsCVuFp51bxx2hzVRakEMDkrBr/94xfdAFDU/4A9bvQMXpjpVqDx2DNJyuvIRvbhkVQzymamQQ1IXSa9LiJIji2tQ8D0iMYlaMGi6MhUZyG+ROPs+yPJ6azgD2/g8wW/uV5sbHErYCm6E2SgJjweIJpwepFYUa1LCOJRjJYEEuQv7xvjbPWtMv+e4etupTVHfIpsHENnibRqaEZGKMZlbL5BQImeJTfDiA9g6lTKA4jsUrQe+37XWMRCmJqTwAAb+97fpgrwyaEMd6txtNh")
# p a.get_vaccount[1]

