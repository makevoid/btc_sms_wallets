class ExtApi # external json api
  require "net/http"
  require "json"

  def self.get(url)
    resp = Net::HTTP.get_response URI.parse url
    JSON.parse resp.body
  end
end

class BChain

  HOST = "http://blockchain.info"

  def self.balance(address)
    address = ExtApi.get url "/address/#{address}"
    # other infos: {"n_tx"=>0, "total_received"=>0, "total_sent"=>0, "txs"=>[]}
    (address["final_balance"] * 10**-8).to_f
  end

  def self.url(url_part)
    "#{HOST}#{url_part}?format=json"
  end

end