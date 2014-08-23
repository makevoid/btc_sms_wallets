class Currency < OpenStruct
  CURRENCIES = {
    btc:  Currency.new( name: :btc,  exp: 10**-8, label: "BTC"  ),
    mbtc: Currency.new( name: :mbtc, exp: 10**-6, label: "mBTC" ),
  }

  def curr_to_satoshi(amount)
    amount.to_f * self.exp
  end
end