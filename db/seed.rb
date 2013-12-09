  puts 'create sample match'
  Match.create(
    player_1: 'maradona',
    player_2: 'falcao',
    player_3: 'pelé',
    player_4: 'bergomi',
    start_at: Time.now - 600,
    end_at:   Time.now
  )

  puts 'create table settings with default values'
  TableSettings.create
