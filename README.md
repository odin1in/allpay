# Allpay

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'allpay'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install allpay

## Usage

    allpay = Allpay::Client.new( merchant_id, key: key_for_vaccount, iv: iv_for_vaccount)

    allpay.get_vaccount(options)

    options below:
    * are required

    merchant_trade_no -- Default is random 20 digits
    merchant_trade_date -- Defalt is current time
    trade_amount -- Default is 10000
    expire_date -- Default is 7
    bank_name -- Default is CHINATRUST
    *reply_url -- Default is empty
    remark -- Default is empty



## Contributing

1. Fork it ( https://github.com/odin1in/allpay/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
