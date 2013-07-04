require 'rspec'
require 'spec_helper'

describe Authentication do
  it '#application_key' do
    PushoverNotify::Authentication::application_key.should_not be_nil
    PushoverNotify::Authentication::application_key.should be_a(String)
  end

  it '#user_key' do
    PushoverNotify::Authentication::user_key.should_not be_nil
    PushoverNotify::Authentication::user_key.should be_a(String)
  end
end