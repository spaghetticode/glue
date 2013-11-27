WebsocketRails.setup do |config|
  config.log_internal_events = true
  config.standalone          = false
  config.synchronize         = false
end

WebsocketRails::EventMap.describe do
  subscribe :refresh_match, to: Ws::MatchesController, with_method: :refresh
end

