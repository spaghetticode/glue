class Match < ActiveRecord::Base
  has_one    :winner, :class_name => 'Team'
  belongs_to :team_a, :class_name => 'Team'
  belongs_to :team_b, :class_name => 'Team'

  validates_presence_of :team_a, :team_b


  def start
    update_attribute :start_at, Time.zone.now
  end

  def end
    update_attribute :end_at, Time.zone.now
  end
end
