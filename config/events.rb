WebsocketRails.setup do |config|
  config.log_internal_events = true
  config.standalone          = false
  config.synchronize         = false
end

WebsocketRails::EventMap.describe do
  subscribe :start_match,   to: Ws::MatchesController, with_method: :start
  subscribe :close_match,   to: Ws::MatchesController, with_method: :close
  subscribe :update_match,  to: Ws::MatchesController, with_method: :update
  subscribe :refresh_match, to: Ws::MatchesController, with_method: :refresh
end

