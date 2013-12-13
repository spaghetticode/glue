class MatchManager
  attr_reader :match, :message, :event, :data

  def initialize(msg)
    @json  = JSON.parse(msg)
    @event = @json.first
    @data  = @json.last['data']
    set_match
  end

  def set_match
    case event
    when 'start_match'
      @match = Match.create_with_players(data)
      tweet "#{timestamp} A new match has started! #{twitter_names}"
    when 'update_score'
      @match = Match.last
      @match.update_score(data['team'])
      if @match.closed?
        @event = 'close_match'
        tweet "#{timestamp} Match result: #{@match.team_a_score} - #{@match.team_b_score} #{twitter_names}"
      end
    end
  end

  def outbound_message
    %([["#{event}", #{@match.to_json}]])
  end

  private

  def tweet(msg)
    fork { Social.tweet msg }
  end

  def timestamp
    Time.now.strftime '%H:%M'
  end

  def twitter_names
    "@#{@match.player_1_name}, @#{@match.player_2_name} VS @#{@match.player_3_name}, @#{@match.player_4_name}"
  end
end