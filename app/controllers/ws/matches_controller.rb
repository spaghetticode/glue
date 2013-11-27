module Ws
  class MatchesController < WebsocketRails::BaseController
    include ActionView::Helpers::SanitizeHelper

    def refresh
      @match = Match.current
      broadcast_message :refresh_match, msg_body: @match.to_json
    end
  end
end