require 'rspec'
require 'spec_helper'

describe Message do
  before(:each) do
    @message = PushoverNotify::Message.new(
      text: 'hello',
      title: 'this is a title',
      url: 'http://www.google.com',
      sound: 'donkey',
      priority: 3
    )
  end

  it 'should initialize and return the correct attributes' do
    @message.text.should == 'hello'
    @message.title.should == 'this is a title'
    @message.url.should == 'http://www.google.com'
    @message.url_title.should == nil
    @message.sound.should == 'donkey'
    @message.priority.should == 3
  end

  it 'should have the text "" if no text is entered' do
    @empty_message = PushoverNotify::Message.new({})
    @empty_message.text.should == ''
  end
end
