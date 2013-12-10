class Player < ActiveRecord::Base
  before_save :set_twitter_name

  has_many :matches

  private

  def set_twitter_name
    if twitter_name
      twitter_name.prepend('@') unless twitter_name.first == '@'
    end
  end
end