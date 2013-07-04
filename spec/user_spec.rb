require 'rspec'
require 'spec_helper'

describe User do
  let(:user) {PushoverNotify::User.new('12345')}
  let(:android) {PushoverNotify::Device.new('android')}
  let(:nexus) {PushoverNotify::Device.new('nexus')}


  before(:each) do
    PushoverNotify::Notifier.any_instance.stub(:fetch_sounds) { ["echo", "bike"] }
  end

  it 'initializes and returns the correct key' do
    user.key.should == '12345'
  end

  describe 'devices' do
    it 'initializes with an empty list of devices' do
      user.devices.length.should == 0
    end

    it 'accepts devices exactly once through add_device' do
      user.add_device(android)

      user.devices.length.should == 1
      user.has_device?(android).should be_true

      user.add_device(android)
      user.devices.length.should == 1

      user.add_device(nexus)
      user.devices.length.should == 2
      user.has_device?(android).should be_true
      user.has_device?(nexus).should be_true
    end

    it 'knows if it has a device' do
      user.add_device(android)
    end

  end



end

