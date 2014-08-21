class Currency < OpenStruct
  CURRENCIES = {
    btc:  Currency.new( name: :btc,  exp: 10**-8 ),
    mbtc: Currency.new( name: :mbtc, exp: 10**-6 ),
  }
end