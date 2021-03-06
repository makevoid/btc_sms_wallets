class User
  include DataMapper::Resource

  # authentication

  property :id, Serial
  property :country_code,   String, length: 4
  property :number,         String, length: 20, unique: true # cellphone number
  property :number_label,   String, length: 20
  property :address_cache,  String
  property :created_at,     DateTime
  # register to app with sms pass - registers to bc.info - hashes the password - store in db
  property :bc_guid,        String
  property :bc_password,    String

  property :balance_cached,   Integer # satoshis

  has, n :transactions

  before :create do
    self.number_label = self.number
    self.number = self.number.gsub(/\s+/, '')
    self.created_at = Time.now # update_created_at
  end

  after :create do
    self.address_cache = Wallet.node_get id
    self.save
  end

  def address
    Wallet.node_get(id).address
  end

  def balance
    bal = BChain.balance self.address
    self.balance_cached = bal
    self.save
    bal
  end

  def update_balance_cached
    self.balance_cached = balance
    save
  end

  # login

  def self.login_or_create(number)
    unless user = User.first( number: number )
      user = User.create number: number
    end
    user
  end

end