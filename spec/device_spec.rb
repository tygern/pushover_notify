require 'rspec'
require 'spec_helper'

describe Device do
  let(:device) {
    PushoverNotify::Device.new('android')
  }

  it 'should initialize and return the correct attributes' do
    device.name.should == 'android'
  end
end