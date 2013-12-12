class AddTotalScoreToPlayers < ActiveRecord::Migration
  def up
    add_column :players, :total_score, :integer, default: 0
  end

  def down
    remove_column :players, :total_score
  end
end