require 'sinatra'
require 'rspec/core'
require 'rspec/core/rake_task'
require_relative 'environment'
Dir['models/*'].each { |file| require_relative file }




desc 'Run all specs in spec directory (excluding plugin specs)'
RSpec::Core::RakeTask.new(:spec)

task :environment do
  Sinatra::Application.environment = ENV['RACK_ENV'] || 'development'
end

namespace :db do
  desc 'Migrate the database'
  task migrate: :environment do
    db_connect
    ActiveRecord::Migrator.migrate('db/migrations')
  end

  desc 'add sample data'
  task seed: :environment do
    db_connect
    puts 'create sample match'
    Match.create(
      player_1: 'maradona',
      player_2: 'falcao',
      player_3: 'pelé',
      player_4: 'bergomi',
      start_at: Time.now - 600,
      end_at:   Time.now
    )
    puts 'create table settings with default values'
    TableSettings.create
  end
end

task :default => :spec