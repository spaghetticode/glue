[Match, Team, Player].each do |klass|
  klass.delete_all
end


[
  ['andrea@spaghetticode.it', 'secret123', 'andrea longhi'],
  ['nicola@spaghetticode.it', 'secret123', 'nicola racco'],
  ['ivan@spaghetticode.it', 'secret123', 'ivan prignano'],
  ['jeko@spaghetticode.it', 'secret123', 'stefano guglielmetti']
].each do |arr|
  email, passwd, name = arr
  RegisteredPlayer.create!(
    :email                 => email,
    :password              => passwd,
    :password_confirmation => passwd,
    :name                  => name,
    :rfid                  => SecureRandom.base64(8)
  )
end

team_a = Team.create! :player_1 => Player.first, :player_2 => Player.scoped[1]
team_b = Team.create! :player_1 => Player.scoped[2], :player_2 => Player.scoped[3]

Match.create! :team_a => team_a, :team_b => team_b, :team_a_score => 3, :team_b_score => 5