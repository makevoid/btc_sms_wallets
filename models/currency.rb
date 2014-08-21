class Currency < OpenStruct
  CURRENCIES = {
    btc:  Currency.new( name: :btc,  exp: 10**-8 ),
    mbtc: Currency.new( name: :mbtc, exp: 10**-6 ),
  }
  
  def curr_to_satoshi(amount)
    amount * self.exp
  end
end