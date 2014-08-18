class BtcSmsWallets < Sinatra::Base

  # head "/callback" do
  post "/callback" do
    # params: {"message_id"=>"139173", "text"=>"Callback URL test for user makevoid", "timestamp"=>"1408395151", "from"=>"9991234567"}
    callback = Callback.new params
    callback.handle
    [200, {}, [""]]
  end

  # debug - todo: spec
  #
  # sc (irb -r ./config/env.rb)
  #
  # msg = {"message_id"=>"139173", "text"=>"Callback URL test for user makevoid", "timestamp"=>"1408395151", "from"=>"9991234567"}
  #
  #

end