require 'rspec'
require 'spec_helper'

describe Notifier do
  before(:each) do
    PushoverNotify::Notifier.any_instance.stub(:fetch_sounds) { ["echo", "bike"] }
    @notifier = PushoverNotify::Notifier.new('12345')
  end

  it 'should initialize and return the correct key and sounds' do
    @notifier.user_key.should == '12345'
    @notifier.sounds.should == ["echo", "bike"]
  end

  describe 'set_request_attributes' do
    it 'should set attributes when passes hashes' do
      @notifier.set_request_attributes({
                                        :message => 'hello',
                                        :title => 'this is a title',
                                        :url => 'http://www.google.com',
                                        :url_title => 'Search the web'
                                      })
      @notifier.request.body.should =~ /message=hello/
      @notifier.request.body.should =~ /title=this%20is%20a%20title/
      @notifier.request.body.should =~ /url=http%3a%2f%2fwww.google.com/
      @notifier.request.body.should =~ /url_title=Search%20the%20web/

      @notifier.set_request_attributes({:message => 'goodbye'})
      @notifier.request.body.should_not =~ /message=hello/
    end

    it 'should not put nil attributes into the request body' do
      @notifier.set_request_attributes({:message => 'hello', :url => nil})
      @notifier.request.body.should =~ /url=(&|$)/
    end

    it 'should not accept an invalid sound' do
      @notifier.set_request_attributes({
                                         :message => 'hello',
                                         :title => 'this is a title',
                                         :url => 'http://www.google.com',
                                         :url_title => 'Search the web',
                                         :sound => 'donkey'
                                       })
      @notifier.request.body.should_not =~ /donkey/
    end
  end
end
