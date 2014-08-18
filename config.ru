path = File.expand_path '../', __FILE__


# builder (multi app) version

require "#{path}/btc_sms_wallets"
require "#{path}/admin/sms_wallets_admin"


# require 'rack/lobster'
app = Rack::Builder.new do
  # use Rack::CommonLogger
  # use Rack::ShowExceptions

  map "/admin" do
    # note: disable admin app by commenting this line in production, admin panel is not safe # IMPORTANT!
    run WalletsAdmin
  end

  map "/" do
    run BtcSmsWallets
  end
end

run app

# simple version (no admin panel)

# require "#{path}/btc_sms_wallets"
# run BtcSmsWallets