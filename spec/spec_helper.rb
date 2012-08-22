$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'quarantino'
require 'rspec'
require 'rspec/autorun'
require 'webmock/rspec'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(File.expand_path('../support', __FILE__), '**/*.rb')].each {|f| require f}

ENV['QUARANTINO_API_KEY'] = 'TEST-API-KEY'

RSpec.configure do |config|
  config.color_enabled = true
end
