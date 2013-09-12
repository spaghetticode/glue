class Match < ActiveRecord::Base
  has_one :winner, :class_name => 'Team'

  def start
    update_attribute :start_at, Time.zone.now
  end

  def end
    update_attribute :end_at, Time.zone.now
  end
end
