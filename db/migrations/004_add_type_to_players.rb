class AddTypeToPlayers < ActiveRecord::Migration
  def up
    add_column :players, :type, :string
  end

  def down
    remove_column :players, :type
  end
end