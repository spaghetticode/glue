class Team < ActiveRecord::Base
  include AutoNaming

  PLAYERS_PER_TEAM = 2

  has_and_belongs_to_many :players

  # this is the way to add players to team, activerecord should not be used
  # directly as it will not limit the players number to PLAYERS_PER_TEAM
  def add_player(player)
    players << player if players.size < PLAYERS_PER_TEAM
  end

  private

  def dummy_name
    'foggia'
  end
end