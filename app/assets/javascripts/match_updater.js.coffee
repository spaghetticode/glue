class @MatchUpdater

  constructor: (urlElement) ->
    url = $(urlElement).data 'wsuri'
    @clock = $('[data-clock]').FlipClock({autoStart: false})
    @dispatcher = new WebSocketRails(url, true)
    @dispatcher.bind 'match_updated', @updateMatch
    @dispatcher.bind 'match_started', @startMatch
    @dispatcher.bind 'match_closed',  @closeMatch

  updateMatch: (data) =>
    match = JSON.parse(data.msg_body)
    $('#player_1').text match.player_1
    $('#player_2').text match.player_2
    $('#player_3').text match.player_3
    $('#player_4').text match.player_4
    $('#score_a').text match.team_a_score
    $('#score_b').text match.team_b_score

  startMatch: (data) =>
    @_startClock()
    @updateMatch(data)

  closeMatch: (data) =>
    @_stopClock()
    @updateMatch(data)

  _startClock: ->
    @clock.setTime 0
    @clock.start()

  _stopClock: -> @clock.stop()





jQuery -> window.poller = new MatchUpdater('#match')
