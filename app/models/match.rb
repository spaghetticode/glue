class Match < ActiveRecord::Base
  TEAMS_PER_MATCH = 2

  has_one  :winner, :class_name => 'Team'
  has_and_belongs_to_many :teams

  def start
    update_attribute :start_at, Time.zone.now
  end

  def end
    update_attribute :end_at, Time.zone.now
  end

  # this is the way to add players to team, activerecord should not be used
  # directly as it will not limit the players number to PLAYERS_PER_TEAM
  def add_team(team)
    teams << team if teams.size < TEAMS_PER_MATCH
  end
end
