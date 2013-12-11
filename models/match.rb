class Match < ActiveRecord::Base
  before_create :set_start_at
  4.times do |n|
    association = :"player_#{n+1}"
    belongs_to association, class_name: 'Player'

    define_method "#{association}_name" do
      send(association).twitter_name or send(association).rfid if send(association)
    end
  end

  def self.create_with_players(params)
    new.tap do |match|
      params.each_pair do |attribute, player_data|
        match.send "#{attribute}=", Player.from_data(player_data)
      end
      match.save
    end
  end

  def update_score(a_or_b)
    return if closed?
    increase_team_score(a_or_b)
    closed? ? close : save
  end

  def close
    update_attribute :end_at, now
  end

  def increase_team_score(a_or_b)
    send "team_#{a_or_b}_score=", send("team_#{a_or_b}_score") + 1
  end

  def closed?
    end_at or (max_goals_reached? and goals_delta_reached? or time_over?)
  end

  def max_goals_reached?
    [team_a_score, team_b_score].max >= settings.goals
  end

  def goals_delta_reached?
    (team_a_score - team_b_score).abs >= settings.advantages
  end

  def settings
    TableSettings.current
  end

  def minutes
    start_at ? ((now - start_at) / 60).floor : 0
  end

  def now
    Time.now
  end

  def time_over?
    settings.max_minutes ? minutes >= settings.max_minutes : false
  end

  def as_json(opts={})
    {
      end_at:   end_at,
      start_at: start_at,
      player_1: player_1_name,
      player_2: player_2_name,
      player_3: player_3_name,
      player_4: player_4_name,
      team_a_score: team_a_score,
      team_b_score: team_b_score,
    }.merge(opts)
  end

  private

  def set_start_at
    self.start_at ||= Time.now
  end
end