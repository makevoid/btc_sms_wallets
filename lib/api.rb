CURRENCY = {
  mbtc: 5,
  btc:  8,
}

class Numeric
  def to_mbtc
    self * (10 ** -CURRENCY[:mbtc])
  end
end

class Api # btc api

  def initialize(address)
    @address = address
  end

  def balance_self
    bal = balance @address
    Sms.send Views.balance bal
  end

  def balance(address)
    bal = BChain.balance address
    Sms.send Views.balance bal
  end

  def send(amount, number)
    Sms.send Views.send_confirmation amount, number
  end

  def history # (self)
    history = BChain.history address
    Sms.send Views.history history
  end

  module Views

    def self.balance(satoshi)
      mbtc = satoshi * (10 ** -6)
      "BALANCE\n" +
        "#{mbtc} mBTC"
      # "(12 EUR)"
      # Last transaction
      # 01-01-2010 10:10
    end

    def self.history(transactions)
      for tx in transactions
        "#{tx}"
      end
    end

    def self.send_confirmation(amount, number)
      amount_mbtc = amount * (10 ** -6)
      "You transferred #{amount_mbtc} mBTC"
    end

  end

  module Parser
    def self.parse
      {
        balance:      /BALANCE/,
        balance_self: /BALANCE\s+(\d+)/, # support also btc addresses
        send:         /SEND\s+(\w+)\s+TO\s+(\d+)/,
        history:      /HISTORY/,
        # TODO: pin protection
      }
    end
  end


end