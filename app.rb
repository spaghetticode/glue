require 'json'
require 'sinatra'
require 'sinatra-websocket'
require 'pry'

set :server, 'thin'
set :sockets, []

matches = []

class Match
  attr_writer   :team_a_score, :team_b_score, :closed
  attr_accessor :player_1, :player_2, :player_3, :player_4

  def initialize(players)
    update(attributes)
  end

  def update(attributes)
    attributes.each do |attribute, value|
      send "#{attribute}=", value
    end
  end

  def close
    self.closed = true
  end

  def closed?
    !!@closed
  end

  def team_a_score
    @team_a_score ||= 0
  end

  def team_b_score
    @team_b_score ||= 0
  end

  def to_json
    %({"player_1": "#{player_1}","player_2": "#{player_2}","player_3": "#{player_3}","player_4": "#{player_4}", "team_a_score": "#{team_a_score}", "team_b_score": "#{team_b_score}", "closed": "#{closed?}"})
  end
end

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
        type, data = json.first, json.last['data']
        case type
        when 'start_match'
          @match = Match.new(data)
          matches << @match
        when 'update_match'
          @match = matches.last
          @match.update(data)
        when 'close_match'
          @match = matches.last
          @match.update(data)
          @match.close
        end
        EM.next_tick do
          settings.sockets.each do |s|
            s.send %([["#{type}", #{@match.to_json}]]) # double array, to have same format of the rails app
          end
        end
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
<script>
$(function() {
  var ws       = new WebSocket('ws://' + window.location.host + '/websocket');
  ws.onopen    = function()  { console.log('websocket opened'); };
  ws.onclose   = function()  { console.log('websocket closed'); }
  ws.onmessage = function(m) {
    json = JSON.parse(m.data)[0];
    window.j = json
    event = json[0];
    match = json[1];
    $('#score_a').text(match.team_a_score);
    $('#score_b').text(match.team_b_score);
    $('#player_1').text('@' + match.player_1);
    $('#player_2').text('@' + match.player_2);
    $('#player_3').text('@' + match.player_3);
    $('#player_4').text('@' + match.player_4);
  }
})
</script>
</body>
</html>