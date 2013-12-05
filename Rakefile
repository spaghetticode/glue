require 'active_record'
require_relative '../models/match'

def connect
  ActiveRecord::Base.establish_connection(
    adapter:  'sqlite3',
    database: 'db/glue.sqlite3'
  )
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  ActiveRecord::Migration.verbose = true
end

namespace :db do
  desc 'Migrate the database'
  task :migrate do
    connect
    ActiveRecord::Migrator.migrate('db/migrations')
  end

  desc 'add sample data'
  task :seed do
    connect
    Match.delete_all
    Match.create(
      player_1: 'maradona',
      player_2: 'falcao',
      player_3: 'pelé',
      player_4: 'bergomi',
      start_at: Time.now - 600,
      end_at:   Time.now
    )
  end
end