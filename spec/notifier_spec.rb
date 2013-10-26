require 'rspec'
require 'spec_helper'

describe Notifier do
  let(:user) { PushoverNotify::User.new key: '12345' }


  let(:android) { PushoverNotify::Device.new('android') }
  let(:nexus) { PushoverNotify::Device.new('nexus') }
  let(:notifier) { PushoverNotify::Notifier.new user, message, device: android }

  let(:message) {
    PushoverNotify::Message.new({
                                  :text => 'hello',
                                  :title => 'this is a title',
                                  :url => 'http://www.google.com',
                                  :sound => 'bike',
                                  :priority => 1
                                })
  }

  let(:successful_response) { '{"status":1,"request":"e460545a8b333d0da2f3602aff3133d6"}' }

  let(:unsuccessful_response) do
    '{"user":"invalid","errors":["user identifier is invalid"], "status":0,"request":"3c0b5952fba0ab27805159217077c177"}'
  end

  let(:unsuccessful_response) do
    '{"user":"invalid","errors":["user identifier is invalid"], "status":0,"request":"3c0b5952fba0ab27805159217077c177"}'
  end

  let(:multiple_unsuccessful_responses) do
    '{"user":"invalid","device":"invalid","errors":["user identifier is invalid","device is invalid"], "status":0,"request":"3c0b5952fba0ab27805159217077c177"}'
  end

  before(:each) do
    user.add_device android
    PushoverNotify::MessageValidator.any_instance.stub(:fetch_sounds) { ["echo", "bike"] }
  end

  describe 'initialize' do
    it "allows a user's device to be added" do
      notifier.device_name.should == 'android'
    end

    it 'does not allow a device not belonging to the user to be added' do
      another_notifier = PushoverNotify::Notifier.new user, message, device: nexus
      another_notifier.device_name.should be_nil
    end
  end

  describe 'create_request' do
    before(:each) do
      notifier.create_request
    end
    it 'should set attributes when passes hashes' do
      notifier.request.body.should =~ /message=hello/
      notifier.request.body.should =~ /title=this\+is\+a\+title/
      notifier.request.body.should =~ /url=http%3A%2F%2Fwww.google.com/
    end

    it 'should not put nil attributes into the request body' do
      notifier.request.body.should =~ /url_title(&|$)/
    end
  end

  describe 'send_message' do
    before(:each) do
      notifier.create_request
    end

    it 'handles a successful response' do
      Artifice.activate_with ->(env) do
        if env['PATH_INFO'] == '/1/messages.json' && env['HTTP_HOST'] == 'api.pushover.net'
          [200, {}, successful_response]
        end
      end
      response = notifier.send_message

      response.body.should == successful_response
    end

    it 'raises on an unsuccessful response' do
      Artifice.activate_with ->(env) do
        if env['PATH_INFO'] == '/1/messages.json' && env['HTTP_HOST'] == 'api.pushover.net'
          [403, {}, unsuccessful_response]
        end
      end
      expect {
      notifier.send_message
      }.to raise_exception(RequestUnsuccessfulError, 'user identifier is invalid')
    end

    it 'shows multiple error messages on an unsuccessful response' do
      Artifice.activate_with ->(env) do
        if env['PATH_INFO'] == '/1/messages.json' && env['HTTP_HOST'] == 'api.pushover.net'
          [403, {}, multiple_unsuccessful_responses]
        end
      end
      expect {
      notifier.send_message
      }.to raise_exception(RequestUnsuccessfulError, 'user identifier is invalid, device is invalid')
    end
  end
end
