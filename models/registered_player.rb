class RegisteredPlayer < Player
   validates :rfid, presence: true

  def self.find_or_create_from_data(data)
    find_by_rfid(data[:rfid]) || create(rfid: data[:rfid])
  end
end