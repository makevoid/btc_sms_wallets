class BtcSmsWallets < Sinatra::Base
  get "/" do
    haml :index
  end
end