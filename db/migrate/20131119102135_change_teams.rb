class ChangeTeams < ActiveRecord::Migration
  def change
    add_column :teams, :player_1_id, :integer
    add_column :teams, :player_2_id, :integer
  end
end
