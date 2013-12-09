class CreatePlayers < ActiveRecord::Migration
  def up
    create_table :players do |t|
      t.string  :rfid, :twitter_name
    end
  end

  def down
    drop_table :matches
  end
end