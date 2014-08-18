class Wallet

  # https://github.com/BitVault/money-tree.git -> hd wallet

  # TODO: in production, pregenerate all client keys (10 thousand)

  WALLET = MoneyTree::Master

  attr_reader :user_id
  attr_reader :wallet
  alias :w :wallet

  def initialize(user_id: user_id, seed: nil)
    @user_id = user_id
    @wallet = WALLET.new  seed_hex: seed
  end

  def self.hdw
    @@hdw ||= new
  end

  def self.hdw=(seed)
    @@hdw ||= new seed: seed
  end

  # instance methods

  def seed
    w.seed
  end

  def generate_new_address
    w.node_for_path "m/0/#{@user_id}"
  end

end