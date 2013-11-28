class DummyPlayer < Player
  DUMMY_NAMES = YAML.load_file(Rails.root.join('config/dummy_player_names.yml'))
  # dummy players can become regular players, transformation is managed by the admin who update the record
  # adding email, password and then the player can change the password via web interface.

  validates :rfid, uniqueness: true
  # TODO find better way to skip email validation for this subclass
  validates_presence_of :email, :if => Proc.new { false } # no email validation for DummyPlayer

  def self.set_unique_names(players)
    names = DUMMY_NAMES.dup
    players.each do |player|
      name = names.sample
      player.update_attributes :name => name, :twitter_id => name
      names.delete(name)
    end
  end

  def dummy_name
    DUMMY_NAMES.sample
  end
end
