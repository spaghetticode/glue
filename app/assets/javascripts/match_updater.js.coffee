class @MatchUpdater

  constructor: (urlElement) ->
    url = $(urlElement).data 'wsuri'
    @dispatcher = new WebSocketRails(url, true)
    @dispatcher.bind 'refresh_match', @refreshMatch

  refreshMatch: (data) =>
    console.log 'received data', data
    match = JSON.parse(data.msg_body)
    $('#player_1').text match.player_1
    $('#player_2').text match.player_2
    $('#player_3').text match.player_3
    $('#player_4').text match.player_4
    old_score_a = $('#score_a').text()
    old_score_b = $('#score_b').text()
    $('#score_a').text match.team_a_score
    $('#score_b').text match.team_b_score
    if old_score_a != match.team_a_score
      $('#score_a').trigger 'hover'
    if old_score_a != match.team_a_score
      $('#score_b').trigger 'hover'



jQuery -> window.poller = new MatchUpdater('#match')
