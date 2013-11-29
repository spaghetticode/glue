WebsocketRails.setup do |config|
  config.log_internal_events = true
  config.standalone          = false
  config.synchronize         = false
end

WebsocketRails::EventMap.describe do
  subscribe :start_match,   to: Ws::MatchesController, with_method: :start_match
  subscribe :close_match,   to: Ws::MatchesController, with_method: :close_match
  subscribe :update_match,  to: Ws::MatchesController, with_method: :update_match
  subscribe :refresh_match, to: Ws::MatchesController, with_method: :refresh_match
end

