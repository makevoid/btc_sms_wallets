path = File.expand_path '../../', __FILE__
APP = "btc_sms_wallets"

require "bundler/setup"
Bundler.require :default
module Utils
  def require_all(path)
    Dir.glob("#{path}/**/*.rb") do |model|
      require model
    end
  end
end
include Utils

env = ENV["RACK_ENV"] || "development"
DataMapper.setup :default, "sqlite://#{path}/db/sms_wallets_#{env}.sqlite"
# DataMapper.setup :default, "mysql://localhost/btc_sms_wallets_#{env}"
require_all "#{path}/models"
DataMapper.finalize