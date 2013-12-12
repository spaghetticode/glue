class Player < ActiveRecord::Base
  before_save :set_twitter_name, :set_class_type

  scope :by_total_score, lambda { order('total_score DESC') }

  def self.from_data(data)
    const_get(data['type']).find_or_create_from_data data
  end

  def self.remove_at_char(name)
    name[0] == '@' ? name[1..-1] : name
  end

  def name
    twitter_name or rfid
  end

  def increase_total_score(amount)
    self.total_score += amount
    save
  end

  def matches
    Match.where 'player_1_id = :id or player_2_id = :id or player_3_id = :id or player_4_id = :id', id: id
  end

  private

  def set_twitter_name
    if twitter_name
      self.twitter_name = self.class.remove_at_char(twitter_name)
    end
  end

  def set_class_type
    self.type = 'RegisteredPlayer' if rfid.present?
  end
end