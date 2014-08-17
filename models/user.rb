class User

  # authentication

  property :id, Serial
  property :country_code, String, length: 4
  property :sms_number,   String, length: 20
  property :address,      String
  property :created_at,   DateTime


  property :balance_cached,   Integer # satoshis

  before :create do
    self.created_at = Time.now
  end


  def balance
    BChain.balance self.address
  end

  def update_balance_cached
    self.balance_cached = balance
    save
  end

end