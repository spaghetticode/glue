class Match < ActiveRecord::Base
  before_create :set_start_at

  def update_score(a_or_b)
    return if closed?
    increase_team_score(a_or_b)
    closed? ? close : save
  end

  def close
    self.end_at = now
    save
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

  private

  def set_start_at
    self.start_at ||= Time.now
  end
end