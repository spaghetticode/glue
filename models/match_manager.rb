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
    when 'update_match'
      @match = Match.last
      @match.update_attributes(data)
    when 'close_match'
      @match = Match.last
      @match.close(data)
    end
  end

  def outbound_message
    %([["#{event}", #{@match.to_json}]])
  end
end