require 'spec_helper'


class GatewayCallback
  attr_accessor :message
  def sms_send(reply)
    puts "test SMS send: #{reply}"
  end
end

describe GatewayCallback do

  DEFAULT_PARAMS = {"message_id"=>"139173", "text"=>"Callback URL test for user makevoid", "timestamp"=>"1408395151", "from"=>"393491598100"}

  before :all do
    @user_numbers = ["393491598100", "393889058879"]
    @params = DEFAULT_PARAMS
    @user = User.create number: @user_numbers.first
    @recipient = User.create number: @user_numbers.last
    puts "default user address: #{@user.address}"
  end

  before do
    @callback = GatewayCallback.new @params
  end

  it "ERROR a bad message" do
    @callback.handle.should =~ /^ERROR/
  end

  # it "BALANCE" do
  #   @callback.message = "BALANCE"
  #   @callback.handle.should == "Your balance: 0 BTC"
  # end

  it "BALANCE" do
    @callback.message = "BALANCE"
    @callback.handle.should == "Your balance: 0.001 BTC"
  end

  it "SEND" do
    @callback.message = "SEND 0.0001 BTC TO #{@user_numbers.last}"
    @callback.handle.should == "You sent 0.0001 BTC TO #{@user_numbers.last}"
    # check balance?
  end

  # SEND - TODO
  # malformed
  # currency not specified (btc, mbtc ...)
  # not enough money 
  # 

end