ENV['RACK_ENV'] = 'test'

require 'rack'
require 'rack/test'
require 'database_cleaner'
require_relative '../app'

DatabaseCleaner.strategy = :truncation

module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end
end

RSpec.configure do |config|
  config.before :suite do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :truncation
  end
  config.before:each do
    DatabaseCleaner.start
  end
  config.after :each do
    DatabaseCleaner.clean
  end
  config.include RSpecMixin
end