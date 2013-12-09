class Player < ActiveRecord::Base
  scope :without_rfid, lambda { where rfid: nil }
end