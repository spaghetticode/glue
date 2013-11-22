class MatchFactory
  (1..4).each do |n|
    player = "player_#{n}"
    attr_accessor player

    define_method  "build_#{player}" do
      rfid = params[player]
      send "#{player}=", Player.find_registered_or_dummy(rfid) || DummyPlayer.new(rfid: rfid)
    end
  end

  attr_accessor :team_a, :team_b, :match

  attr_reader :params

  def initialize(params)
    @params = HashWithIndifferentAccess.new(params)
    build_players
    build_teams
    build_match
  end

  def build_players
    (1..4).each do |n|
      send "build_player_#{n}"
    end
  end

  def build_teams
    self.team_a = Team.find_by_players_or_build(player_1, player_2)
    self.team_b = Team.find_by_players_or_build(player_3, player_4)
  end

  def build_match
    self.match = Match.new(
      team_a:   team_a,
      team_b:   team_b,
      start_at: Time.zone.now
    )
  end

  def save
    save_players and save_teams and save_match
  end
end