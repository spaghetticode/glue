require 'rack-flash'
require 'sinatra-websocket'
Dir['models/*'].each { |file| require_relative file }

def db_connect
  env = Sinatra::Application.environment
  ActiveRecord::Base.establish_connection(
    adapter:  'sqlite3',
    database: "db/glue_#{env}.sqlite3"
  )
  ActiveRecord::Base.logger = Logger.new(STDOUT) unless env == :test
  ActiveRecord::Migration.verbose = true
end
