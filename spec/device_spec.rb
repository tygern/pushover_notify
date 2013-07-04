require 'rspec'
require 'spec_helper'

describe Device do
  let(:device) {
    PushoverNotify::Device.new('android')
  }

  it 'should initialize and return the correct attributes' do
    device.name.should == 'android'
    device.default.should == {}
  end

  describe 'add_default' do
    it 'should add defaults to the device' do
      device.add_default(:title, 'usual title')
      device.add_default(:sound, 'usual sound')

      device.default[:title].should == 'usual title'
      device.default[:sound].should == 'usual sound'
    end
  end

  describe 'remove_default' do
    it 'should delete default options' do
      device.add_default(:title, 'usual title')
      device.add_default(:sound, 'usual sound')

      device.remove_default(:sound)

      device.default[:title].should == 'usual title'
      device.default[:sound].should == nil
    end
  end
end