class Match < ActiveRecord::Base
  has_one    :winner, :class_name => 'Team'
  belongs_to :team_a, :class_name => 'Team'
  belongs_to :team_b, :class_name => 'Team'

  validates_presence_of :team_a, :team_b

  default_scope lambda { order 'start_at DESC' }

  delegate :player_1, :player_2, to: :team_a # unfortunately canno delegate also player_3 and 4...

  # this should correspond to created_at, but better being crystal clear
  # about the start/end time.
  def start
    update_attribute :start_at, Time.zone.now
  end

  def end
    update_attribute :end_at, Time.zone.now
  end

  def self.current
    first
  end

  def player_3
    team_b.player_1
  end

  def player_4
    team_b.player_2
  end
end
