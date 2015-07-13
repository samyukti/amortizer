require 'bundler/setup'
Bundler.setup

require 'amortizer'

RSpec.configure do |config|
  config.expect_with(:rspec) { |c| c.syntax = :should }
end
