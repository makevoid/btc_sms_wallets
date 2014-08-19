require 'spec_helper'

describe GatewayCallback do

  before :all do
    @user_numbers = ["9991234567"]
    @params = {"message_id"=>"139173", "text"=>"Callback URL test for user makevoid", "timestamp"=>"1408395151", "from"=>"9991234567"}
  end

  before do
    @callback = GatewayCallback.new @params
  end

  it "handles a received message" do
    @callback.handle
  end

end