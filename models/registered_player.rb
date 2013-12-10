class RegisteredPlayer < Player
   validates :rfid, presence: true

  def self.find_or_create_from_data(data)
    rfid = data['rfid']
    find_by_rfid(rfid) || create(rfid: rfid)
  end
end