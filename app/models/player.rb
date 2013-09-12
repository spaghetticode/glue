class Player < ActiveRecord::Base
  include AutoNaming

  validates :name, :rfid, presence: true
  validates :rfid, length: {is: 12}

  before_validation :set_dummy_name

  private

  def set_dummy_name
    self.name = dummy_name unless name.present?
  end

  def dummy_name
    'john smith'
  end
end
