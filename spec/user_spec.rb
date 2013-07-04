require 'rspec'
require 'spec_helper'

describe User do
  let(:user) {PushoverNotify::User.new('12345')}
  let(:device) {PushoverNotify::Device.new('android')}


  before(:each) do
    PushoverNotify::Notifier.any_instance.stub(:fetch_sounds) { ["echo", "bike"] }
  end

  it 'should initialize and return the correct key' do
    user.key.should == '12345'
  end

end

