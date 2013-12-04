$(function() {
  var ws, json, event, match;
  ws = new WebSocket('ws://' + window.location.host + '/websocket');
  ws.onmessage = function(m) {
    json = JSON.parse(m.data)[0];
    event = json[0];
    match = json[1];
    $('#score_a').text(match.team_a_score);
    $('#score_b').text(match.team_b_score);
    $('#player_1').text('@' + match.player_1);
    $('#player_2').text('@' + match.player_2);
    $('#player_3').text('@' + match.player_3);
    $('#player_4').text('@' + match.player_4);
  }
});