require 'json'
require 'rack-flash'
require 'active_record'
require 'sinatra-websocket'
require 'will_paginate'
require 'will_paginate/active_record'
require 'will_paginate/view_helpers/sinatra'
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
