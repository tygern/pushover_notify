require 'rspec'
require 'spec_helper'

describe MessageValidator do
  let(:message) {
    PushoverNotify::Message.new({
                                  :text => 'hello',
                                  :title => 'this is a title',
                                  :url => 'http://www.google.com',
                                  :url_title => 'Search the web',
                                  :sound => 'bike',
                                  :priority => 1
                                })
  }

  let(:user) {PushoverNotify::User.new key: '12345'}
  let(:message_validator) { PushoverNotify::MessageValidator.new message }

  before(:each) do
    PushoverNotify::MessageValidator.any_instance.stub(:fetch_sounds) { ["echo", "bike"] }
  end

  it 'should not delete valid attributes' do
    valid_message = message_validator.validate

    valid_message.text.should == 'hello'
    valid_message.title.should == 'this is a title'
    valid_message.url.should == 'http://www.google.com'
    valid_message.url_title.should == 'Search the web'
    valid_message.sound.should == 'bike'
    valid_message.priority.should == 1
    end

  it 'should delete invalid attributes' do
    message.sound = 'not a valid sound'
    message.priority = 'not a valid priority'

    valid_message = message_validator.validate

    valid_message.text.should == 'hello'
    valid_message.title.should == 'this is a title'
    valid_message.url.should == 'http://www.google.com'
    valid_message.url_title.should == 'Search the web'
    valid_message.sound.should == nil
    valid_message.priority.should == nil
  end

end