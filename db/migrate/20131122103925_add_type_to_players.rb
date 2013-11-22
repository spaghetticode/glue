class AddTypeToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :type, :string, :null => false, :default => ''
  end
end
