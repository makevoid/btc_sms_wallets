class Wallet

  # https://github.com/BitVault/money-tree.git -> hd wallet

  # TODO: in production, pregenerate all client keys (10 thousand)

  WALLET = MoneyTree::Master
  # WALLET = MoneyTree::Node.from_serialized_address NON_MAIN_ADDRESS # higher security level, more info: https://github.com/wink/money-tree#serialized-addresses

  attr_reader :user_id
  attr_reader :wallet
  alias :w :wallet

  def initialize(user_id: user_id, seed: nil)
    @user_id = user_id
    @wallet = WALLET.new  seed_hex: seed
  end

  def self.hdw(user_id: user_id)
    # save and reload seed in user's home in dotfile
    path = File.expand_path "~/.btc_sms_wallet"
    seed = File.read path if File.exist? path

    @@hdw ||= if seed
      new seed: seed,  user_id: user_id
    else
      hdw = new user_id: user_id
      File.open(path, "w"){ |file| file.write hdw.seed }
      hdw
    end

    @@hdw
  end

  # forwarders

  def self.seed
    hdw.seed
  end

  def self.node_get(user_id)
    hdw(user_id: user_id).node_get
  end

  # instance methods

  def seed
    w.seed_hex
  end

  def node_get
    Node.new w.node_for_path "m/0/#{@user_id}"
  end


  class Node

    attr_reader :node

    def initialize(node)
      @node = node
    end

    def address
      @node.to_address
    end

    # TODO: uncomment to enable in public api
    #
    # def private_key
    #   @node.private_key.to_hex
    # end

  end

end