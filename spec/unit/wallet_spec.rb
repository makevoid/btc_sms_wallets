require 'spec_helper'



describe Wallet do

  it "creates a different valid hdw address for every user" do
    one = Wallet.node_get(1).address
    two = Wallet.node_get(2).address
    one[0].should == "1"
    one.size.should == 34
    two[0].should == "1"
    two.size.should == 34
    one.should_not ==  two
  end
end