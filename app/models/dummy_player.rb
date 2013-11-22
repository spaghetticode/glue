class DummyPlayer < Player
  validates :rfid, uniqueness: true
  # TODO find better way to skip email validation for this subclass
  validates_presence_of :email, :if => Proc.new { false } # no email validation for DummyPlayer
end
