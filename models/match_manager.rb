require 'json'

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
      @match = Match.create(data)
      tweet "#{timestamp} A new match has started! #{twitter_names}"
    when 'update_match'
      @match = Match.last
      @match.update_attributes(data)
    when 'close_match'
      @match = Match.last
      @match.close(data)
      tweet "#{timestamp} Match result: #{match.team_a.score} - #{match.team_b.score} #{twitter_names}"
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
    "@#{match.player_1}, @#{match.player_2} VS @#{match.player_3}, @#{match.player_4}"
  end
end