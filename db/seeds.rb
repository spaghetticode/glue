# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

[['andrea@spaghetticode.it', 'secret123', 'andrea longhi']].each do |arr|
  email, passwd, name = arr
  Player.create!(
    :email                 => email,
    :password              => passwd,
    :password_confirmation => passwd,
    :name                  => name,
    :rfid                  => SecureRandom.base64(8)
  )
end

