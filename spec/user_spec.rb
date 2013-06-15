require 'rspec'
require 'spec_helper'

describe User do
  before(:each) do
    PushoverNotify::Notifier.any_instance.stub(:fetch_sounds) { ["echo", "bike"] }
    @user = PushoverNotify::User.new '12345'
  end

  it 'should initialize and return the correct key' do
    @user.key.should == '12345'
  end

end

