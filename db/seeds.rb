# destroy all records in the db:
[Match, Team, Player].each { |klass| klass.delete_all }

# build sample players for Codemotion MILAN demo:
[
  ["07003895AF05", "Falcao", "falcao"],
  ["0700466BA18B", "George Best", "georgebest"],
  ["0700384595EF", "Maradona", "maradona"],
  ["07003874D398", "Pelè", "pele"]
].each do |arr|
  rfid, name, twitter_id = arr
  DummyPlayer.create!(
    :name       => name,
    :rfid       => rfid,
    :twitter_id => twitter_id
  )
end

team_a = Team.create! :player_1 => Player.all[0], :player_2 => Player.all[1]
team_b = Team.create! :player_1 => Player.all[2], :player_2 => Player.all[3]
Match.create! :team_a => team_a, :team_b => team_b, :team_a_score => 3, :team_b_score => 5