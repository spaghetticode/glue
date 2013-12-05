class Match
  attr_writer   :team_a_score, :team_b_score, :closed
  attr_accessor :player_1, :player_2, :player_3, :player_4, :start_at, :end_at

  def initialize(players)
    update(players)
  end

  def update(attributes)
    attributes.each do |attribute, value|
      send "#{attribute}=", value
    end
  end

  def close
    self.closed = true
  end

  def closed?
    !!@closed
  end

  def team_a_score
    @team_a_score ||= 0
  end

  def team_b_score
    @team_b_score ||= 0
  end

  def to_json
    %({"player_1": "#{player_1}","player_2": "#{player_2}","player_3": "#{player_3}","player_4": "#{player_4}", "team_a_score": "#{team_a_score}", "team_b_score": "#{team_b_score}", "closed": "#{closed?}"})
  end
end
