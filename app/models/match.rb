class Match < ActiveRecord::Base
  has_one    :winner, :class_name => 'Team'
  belongs_to :team_a, :class_name => 'Team'
  belongs_to :team_b, :class_name => 'Team'

  validates_presence_of :team_a, :team_b

  default_scope lambda { order 'start_at DESC' }

  # this should correspond to created_at, but better being crystal clear
  # about the start/end time.
  def start
    update_attribute :start_at, Time.zone.now
  end

  def end
    update_attribute :end_at, Time.zone.now
  end

  def self.current
    scoped.limit(1).first
  end
end
