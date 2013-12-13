puts 'create sample match'
[
  %w[07003895AF05 falcao],
  %w[0700384595EF maradona],
  %w[0700466BA18B georgebest],
  %w[07003874D398 pelè]
].each do |arr|
  rfid, name = arr
  RegisteredPlayer.create twitter_name: name, rfid: rfid
end

players = Player.all
now = Time.now

5.times do |n|
  match = Match.create(
    player_1: players[0],
    player_2: players[1],
    player_3: players[2],
    player_4: players[3],
    team_a_score: n+5,
    team_b_score: n+3
  )
  match.close
  match.update_attributes(start_at: now - 600 - n*300, end_at: now - n*300)
end

puts 'create table settings with default values'
TableSettings.create
