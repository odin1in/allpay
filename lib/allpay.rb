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

    def initialize(merchant_id, options = {})
      @merchant_id = merchant_id
      begin
        env = ENV.try("fetch", "RAILS_ENV")
      rescue
        env = "development"
      end

      if env == 'production'
        @api = 'pay.allpay.com.tw'
      else
        @api = 'pay-stage.allpay.com.tw'
      end
      @key = options[:key]
      @iv = options[:iv]
    end

    def get_vaccount(options = {})
      has_key?
      enc_data = encrypt_data(@key, @iv, {
        'MerchantID' => merchant_id,
        'MerchantTradeNo' => options[:merchant_trade_no] ||  SecureRandom.hex(10),
        'MerchantTradeDate' => options[:merchant_trade_date] || Time.now.strftime('%Y/%m/%d %H:%M:%S'),
        'TradeAmount' => options[:trade_amount] || 10000,
        'ExpireDate' => options[:expire_date] || '7',
        'BankName' => options[:bank_name] || "CHINATRUST",
        'ReplyURL' => options[:reply_url] || "",
        'Remark' => options[:remark] || "",
      })

      begin
        result = parse_xml(get('/payment/Srv/gateway', {"MerchantID" => merchant_id, "PaymentType" => "vAccount", "XMLData" => enc_data}))
      rescue => e
        response = e
      end

      return result
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
      open("http://#{api}/#{path}?#{uri.query}").read
    end

    def encrypt_data(key, iv, data)
      data = Gyoku.xml({"Root" => { "Data" => data}})
      cipher = OpenSSL::Cipher::AES128.new(:CBC).encrypt
      cipher.key = key
      cipher.iv = iv

      Base64.encode64(cipher.update(data) + cipher.final).gsub("\n","")
    end

    def parse_xml(data)
      Nori.new.parse(data)["Root"]["Data"]
    end
  end
end
