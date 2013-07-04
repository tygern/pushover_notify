require 'rspec'
require 'spec_helper'

describe Notifier do
  let(:user) {PushoverNotify::User.new key: '12345'}


  let(:android) {PushoverNotify::Device.new('android')}
  let(:nexus) {PushoverNotify::Device.new('nexus')}

  let(:message) {
    PushoverNotify::Message.new({
                                  :text => 'hello',
                                  :title => 'this is a title',
                                  :url => 'http://www.google.com',
                                  :sound => 'bike',
                                  :priority => 1
                                })
  }

  before(:each) do
    user.add_device android
    @notifier = PushoverNotify::Notifier.new user, message, device:android
    PushoverNotify::MessageValidator.any_instance.stub(:fetch_sounds) { ["echo", "bike"] }
  end

  describe 'initialize' do
    it "allows a user's device to be added" do
      @notifier.device_name.should == 'android'
    end

    it 'does not allow a device not belonging to the user to be added' do
      another_notifier = PushoverNotify::Notifier.new user, message, device:nexus
      another_notifier.device_name.should be_nil
    end
  end

  describe 'create_request' do
    before(:each) do
      @notifier.create_request
    end
    it 'should set attributes when passes hashes' do
      @notifier.request.body.should =~ /message=hello/
      @notifier.request.body.should =~ /title=this\+is\+a\+title/
      @notifier.request.body.should =~ /url=http%3A%2F%2Fwww.google.com/
    end

    it 'should not put nil attributes into the request body' do
      @notifier.request.body.should =~ /url_title(&|$)/
    end
  end
end
