class DummyPlayer < Player
  # dummy players can become regular players, transformation is managed by the admin who update the record
  # adding email, password and then the player can change the password via web interface.

  validates :rfid, uniqueness: true
  # TODO find better way to skip email validation for this subclass
  validates_presence_of :email, :if => Proc.new { false } # no email validation for DummyPlayer
end
