module Ws
  class MatchesController < WebsocketRails::BaseController
    include ActionView::Helpers::SanitizeHelper

    def start
      @factory = MatchFactory.new(params)
      @factory.save
      broadcast_message :refresh_match, msg_body: match.to_json
      send_message :started, match.to_json
    end

    def close
      match.close
      broadcast_message :refresh_match, msg_body: match.to_json
      send_message :closed, match.to_json
    end

    def update
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
  end
end