class Team < ActiveRecord::Base
  include AutoNaming

  belongs_to :player_1, :class_name => 'Player'
  belongs_to :player_2, :class_name => 'Player'

  has_many :matches

  validates_presence_of :player_1, :player_2

  def self.find_by_players(p_1, p_2)
    query = 'player_1_id = ? and player_2_id = ? OR player_1_id = ? and player_2_id = ?'
    Team.where(query, p_1.id, p_2.id, p_2.id, p_1.id).first
  end

  def self.find_by_players_or_build(p_1, p_2)
    find_by_players(p_1, p_2) or new(:player_1 => p_1, :player_2 => p_2)
  end
end