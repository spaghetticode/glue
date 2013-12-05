require 'json'
require 'sinatra'
require 'sinatra-websocket'
require 'active_record'
require_relative 'models/match'
require_relative 'models/message_in'



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
        message = MessageIn.new(msg)
        case message.event
        when 'start_match'
          @match = Match.create(message.data)
        when 'update_match'
          @match = Match.last
          @match.update_attributes(message.data)
        when 'close_match'
          @match = Match.last
          @match.close(message.data)
        end
        EM.next_tick do
          settings.sockets.each do |s|
            s.send %([["#{message.event}", #{@match.to_json}]]) # double array, to have same format of the rails app
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