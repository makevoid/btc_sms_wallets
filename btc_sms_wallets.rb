path = File.expand_path '../', __FILE__

require "#{path}/config/env.rb"

class BtcSmsWallets < Sinatra::Base
  include Voidtools::Sinatra::ViewHelpers

  get "/" do
    haml :index
  end
end

require_all "#{path}/routes"