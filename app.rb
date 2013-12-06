require 'sinatra'
require 'rack-flash'
require 'sinatra-websocket'
Dir['models/*'].each { |file| require_relative file }

set :server, 'thin'
set :sockets, []

enable :sessions
use Rack::Flash, sweep: true


ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: "db/glue_#{Sinatra::Application.environment}.sqlite3",
  pool:     10
)

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
    flash[:notice] = "Thanks for signing up!"
  else
    flash[:error] = @settings.error_messages.join(', ')
  end
  erb :'settings/edit', layout: :admin
end