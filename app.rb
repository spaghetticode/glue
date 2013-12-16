require 'sinatra'
require_relative 'environment'
require 'pry'


set :server, 'thin'
set :sockets, []

enable :sessions
use Rack::Flash, sweep: true
set :session_secret, '*&JHASGDIW%(^B234AJSHD'

if $LOG
  file = File.expand_path('../log/app.log', __FILE__)
  set :logging, true
  log_file = File.new(file, 'a+')
  log_file.sync = true
  $stdout.reopen(log_file)
  $stderr.reopen(log_file)
  puts "Logging to #{file}\n"
end

helpers WillPaginate::Sinatra::Helpers

db_connect


after do
  ActiveRecord::Base.connection.close
end

# homepage, scoreboard with the current match info
get '/' do
  @match = Match.last
  erb :index
end

# websocket url to be called by the browser and table in order
# to update the match
get '/websocket' do
  if request.websocket?
    request.websocket do |ws|
      ws.onopen { settings.sockets << ws }
      ws.onmessage do |msg|
        @manager = MatchManager.new(msg)
        EM.next_tick do
          settings.sockets.each do |s|
            s.send @manager.outbound_message # double array, to keep same format of the rails app
          end
        end
      end
      ws.onclose do
        warn 'websocket closed'
        settings.sockets.delete(ws)
      end
    end
  end
end


# table settings
get '/settings' do
  @settings = TableSettings.current
  erb :'settings/edit', layout: :admin
end

put '/settings/update' do
  @settings = TableSettings.current
  if @settings.update_attributes(params[:table_settings])
    flash[:notice] = 'Table settings updated.'
  else
    flash[:error] = @settings.error_messages.join(', ')
  end
  erb :'settings/edit', layout: :admin
end


# players
get '/players' do
  @players = Player.paginate page: params[:page]
  erb :'players/index', layout: :admin
end

get '/leaderboard' do
  @players = Player.by_won_matches.paginate page: params[:page]
  erb :'players/leaderboard', layout: :admin
end

get '/players/:id/edit' do
  @player = Player.find(params[:id])
  erb :'/players/edit', layout: :admin
end

put '/players/:id' do
  @player = Player.find(params[:id])
  if @player.update_attributes(params[:player])
    flash[:notice] = 'Player data successfully updated.'
  else
    flash[:error] = @player.error_messages.join(', ')
  end
  erb :'players/edit', layout: :admin
end

get '/players/:id' do
  @player = Player.find(params[:id])
  erb :'players/show', layout: :admin
end

delete '/players/:id' do
  @player = Player.find(params[:id])
  if @player.destroy
    flash[:notice] = 'Player successfully removed.'
  else
    flash[:error] = 'Cannot remove this player.'
  end
  redirect '/players'
end
