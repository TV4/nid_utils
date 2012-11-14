require 'simplecov'
require 'simplecov-rcov'
SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
if ENV["COVERAGE"]
  SimpleCov.start do
     add_filter "/.bundle/"
     load_adapter 'test_frameworks'
  end
end
