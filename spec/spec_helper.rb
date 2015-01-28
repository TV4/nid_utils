require 'simplecov'
require 'rubygems'
require 'bundler/setup'
require 'rspec'

require 'nid_utils'

RSpec.configure do |config|

  config.mock_with :rspec
  config.color = true

end

