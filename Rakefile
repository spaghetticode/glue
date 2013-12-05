require 'sinatra'
require 'rspec/core'
require 'rspec/core/rake_task'
require_relative 'models/match'

desc 'Run all specs in spec directory (excluding plugin specs)'
RSpec::Core::RakeTask.new(:spec)

task :environment do
  Sinatra::Application.environment = ENV['RACK_ENV'] || 'development'
end

namespace :db do
  desc 'Migrate the database'
  task migrate: :environment do
    connect
    ActiveRecord::Migrator.migrate('db/migrations')
  end

  desc 'add sample data'
  task seed: :environment do
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

task :default => :spec

def connect
  ActiveRecord::Base.establish_connection(
    adapter:  'sqlite3',
    database: "db/glue_#{Sinatra::Application.environment}.sqlite3"
  )
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  ActiveRecord::Migration.verbose = true
end
