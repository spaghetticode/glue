class MessageIn
  attr_reader :json

  def initialize(msg)
    @json = JSON.parse(msg)
  end

  def event
    json.first
  end

  def data
    json.last['data']
  end
end
