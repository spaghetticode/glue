class Player < ActiveRecord::Base
  include AutoNaming


  has_many :teams_as_player_1, :class_name => 'Team', :foreign_key => :player_1_id
  has_many :teams_as_player_2, :class_name => 'Team', :foreign_key => :player_2_id


  validates :name, presence: true
  validates :rfid, presence: true, length: {is: 12}

  before_validation :set_dummy_name

  def teams
    Team.where('player_1_id = :id or player_2_id = :id', :id => id)
  end
end