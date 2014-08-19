require 'spec_helper'


class GatewayCallback
  attr_accessor :message
  def sms_send(reply)
    puts "test: #{reply}"
  end
end

describe GatewayCallback do

  DEFAULT_PARAMS = {"message_id"=>"139173", "text"=>"Callback URL test for user makevoid", "timestamp"=>"1408395151", "from"=>"9991234567"}

  before :all do
    @user_numbers = ["9991234567"]
    @params = DEFAULT_PARAMS
    @user = User.create number: @user_numbers.first
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

end