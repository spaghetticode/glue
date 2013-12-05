require 'json'
require 'sinatra'
require 'sinatra-websocket'
require 'active_record'
require_relative 'models/match'
require_relative 'models/inbound_message'
require_relative 'models/match_manager'



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
        message = InboundMessage.new(msg)
        @match  = MatchManager.new(message).match
        EM.next_tick do
          settings.sockets.each do |s|
            s.send %([["#{message.event}", #{@match.to_json}]]) # double array, to keep same format of the rails app
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