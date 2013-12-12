puts 'create sample match'
%w[maradona falcao bergomi pelè].each do |name|
  DummyPlayer.create twitter_name: name
end

players = Player.all

now = Time.now
match = Match.create(
  player_1: players[0],
  player_2: players[1],
  player_3: players[2],
  player_4: players[3],
  team_a_score: 6,
  team_b_score: 3
)
match.close
match.update_attributes(start_at: now - 600, end_at: now)


puts 'create table settings with default values'
TableSettings.create
