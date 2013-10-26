require 'rspec'
require 'rubygems'
require 'bundler'
require 'artifice'

require File.dirname(__FILE__) + '/../lib/pushover_notify'
Dir[File.dirname(__FILE__) + '/../lib/pushover_notify/*.rb'].each {|file| require file }

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.order = 'random'
end

include PushoverNotify