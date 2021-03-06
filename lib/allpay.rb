require "allpay/version"

require "base64"
require 'open-uri'
require "nori"
require "gyoku"
require "addressable/uri"
require "openssl"
require "securerandom"

module Allpay
  class Client
    attr_accessor :merchant_id, :rest, :http, :api, :all_key, :all_iv, :key, :iv

    def initialize(options = {})

      if options[:merchant_id].to_i == 2000132
        @merchant_id = 2000132
        @key = "ejCk326UnaZWKisg"
        @iv = "q9jcZX8Ib9LM8wYk"
        @api = 'pay-stage.allpay.com.tw'
      else
        @merchant_id = options[:merchant_id]
        @key = options[:key]
        @iv = options[:iv]
        @api = 'pay.allpay.com.tw'
      end
    end

    def get_vaccount(options = {})
      has_key?
      enc_data = Client.encrypt_data(@key, @iv, {
        'MerchantID' => merchant_id,
        'MerchantTradeNo' => options[:merchant_trade_no] ||  SecureRandom.hex(10),
        'MerchantTradeDate' => options[:merchant_trade_date] || Time.now.strftime('%Y/%m/%d %H:%M:%S'),
        'TradeAmount' => options[:trade_amount] || 0,
        'ExpireDate' => options[:expire_date] || '7',
        'BankName' => options[:bank_name] || "CHINATRUST",
        'ReplyURL' => options[:reply_url] || "",
        'Remark' => options[:remark] || "",
      })

      begin
        result = Client.parse_xml(get('/payment/Srv/gateway', {"MerchantID" => merchant_id, "PaymentType" => "vAccount", "XMLData" => enc_data}))
      rescue => e
        response = e
      end

      [result["RtnCode"].to_i, result]
    end

    def get_vaccount_callback(xmldata)
      has_key?
      result = Client.decrypt_data(@key, @iv, xmldata)
      [result["RtnCode"].to_i, result]
    end

    def self.decrypt_data(key, iv, data)
      cipher = OpenSSL::Cipher::AES128.new(:CBC).decrypt
      cipher.key = key
      cipher.iv = iv
      Client.parse_xml(cipher.update(Base64.decode64(data.gsub(" ","+"))) + cipher.final)
    end

    def self.encrypt_data(key, iv, data)
      data = Gyoku.xml({"Root" => { "Data" => data}})
      cipher = OpenSSL::Cipher::AES128.new(:CBC).encrypt
      cipher.key = key
      cipher.iv = iv

      Base64.encode64(cipher.update(data) + cipher.final).gsub("\n","")
    end

    def self.parse_xml(data)
      Nori.new.parse(data)["Root"]["Data"]
    end
    private

    def has_key?
      if @key.nil? || @iv.nil?
        raise "You should set Key, and Iv for vaccount"
      end
    end

    def get(path, params = {})
      uri = Addressable::URI.new
      uri.query_values = params
      open("https://#{api}/#{path}?#{uri.query}").read
    end

  end
end
