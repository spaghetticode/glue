class AddWonAndLostToPlayers < ActiveRecord::Migration
  def up
    add_column :players, :won,  :integer, default: 0
    add_column :players, :lost, :integer, default: 0
  end

  def down
    remove_column :players, :won
    remove_column :players, :lost
  end
end