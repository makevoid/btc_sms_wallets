path = File.expand_path '../', __FILE__

require "#{path}/config/env.rb"

class BtcSmsWallets < Sinatra::Base
  include Voidtools::Sinatra::ViewHelpers

  APP_ENV = (ENV["RACK_ENV"] || :development).to_sym


  # sessions

  require 'digest/sha2'
  @@session_secret = Digest::SHA2.hexdigest("dotfile_passphrase") # TODO: put the passphrase in a dotfile
  enable :sessions
  set :session_secret,  @@session_secret


  # dev routes
  if APP_ENV == :development
    get "/migrate" do
      DataMapper.auto_migrate!
      redirect "/"
    end
  end
end

require_all "#{path}/routes"