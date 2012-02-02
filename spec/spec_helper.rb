$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems' # Use the gems path only for the spec suite
require 'riak'
require 'riak-cache'
require 'rspec'

# Only the tests should really get away with this.
Riak.disable_list_keys_warnings = true

%w[test_server].each do |file|
  require File.join("support", file)
end

RSpec.configure do |config|
  config.mock_with :rspec

  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true

  if defined?(::Java)
    config.seed = Time.now.utc
  else
    config.order = :random
  end
end
