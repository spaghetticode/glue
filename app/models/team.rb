class Team < ActiveRecord::Base
  DUMMY_NAME = 'foggia'

  validates :name, :presence => true

  before_validation :set_dummy_name

  private

  def set_dummy_name
    self.name = DUMMY_NAME unless name.present?
  end
end
