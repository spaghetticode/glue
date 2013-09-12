class Team < ActiveRecord::Base
  include AutoNaming

  private

  def dummy_name
    'foggia'
  end
end
