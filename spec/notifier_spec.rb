require 'rspec'
require 'spec_helper'

describe Notifier do
  let(:user) {PushoverNotify::User.new '12345'}

  let(:message) {
    PushoverNotify::Message.new({
                                  :text => 'hello',
                                  :title => 'this is a title',
                                  :url => 'http://www.google.com',
                                  :sound => 'bike',
                                  :priority => 1
                                })
  }

  let(:notifier) {PushoverNotify::Notifier.new user, message}

  before(:each) do
    PushoverNotify::MessageValidator.any_instance.stub(:fetch_sounds) { ["echo", "bike"] }
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
end
