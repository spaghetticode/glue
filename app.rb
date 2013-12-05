require 'json'
require 'sinatra'
require 'sinatra-websocket'

set :server, 'thin'
set :sockets, []

require_relative 'match'
require_relative 'message_in'


matches = []


get '/' do
  @match = Match.new(
    :player_1 => 'maradona',
    :player_2 => 'falcao',
    :player_3 => 'pelé',
    :player_4 => 'bergomi',
    :start_at => Time.now - 600,
    :end_at   => Time.now
  )
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
          @match = Match.new(message.data)
          matches << @match
        when 'update_match'
          @match = matches.last
          @match.update(message.data)
        when 'close_match'
          @match = matches.last
          @match.update(message.data)
          @match.close
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