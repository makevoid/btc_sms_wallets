require_relative "utils/monkeypatches"


class Api # btc api

  def initialize(address)
    @address = address
  end

  def balance_self
    bal = balance @address
    Sms.deliver Views.balance bal
  end

  def balance(address)
    bal = BChain.balance address
    Sms.deliver Views.balance bal
  end

  def deliver(amount, number)
    Sms.deliver Views.send_confirmation amount, number
  end

  def history # (self)
    history = BChain.history address
    Sms.deliver Views.history history
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

end