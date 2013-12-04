require 'json'
require 'sinatra'
require 'sinatra-websocket'

set :server, 'thin'
set :sockets, []

require_relative 'match'
require_relative 'message_in'


matches = []


get '/' do
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

__END__
@@ index
<!DOCTYPE html><html lang="en">
<head>
  <meta charset="utf-8" />
  <title>Biliarduino</title>
  <link href="/css/match.css" media="all" rel="stylesheet" />
  <script src="/js/jquery.js"></script>
  <script src="/js/match.js"></script>
</head>
<body>
  <div data-wsuri="localhost:3000/websocket" id="match">
    <div data-clock="true" id="clock"></div>
    <div class="flexcontainer">
      <section id="set-1">
        <div class="hi-icon-wrap hi-icon-effect-1 hi-icon-effect-1a">
          <a class="hi-icon" href="#set-1" id="score_a"></a>
          <ul>
            <li class="player" id="player_1"></li><li class="player" id="player_2"></li>
          </ul>
        </div>
      </section>
      <section id="set-2"><div class="hi-icon-wrap hi-icon-effect-2 hi-icon-effect-2a">
        <a class="hi-icon" href="#set-2" id="score_b"></a>
        <ul>
          <li class="player" id="player_3"></li><li class="player" id="player_4"></li>
        </ul>
      </div>
    </section>
  </div>
</div>
<footer><p>&copy; <a href="https://www.mikamai.com">MIKAMAI 2013</a></p></footer>
</body>
</html>