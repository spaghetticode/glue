class AddTwitterIdToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :twitter_id, :string
  end
end
