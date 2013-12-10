require_relative 'player'

class DummyPlayer < Player
  validates :twitter_name, presence: true
end