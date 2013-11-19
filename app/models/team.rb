class Team < ActiveRecord::Base
  include AutoNaming

  belongs_to :player_1, :class_name => 'Player'
  belongs_to :player_2, :class_name => 'Player'

  has_many :matches

  validates_presence_of :player_1, :player_2

  private

  def dummy_name
    'foggia'
  end
end