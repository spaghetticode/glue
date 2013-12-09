ENV['RACK_ENV'] = 'test'

require 'rack'
require 'rack/test'
require_relative '../app'

module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end
end

RSpec.configure { |c| c.include RSpecMixin }