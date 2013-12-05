require 'active_record'
class Match < ActiveRecord::Base
  before_create :set_start_at

  def close(attributes)
     update_attributes attributes.merge(end_at: Time.now)
  end

  def closed?
    !!end_at
  end

  private

  def set_start_at
    self.start_at ||= Time.now
  end
end
