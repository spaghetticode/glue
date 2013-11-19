class Player < ActiveRecord::Base
  include AutoNaming

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable, :rememberable
  devise :database_authenticatable, :registerable, :recoverable, :trackable, :validatable


  has_many :teams_as_player_1, :class_name => 'Team', :foreign_key => :player_1_id
  has_many :teams_as_player_2, :class_name => 'Team', :foreign_key => :player_2_id


  validates :name, :rfid, presence: true
  validates :rfid, length: {is: 12}, :uniqueness => true

  before_validation :set_dummy_name


  def teams
    Team.where('player_1_id = :id or player_2_id = :id', :id => id)
  end

  private

  def dummy_name
    'john smith'
  end
end
