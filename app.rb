require 'json'
require 'sinatra'
require 'sinatra-websocket'
require 'pry'

set :server, 'thin'
set :sockets, []

get '/' do
  erb :index
end

get '/websocket' do
  if request.websocket?
    request.websocket do |ws|
      ws.onopen do
        settings.sockets << ws
      end
      ws.onmessage do |msg|
        json = JSON.parse(msg)
        type, data = json.first, json.last
        bunding.pry
        EM.next_tick { settings.sockets.each {|s| s.send(msg) } }
      end
      ws.onclose do
        warn("websocket closed")
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
