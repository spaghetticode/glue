module Ws
  class MatchesController < WebsocketRails::BaseController
    include ActionView::Helpers::SanitizeHelper

    def start_match
      @factory = MatchFactory.new(params)
      @factory.save
      broadcast_message :refresh_match, msg_body: match.to_json
      send_message :started, match.to_json
      Social.new.tweet "#{timestamp} A new match has started! #{twitter_names}"

    end

    def close_match
      match.close
      broadcast_message :refresh_match, msg_body: match.to_json
      send_message :closed, match.to_json
      Social.new.tweet "#{timestamp} Match result: #{match.team_a.score} - #{match.team_b.score} #{twitter_names}"
    end

    def update_match
      match.update_score(params)
      broadcast_message :refresh_match, msg_body: match.to_json
      send_message :updated, match.to_json
    end

    private

    def match
      @match ||= Match.current
    end

    def params
      message
    end

    def timestamp
      Time.now.strftime '%H:%M'
    end

    def twitter_names
      "#{match.player_1.twitter_name}, #{match.player_2.twitter_name} VS #{match.player_3.twitter_name}, #{match.player_4.twitter_name}"
    end
  end
end