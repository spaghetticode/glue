puts 'create sample match'
%w[maradona falcao bergomi pelè].each do |name|
  DummyPlayer.create twitter_name: name
end

players = Player.all

Match.create(
  player_1: players[0],
  player_2: players[1],
  player_3: players[2],
  player_4: players[3],
  start_at: Time.now - 600,
  end_at:   Time.now
)



puts 'create table settings with default values'
TableSettings.create
