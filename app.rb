require 'sinatra'
require 'active_record'
require 'sinatra-websocket'
Dir['models/*'].each { |file| require_relative file }


set :server, 'thin'
set :sockets, []

ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: 'db/glue.sqlite3',
  pool:     10
)


get '/' do
  @match = Match.last
  erb :index
end

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