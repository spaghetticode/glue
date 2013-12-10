require_relative 'player'

class DummyPlayer < Player
  validates :twitter_name, presence: true

  def self.find_or_create_from_data(data)
    name = add_at(data['twitter_name'])
    find_by_twitter_name(name) || create(twitter_name: name)
  end
end