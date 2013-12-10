class RegisteredPlayer < Player
   validates :rfid, presence: true
end