# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pushover_notify/version'

Gem::Specification.new do |spec|
  spec.name          = 'pushover_notify'
  spec.version       = PushoverNotify::VERSION
  spec.authors       = %w(tygern)
  spec.email         = %w(tygern@gmail.com)
  spec.description   = %q{Send notifications to Pushover}
  spec.summary       = %q{Send notifications to Pushover}
  spec.homepage      = 'https://github.com/tygern/pushover_notify/'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = %w(lib)

  spec.required_ruby_version = '>= 2.0.0'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'httparty'
  spec.add_development_dependency 'rspec', '~> 2.13.0'
  spec.add_development_dependency 'artifice'
  spec.add_development_dependency 'json'
end
