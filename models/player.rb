class Player < ActiveRecord::Base
  scope :without_rfid, lambda { where rfid: nil }

  before_save :set_twitter_name

  private

  def set_twitter_name
    if twitter_name
      twitter_name.prepend('@') unless twitter_name.first == '@'
    end
  end
end