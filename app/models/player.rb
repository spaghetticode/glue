class Player < ActiveRecord::Base
  include AutoNaming

  validates :name, :rfid, presence: true
  validates :rfid, length: {is: 12}

  before_validation :set_dummy_name

  has_and_belongs_to_many :teams

  private

  def dummy_name
    'john smith'
  end
end
