require 'rack-flash'
require 'sinatra-websocket'
Dir['models/*'].each { |file| require_relative file }

def db_connect
  ActiveRecord::Base.establish_connection(
    adapter:  'sqlite3',
    database: "db/glue_#{Sinatra::Application.environment}.sqlite3"
  )
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  ActiveRecord::Migration.verbose = true
end
