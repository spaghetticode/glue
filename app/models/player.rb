class Player < ActiveRecord::Base
  DUMMY_NAME = 'john smith'

  validates :name, :rfid, presence: true
  validates :rfid, length: {is: 12}

  before_validation :set_dummy_name

  private

  def set_dummy_name
    self.name = DUMMY_NAME
  end
end
