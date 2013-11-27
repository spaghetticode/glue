class @WsPoller
  interval = 1000

  constructor: (urlElement) ->
    url = $(urlElement).data 'wsuri'
    @dispatcher = new WebSocketRails(url, true)
    @dispatcher.on_open = @startPolling
    @dispatcher.bind 'refresh_match', @refreshMatch

  startPolling: => setInterval @poll, interval

  poll: => @dispatcher.trigger('refresh_match')

  refreshMatch: (data) =>
    match = JSON.parse(data.msg_body)
    $('#player_1').text match.player_1
    $('#player_2').text match.player_2
    $('#player_3').text match.player_3
    $('#player_4').text match.player_4
    score_a = match.team_a_score
    score_b = match.team_b_score
    $('#score_a').text score_a
    $('#score_b').text score_b
    score = if match.closed then "#{score_a} - #{score_b}" else ''
    $('#final_score').text score



jQuery -> window.poller = new WsPoller('#match')
