class MatchManager
  attr_reader :match, :message

  def initialize(message)
    @message = message
    set_match
  end

  def set_match
   case message.event
    when 'start_match'
      @match = Match.create(message.data)
    when 'update_match'
      @match = Match.last
      @match.update_attributes(message.data)
    when 'close_match'
      @match = Match.last
      @match.close(message.data)
    end
  end
end