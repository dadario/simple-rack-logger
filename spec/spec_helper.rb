require 'simplecov'

SimpleCov.start


require 'rspec'
require 'rack/test'
require 'logger'
require_relative '../lib/simple-rack-logger'

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.mock_framework = :rspec
end