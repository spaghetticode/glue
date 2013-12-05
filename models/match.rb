class Match < ActiveRecord::Base
  # attr_writer   :team_a_score, :team_b_score, :closed
  # attr_accessor :player_1, :player_2, :player_3, :player_4, :start_at, :end_at
  before_create :set_start_at

  def close(attributes)
     update_attributes attributes.merge(end_at: Time.now)
  end

  def closed?
    !!end_at
  end

  def to_json
    %({"player_1": "#{player_1}","player_2": "#{player_2}","player_3": "#{player_3}","player_4": "#{player_4}", "team_a_score": "#{team_a_score}", "team_b_score": "#{team_b_score}", "closed": "#{closed?}"})
  end

  private

  def set_start_at
    self.start_at ||= Time.now
  end
end
