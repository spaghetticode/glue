class Team < ActiveRecord::Base
  include AutoNaming

  PLAYERS_PER_TEAM = 2

  has_and_belongs_to_many :players

  def add_player(player)
    players << player if players.size < PLAYERS_PER_TEAM
  end

  private

  def dummy_name
    'foggia'
  end
end