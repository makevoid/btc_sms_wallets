class ExtApi # external json api
  require "net/http"
  require "json"

  def self.get(url)
    resp = Net::HTTP.get_response URI.parse url
    JSON.parse resp.body
  end

  def self.post(url, params)
    resp = Net::HTTP.post_form URI.parse(url), params
    JSON.parse resp.body
  end
end

class BChain

  HOST_BASE = "blockchain.info"
  HOST  = "http://#{HOST_BASE}"
  HOSTS = "https://#{HOST_BASE}"

  def self.balance(address)
    address = ExtApi.get url "/address/#{address}"
    # other infos: {"n_tx"=>0, "total_received"=>0, "total_sent"=>0, "txs"=>[]}
    balance_format address
  end

  def self.balance_format(address)
    bal = (address["final_balance"] * 10**-8).to_f
    bal == 0 ? bal.to_i : bal
  end

  def self.transactions(address)
    address = ExtApi.get url "/address/#{address}"
    balance = balance_format address
    transactions = []
    { balance: balance, transactions: transactions }
  end

  def self.url(url_part)
    "#{HOST}#{url_part}?format=json"
  end

  BLOCKCHAIN_KEY = File.read(File.expand_path "~/.blockchain_info_key").strip
  BSWB = File.read(File.expand_path "~/.btc_sms_wallet_blockchain").strip.split(0)
  # TODO: after test, put these in users, crypt password with sms code
  BLOCKCHAIN_GUID = BSWB[0]
  BLOCKCHAIN_PASS = BSWB[1]

  def self.pay(user_id: user_id, password: password, address_to: address_to, amount: amount)
    "#{HOST_S}/merchant/#{user_id}/payment?password=#{password}&to=#{address_to}&amount=#{amount}

" # &note=$note
  end

  # use only to create wallets
  def self.create_wallet(password, id=0)
    api_code = BLOCKCHAIN_KEY
    params = { password: password, api_code: api_code, label: id }
    ExtApi.post url("/api/v2/create_wallet"), params
    # {"guid"=>"foo", "address"=>"1XncTxwcWBYXBqGmedWCQvyBAANFdHJvX", "link"=>"https://blockchain.info/wallet/foo"}
  end

end



    address = ExtApi.get url "/address/#{address}"